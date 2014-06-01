//
//  RGCardsList.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGXMLEntityProtocol.h"
#import "RGObject.h"

@class RXMLElement;

@interface RGCardsList : RGObject<RGXMLEntityProtocol>
@property (nonatomic, strong, readonly) NSMutableArray* cards;
@property (nonatomic, strong, readonly) NSMutableArray* pltCards;    // ?? Credit cards ??
+(instancetype)cardListWithData:(NSData*)data;
@end
