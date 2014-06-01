//
// Created by Roman Gardukevich on 01.06.14.
// Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXMLElement.h"

@interface RXMLElement (ExtendedXMLElement)
-(NSString *)textForChild:(NSString *)childName;
-(NSInteger)integerForChild:(NSString *)childName;
-(double)doubleForChild:(NSString *)childName;
- (CGFloat)floatForChild:(NSString *)childName;
@end