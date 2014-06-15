//
//  RGNetworkManager.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

NSURL *actionURL(NSString *action);
NSMutableURLRequest *urlRequestFromURL(NSURL *url);
NSString* urlEncodedValue(NSString* str);


typedef void(^RGResponseBlock)(NSData*, NSError*);

@interface RGNetworkManager : NSObject
+ (instancetype)sharedManager;

+ (Promise*)initialSetupForServerToken;
+ (Promise*)signinWithLogin:(NSString*)login password:(NSString*)password token:(NSString*)token;
+ (Promise*)cardList;

- (void)transactionsForCardId:(NSString *)cardId from:(NSDate *)fromDate to:(NSDate *)toDate completionBlock:(void (^)(NSArray *transactions, NSError *error))completionBlock;

@end
