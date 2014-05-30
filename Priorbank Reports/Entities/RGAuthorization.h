//
//  RGAuthorization.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 30.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGAuthorization : NSObject
+(instancetype)authorizationWithData:(NSData*)data;
@end
