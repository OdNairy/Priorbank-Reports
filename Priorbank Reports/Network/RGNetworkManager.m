//
//  RGNetworkManager.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGNetworkManager.h"
#import "NSString+RGCrypto.h"

static NSTimeInterval kNetworkTimeout = 30;
static NSString *kServerAPIURL = @"https://www.prior.by/api/";

NSURL *serverURL() {
    return [NSURL URLWithString:kServerAPIURL];
}

NSURL *actionURL(NSString *action) {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", serverURL(), @"ibapi.axd?action=", action];
    return [NSURL URLWithString:urlString];
}

NSURLRequest *urlRequestFromURL(NSURL *url) {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                            timeoutInterval:kNetworkTimeout];
    [request setValue:@"Priorbank client/1.1" forHTTPHeaderField:@"User-Agent"];
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
        if (connectionError) {
            block(nil, connectionError);
        } else {
            NSString *serverToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            block(serverToken, connectionError);
        }
    }];
}

- (void)signinWithLoginName:(NSString *)loginName passwordHash:(NSString *)passwordHash serverToken:(NSString *)serverToken {
    NSAssert(loginName.length > 0, @"loginName parameter shouldn't be empty string");
    NSAssert(passwordHash.length > 0, @"passwordHash parameter shouldn't be empty string");
    NSAssert(serverToken.length > 0, @"serverToken parameter shouldn't be empty string");

    NSLog(@"loginName = %@", loginName);
    NSLog(@"passwordHash = %@", passwordHash);
    NSLog(@"clientToken = %@", [serverToken encryptByPriorKeys]);
}


@end
