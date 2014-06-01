//
//  RGCardsList.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <RaptureXML/RXMLElement.h>
#import "RGCardsList.h"
#import "RGCard.h"
#import "RGBalance.h"

@interface RGCardsList ()<NSXMLParserDelegate>
@property (nonatomic, strong,readwrite) NSMutableArray* cards;
@property (nonatomic, strong,readwrite) NSMutableArray* pltCards;

@property (nonatomic, weak) NSMutableArray* currentCardsArray;
@property (nonatomic, weak) RGCard* currentCard;
@property (nonatomic, strong) NSMutableArray* currentPropertyStack;
@end

@implementation RGCardsList
+(instancetype)cardListWithData:(NSData *)data{
    return [[RGCardsList alloc] initWithData:data];
}

+ (id)entityWithXMLElement:(RXMLElement *)element {
    return [[RGCardsList alloc] initWithXMLElement:element];
}

-(instancetype)initWithXMLElement:(RXMLElement *)element{
    self = [super init];
    if (self) {
        self.cards    = [self serializeCardsInElement:[element child:@"Cards"]];
        self.pltCards = [self serializeCardsInElement:[element child:@"PltCards"]];
    }
    return self;
}

-(NSMutableArray *)serializeCardsInElement:(RXMLElement *)element{
    NSMutableArray * cards = [NSMutableArray array];
    [element iterate:@"Card" usingBlock:^(RXMLElement *cardElement) {
        [cards addObject:[RGCard entityWithXMLElement:cardElement]];
    }];
    return cards;
}


-(instancetype)initWithData:(NSData*)data{
    return [[RGCardsList alloc] initWithXMLElement:[RXMLElement elementFromXMLData:data]];
}

@end
