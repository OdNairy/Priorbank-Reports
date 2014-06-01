//
//  RGBalance.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGXMLEntityProtocol.h"
#import "RGObject.h"

@interface RGBalance : RGObject<RGXMLEntityProtocol>
@property (nonatomic, assign) NSString* cardId;
@property (nonatomic, assign) CGFloat amountAvailable;
@property (nonatomic, strong) NSString* contractorCurrency;
@property (nonatomic, assign) NSInteger cardNum;
@property (nonatomic, strong) NSString *rbsCard;

@property (nonatomic, strong) NSDate* cardExpire;
@property (nonatomic, strong) NSString* cardStatus;
@property (nonatomic, assign) NSInteger cardStatusCode;
@property (nonatomic, strong) NSString* prodType;
@property(nonatomic, strong) NSString *prodNum;

@property (nonatomic, assign) CGFloat sum;
@property (nonatomic, assign) CGFloat totalSum;

@end
