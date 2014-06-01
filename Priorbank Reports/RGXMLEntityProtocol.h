//
// Created by Roman Gardukevich on 01.06.14.
// Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RXMLElement;

@protocol RGXMLEntityProtocol <NSObject>
@required
+(id)entityWithXMLElement:(RXMLElement *)element;
-(id)initWithXMLElement:(RXMLElement *)element;
@end