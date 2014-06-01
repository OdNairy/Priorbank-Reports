//
//  RGBalance.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <RaptureXML/RXMLElement.h>
#import "RGBalance.h"
#import "RXMLElement+ExtendedXMLElement.h"
#import "RGTransaction.h"

@implementation RGBalance
+ (id)entityWithXMLElement:(RXMLElement *)element {
    return [[RGBalance alloc] initWithXMLElement:element];
}

- (id)initWithXMLElement:(RXMLElement *)element {
    self = [super init];
    if (self) {
        self.cardId = [element textForChild:@"CARD_ID"];
        self.amountAvailable = [element floatForChild:@"AMOUNT_AVAILABLE"];
        self.contractorCurrency = [element textForChild:@"CONTRACT_CURR"];
        self.cardNum = [element integerForChild:@"CARD_NUMBER"];
        self.rbsCard = [element textForChild:@"RBS_CARD"];
        self.cardExpire = [RGTransaction dateFromTransactionDateString:[element textForChild:@"CARD_EXPIRE"]];
        self.cardStatus = [element textForChild:@"CARD_STATUS"];
        self.cardStatusCode = [element integerForChild:@"CARD_STATUS_CODE"];
        self.prodType = [element textForChild:@"PROD_TYPE"];
        self.prodNum = [element textForChild:@"PROD_NUM"];
        self.sum = [element floatForChild:@"SUM"];
        self.totalSum = [element floatForChild:@"TOTAL_SUM"];
    }
    return self;
}

@end
