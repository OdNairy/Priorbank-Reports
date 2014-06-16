//
//  RGAuthorization.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 30.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGXMLEntityProtocol.h"
#import "RGObject.h"

@class RGCommission;

@interface RGAuthorization : RGObject<RGXMLEntityProtocol>
@property(nonatomic, assign, getter=isSuccess) BOOL success;
@property(nonatomic, strong) NSDate *lastAuthorization;
@property(nonatomic, strong) NSString *userSession;
@property(nonatomic, assign) NSInteger clientType;
@property(nonatomic, strong) NSString *clientName;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *regName;
@property(nonatomic, assign, getter=isAdmin) BOOL admin;
@property(nonatomic, strong) NSString *erkRegNum;

@property(nonatomic, assign) NSInteger unreadMessagesCount;
@property(nonatomic, assign) BOOL useMobileCode;
@property(nonatomic, assign) BOOL edsAllowed;

@property(nonatomic, strong) RGCommission *commission;
+ (RGAuthorization *)authorizationWithData:(NSData *)data;
@end
