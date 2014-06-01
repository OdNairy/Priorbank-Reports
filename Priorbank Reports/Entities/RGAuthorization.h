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

@interface RGAuthorization : RGObject<RGXMLEntityProtocol>
+(instancetype)authorizationWithData:(NSData*)data;
@end
