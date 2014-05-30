//
//  RGCard.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGCard.h"

@implementation RGCard
-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        NSString* idAttribute = attributes[@"id"];
        self.cardIdentifier = idAttribute;
    }
    return self;
}
@end
