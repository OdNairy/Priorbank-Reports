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
#import "RGError.h"

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

NSString* urlEncodedValue(NSString* str){
        NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
        return result;
}

@interface NSURLConnection(RGNetwork)
+(void)asynchRequest:(NSURLRequest *)request completion:(void(^)(id data, NSError *error))completion;
@end

@implementation NSURLConnection(RGNetwork)
+ (void)asynchRequest:(NSURLRequest *)request completion:(void (^)(id, NSError *))completion {
    NSParameterAssert(request);
    NSParameterAssert(completion);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if (completion) {
                completion(nil,connectionError);
            }
        } else {
            RXMLElement *element = [RXMLElement elementFromXMLData:data];
            if (!element) {
                completion(data,nil);
                return;
            }
            if ([element.tag isEqualToString:@"Error"]) {
                RGError *error = [RGError entityWithXMLElement:element];
                NSLog(@"Error: %@",error.message);
                NSLog(@"URL: %@",response.URL.absoluteString);
                [[[UIAlertView alloc] initWithTitle:error.title
                                           message:error.message
                                          delegate:nil
                                 cancelButtonTitle:@"OK" otherButtonTitles:nil] show];

                if (completion) {
                    completion(nil,[NSError errorWithDomain:@"NetworkDomain" code:-42 userInfo:@{@"ServerTitle":error.title}]);
                }
            } else if (completion) {
                completion(data,nil);
            }
        }
    }];
}

@end

@implementation RGNetworkManager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static RGNetworkManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[RGNetworkManager alloc] init];
    });
    return sharedManager;
}

+ (void)removeCookiesForURL:(NSURL *)url {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [storage cookiesForURL:url];
    for (NSHTTPCookie *cookie in cookies) {
        [storage deleteCookie:cookie];
    }
}

+ (Promise*)initialSetupForServerToken{
    NSURL *url = actionURL(@"setup");
    [RGNetworkManager removeCookiesForURL:url];

    NSURLRequest *urlRequest = urlRequestFromURL(url);
    return [NSURLConnection promise:urlRequest];
}

+ (Promise*)signinWithLogin:(NSString*)login password:(NSString*)password token:(NSString*)token{
    NSParameterAssert(login.length > 0);
    NSParameterAssert(password.length > 0);
    NSParameterAssert(token.length > 0);
    
    NSString *clientToken = urlEncodedValue([token encryptByPriorKeys]);
    NSString *body = [NSString stringWithFormat:@"&UserName=%@&UserPassword=%@&Token=%@", login, password,
                      clientToken];
    
    NSURL *url = actionURL(@"login");
    NSMutableURLRequest *urlRequest = [urlRequestFromURL(url) mutableCopy];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    return [NSURLConnection promise:urlRequest];
}

+(Promise*)cardList{
    NSMutableURLRequest* urlRequest = urlRequestFromURL(actionURL(@"GateWay"));
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[@"Template=CardList" dataUsingEncoding:NSUTF8StringEncoding]];
    return [NSURLConnection promise:urlRequest];
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
    [NSURLConnection asynchRequest:urlRequest completion:^(id data, NSError *error) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"s: %@",string);
        NSMutableArray * transactions = [NSMutableArray array];

        RXMLElement *rxmlElement = [RXMLElement elementFromXMLData:data];
        [rxmlElement iterateWithRootXPath:@"//TRANSACTION" usingBlock:^(RXMLElement *transactionXMLElement) {
            [transactions addObject:[RGTransaction transactionWithXMLElement:transactionXMLElement]];
        }];

        if (completionBlock) {
            completionBlock(transactions,error);
        }
    }];
}


@end
