//
// Created by Roman Gardukevich on 01.06.14.
// Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RXMLElement+ExtendedXMLElement.h"


@implementation RXMLElement (ExtendedXMLElement)
- (NSString *)textForChild:(NSString *)childName {
    return [[self child:childName] text];
}

- (NSInteger)integerForChild:(NSString *)childName {
    return [[self child:childName] textAsInt];
}

- (double)doubleForChild:(NSString *)childName {
    return [[self child:childName] textAsDouble];
}

- (CGFloat)floatForChild:(NSString *)childName{
    return [[[self child:childName] text] floatValue];
}


@end