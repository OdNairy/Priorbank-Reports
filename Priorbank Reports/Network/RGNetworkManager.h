//
//  RGNetworkManager.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGNetworkManager : NSObject
+ (instancetype)sharedManager;

- (void)initialSetupForServerToken:(void (^)(NSString *serverToken, NSError *er))block;
@end
