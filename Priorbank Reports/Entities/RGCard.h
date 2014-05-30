//
//  RGCard.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RGBalance;
@interface RGCard : NSObject
@property (nonatomic, strong) NSString* cardIdentifier; // original source is "id" attribute
@property (nonatomic, strong) NSString* synonym;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger cardNum;
@property (nonatomic, assign) NSInteger operType;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* externalId;

@property (nonatomic, assign) NSInteger corp;
@property (nonatomic, strong) NSString* corpName;

@property (nonatomic, strong) NSString* currency;

@property (nonatomic, strong) NSString* cardType;
@property (nonatomic, strong) NSString* userSynonym;

@property (nonatomic, assign,getter = isStCashCard) BOOL stCashCard;

@property (nonatomic, strong) RGBalance* balance;
@end
