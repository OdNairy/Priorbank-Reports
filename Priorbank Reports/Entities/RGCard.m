//
//  RGCard.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <RaptureXML/RXMLElement.h>
#import "RGCard.h"
#import "RXMLElement+ExtendedXMLElement.h"
#import "RGBalance.h"

@implementation RGCard
-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        NSString* idAttribute = attributes[@"id"];
        self.cardIdentifier = idAttribute;
    }
    return self;
}

+ (id)entityWithXMLElement:(RXMLElement *)element {
    return [[RGCard alloc] initWithXMLElement:element];
}

- (id)initWithXMLElement:(RXMLElement *)element {
    self = [super init];
    if (self) {
        self.cardIdentifier = [element attribute:@"id"];
        self.synonym = [element textForChild:@"Synonym"];
        self.type = [element integerForChild:@"Type"];
        self.cardNum = [element integerForChild:@"CardNum"];
        self.operType = [element integerForChild:@"OperType"];
        self.description = [element textForChild:@"Description"];
        self.externalId = [element textForChild:@"ExternalID"];
        self.corp = [element integerForChild:@"Corp"];
        self.corpName = [element textForChild:@"CorpName"];
        self.currency = [element textForChild:@"Currency"];
        self.cardType = [element textForChild:@"CardType"];
        self.userSynonym = [element textForChild:@"CustomSynonym"];
        self.stCashCard = (BOOL) [element integerForChild:@"IsStCashCard"];
        self.pkgName = [element textForChild:@"PkgName"];

        RXMLElement *balanceElement = [element child:@"BALANCE"];
        self.balance = [RGBalance entityWithXMLElement:balanceElement];
    }
    return self;
}


@end
