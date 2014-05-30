//
//  RGCardsList.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGCardsList : NSObject
@property (nonatomic, strong, readonly) NSMutableArray* cards;
@property (nonatomic, strong, readonly) NSMutableArray* pltCards;    // ?? Credit cards ??
+(instancetype)cardListWithData:(NSData*)data;
@end
