//
//  RGError.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 01.06.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <RaptureXML/RXMLElement.h>
#import "RGError.h"
#import "RXMLElement+ExtendedXMLElement.h"

@implementation RGError
+ (id)entityWithXMLElement:(RXMLElement *)element {
    return [[RGError alloc] initWithXMLElement:element];
}

- (id)initWithXMLElement:(RXMLElement *)element {
    self = [super init];
    if (self) {
        self.title = [element textForChild:@"Title"];
        self.message = [[[element child:@"Message"] child:@"Rus"] text];
    }
    return self;
}


@end
