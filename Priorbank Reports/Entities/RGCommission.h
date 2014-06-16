//
//  RGCommission.h
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 16/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//



#import "RGObject.h"
#import "RGXMLEntityProtocol.h"

@interface RGCommission : RGObject<RGXMLEntityProtocol>
@property(nonatomic, assign, getter=isUserLimited) BOOL userLimited;
@property(nonatomic, assign) NSInteger bsServiceNumber;
@property(nonatomic, assign) CGFloat amount;
@property(nonatomic, strong) NSDate *timeLimit;
@end
