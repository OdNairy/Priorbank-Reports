//
//  RGError.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 01.06.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//



#import "RGObject.h"
#import "RGXMLEntityProtocol.h"

@interface RGError : RGObject<RGXMLEntityProtocol>
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, assign) NSInteger procReturnCode;

@end
