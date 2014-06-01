//
//  RGAuthorization.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 30.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <RaptureXML/RXMLElement.h>
#import "RGAuthorization.h"

@implementation RGAuthorization
+(instancetype)authorizationWithData:(NSData *)data{
    return [[RGAuthorization alloc] init];
}

+ (instancetype)entityWithXMLElement:(RXMLElement *)element {
    return [[RGAuthorization alloc] initWithXMLElement:element];
}

- (instancetype)initWithXMLElement:(RXMLElement *)element {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
