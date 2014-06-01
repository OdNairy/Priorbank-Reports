//
//  RGNetworkManager.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGNetworkManager.h"
#import "NSString+RGCrypto.h"
#import "RXMLElement.h"
#import "RGTransaction.h"

static NSTimeInterval kNetworkTimeout = 30;
static NSString *kServerAPIURL = @"https://www.prior.by/api/";

NSURL *serverURL() {
    return [NSURL URLWithString:kServerAPIURL];
}

NSURL *actionURL(NSString *action) {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", serverURL(), @"ibapi.axd?action=", action];
    return [NSURL URLWithString:urlString];
}

NSMutableURLRequest *urlRequestFromURL(NSURL *url) {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                            timeoutInterval:kNetworkTimeout];
    [request setValue:@"Priorbank client/1.1" forHTTPHeaderField:@"User-Agent"];
    if ([url.absoluteString isEqualToString:[actionURL(@"GateWay") absoluteString]]) {
        [request setValue:@"XML" forHTTPHeaderField:@"Base64Fields"];
    }
    return request;
}

@implementation RGNetworkManager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static RGNetworkManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[RGNetworkManager alloc] init];
    });
    return sharedManager;
}

- (void)removeCookiesForURL:(NSURL *)url {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [storage cookiesForURL:url];
    for (NSHTTPCookie *cookie in cookies) {
        [storage deleteCookie:cookie];
    }
}

- (void)initialSetupForServerToken:(void (^)(NSString *serverToken, NSError *er))block {
    NSAssert(block != nil, @"Block must exist on this function.");
    NSURL *url = actionURL(@"setup");
    [self removeCookiesForURL:url];

    NSURLRequest *urlRequest = urlRequestFromURL(url);

    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *serverToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        block(serverToken, connectionError);
    }];
}

- (void)signinWithLoginName:(NSString *)loginName passwordHash:(NSString *)passwordHash serverToken:(NSString *)serverToken completionBlock:(void (^)(NSData *, NSError *))completionBlock {
    NSParameterAssert(loginName.length > 0);
    NSParameterAssert(passwordHash.length > 0);
    NSParameterAssert(serverToken.length > 0);

    NSString *clientToken = [serverToken encryptByPriorKeys];
    NSString *body = [NSString stringWithFormat:@"&UserName=%@&UserPassword=%@&Token=%@", loginName, passwordHash,
                                                clientToken];

    NSURL *url = actionURL(@"login");
    NSMutableURLRequest *urlRequest = [urlRequestFromURL(url) mutableCopy];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (completionBlock) {
            completionBlock(data, connectionError);
        }

    }];

//    NSLog(@"loginName = %@", loginName);
//    NSLog(@"passwordHash = %@", passwordHash);
//    NSLog(@"clientToken = %@", clientToken);
}

- (void)cardList:(RGResponseBlock)completionBlock{
    NSParameterAssert(completionBlock);
    
    NSMutableURLRequest* urlRequest = urlRequestFromURL(actionURL(@"GateWay"));
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[@"Template=CardList" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (completionBlock) {
            completionBlock(data, connectionError);
        }
    }];
}

- (void)transactionsForCardId:(NSString *)cardId from:(NSDate *)fromDate to:(NSDate *)toDate completionBlock:(void (^)(NSArray *transactions, NSError *error))completionBlock {
    NSParameterAssert([fromDate compare:toDate] == NSOrderedAscending);
    NSParameterAssert(cardId);

    NSURL *url = actionURL(@"GateWay");
    NSMutableURLRequest *urlRequest = urlRequestFromURL(url);
    [urlRequest setHTTPMethod:@"POST"];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSString *fromDateString, *toDateString;
    fromDateString = [dateFormatter stringFromDate:fromDate];
    toDateString = [dateFormatter stringFromDate:toDate];

    NSString *httpBodyString = [NSString stringWithFormat:@"Template=OWS_vpsk&@ObjID=%@&P_DATE_FROM=%@&P_DATE_TO=%@",cardId,fromDateString,toDateString];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"s: %@",string);
        NSMutableArray * transactions = [NSMutableArray array];
                               
        RXMLElement *rxmlElement = [RXMLElement elementFromXMLData:data];
        [rxmlElement iterate:@"CONTRACT.ACCOUNT.TRANS_CARD.TRANSACTION" usingBlock:^(RXMLElement *transactionXMLElement) {
            [transactions addObject:[RGTransaction transactionWithXMLElement:transactionXMLElement]];
        }];

        if (completionBlock) {
            completionBlock(transactions,connectionError);
        }
    }];
}


@end
