//
//  RGCommission.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 16/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGCommission.h"
#import "RXMLElement.h"
#import "RXMLElement+ExtendedXMLElement.h"

@implementation RGCommission
+ (id)entityWithXMLElement:(RXMLElement *)element {
    return [[RGCommission alloc] initWithXMLElement:element];
}

- (instancetype)initWithXMLElement:(RXMLElement *)element {
    self = [super init];
    if (self) {
        self.userLimited = [element integerForChild:@"IsUserLimited"];
        self.bsServiceNumber = [element integerForChild:@"BSServiceNo"];
        self.amount = [element floatForChild:@"Amount"];

        NSString *timeLimitString = [element textForChild:@"TimeLimit"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        self.timeLimit = [dateFormatter dateFromString:timeLimitString];
    }
    return self;
}


@end
