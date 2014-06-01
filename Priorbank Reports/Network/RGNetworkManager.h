//
//  RGNetworkManager.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RGResponseBlock)(NSData*, NSError*);

@interface RGNetworkManager : NSObject
+ (instancetype)sharedManager;

- (void)initialSetupForServerToken:(void (^)(NSString *serverToken, NSError *er))block;
- (void)signinWithLoginName:(NSString *)loginName passwordHash:(NSString *)passwordHash serverToken:(NSString *)serverToken completionBlock:(void (^)(NSData *, NSError *))completionBlock;

- (void)cardList:(RGResponseBlock)completionBlock;
- (void)transactionsForCardId:(NSString *)cardId from:(NSDate *)fromDate to:(NSDate *)toDate completionBlock:(void (^)(NSData *data, NSError *error))completionBlock;

@end
