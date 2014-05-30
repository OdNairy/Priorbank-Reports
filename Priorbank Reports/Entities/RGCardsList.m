//
//  RGCardsList.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

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

-(instancetype)initWithData:(NSData*)data{
    self = [super init];
    if (self) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        parser.delegate = self;
        self.currentPropertyStack = [NSMutableArray array];
        BOOL success = [parser parse];
        if (!success) {
            return nil;
        }
    }
    return self;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"Cards"]) {
        self.cards = [NSMutableArray array];
        self.currentCardsArray = self.cards;
    }else if ([elementName isEqualToString:@"PltCards"]){
        self.pltCards = [NSMutableArray array];
        self.currentCardsArray = self.pltCards;
    }else if ([elementName isEqualToString:@"Card"]){
        RGCard* card = [[RGCard alloc] initWithAttributes:attributeDict];
        self.currentCard = card;
        [self.currentCardsArray addObject:card];
    }else if ([elementName isEqualToString:@"BALANCE"]){
        RGBalance* balance = [[RGBalance alloc] init];
        self.currentCard.balance = balance;
    }
    [self.currentPropertyStack addObject:elementName];
//    NSLog(@"<%@>",elementName);
    if (attributeDict.count) {
//        NSLog(@"attr: %@",attributeDict);
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"Card"]) {
        self.currentCard = nil;
    }else if ([elementName isEqualToString:@"Cards"] || [elementName isEqualToString:@"PltCards"]){
        self.currentCardsArray = nil;
    }
    [self.currentPropertyStack removeLastObject];
//    NSLog(@"</%@>",elementName);
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSString* lastPropertyInStack = self.currentPropertyStack.lastObject;
    if ([lastPropertyInStack isEqualToString:@"Description"]) {
        self.currentCard.description = string;
    }else if ([lastPropertyInStack isEqualToString:@"CustomSynonym"]){
        self.currentCard.userSynonym = string;
        
    }
    
    NSUInteger stackDepth = self.currentPropertyStack.count;
    if (stackDepth >=2) {
        NSString* object   = self.currentPropertyStack[stackDepth-2];
        NSString* property = self.currentPropertyStack[stackDepth-1];
        NSLog(@"[RG%@ set%@: '%@']",[object capitalizedString],[property capitalizedString],string);
    }
}
@end
