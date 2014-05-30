//
//  NSDictionary+NormalizeCyrillic.m
//  WalletOne
//
//  Created by Roman Gardukevich on 18.05.14.
//  Copyright (c) 2014 WalletOne. All rights reserved.
//

#import "NSDictionary+NormalizeCyrillic.h"
#import "objc/runtime.h"

#pragma clang diagnostic push
#pragma ide diagnostic ignored "InfiniteRecursion"

@implementation NSDictionary (NormalizeCyrillic)
+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([NSDictionary class], @selector(description)), class_getInstanceMethod([NSDictionary class], @selector(descriptionWithCyrillicSupport_new)));
}

- (NSString *)descriptionWithCyrillicSupport_new {
    NSString *input = [self descriptionWithCyrillicSupport_new];
    input = [input stringByReplacingOccurrencesOfString:@"\\U" withString:@"\\u"];
    NSMutableString *mutableInput = [input mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef) mutableInput, NULL, CFSTR("Any-Hex/Java"), YES);
    return mutableInput;
}

@end

#pragma clang diagnostic pop