//
//  RGTransaction.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 01.06.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXMLElement.h"

@interface RGTransaction : NSObject
@property (nonatomic, strong) NSDate* postingDate;
@property (nonatomic, strong) NSDate* transactionDate;
@property (nonatomic, assign, getter = isNormal) BOOL normal;
@property (nonatomic, strong) NSString* serviceClass;
@property (nonatomic, strong) NSString* currency;

@property (nonatomic, assign) CGFloat amount;
@property (nonatomic, assign) CGFloat feeAmount;
@property (nonatomic, assign) CGFloat accountAmount;
@property (nonatomic, strong) NSString* description;

+(instancetype)transactionWithXMLElement:(RXMLElement*)element;
@end
