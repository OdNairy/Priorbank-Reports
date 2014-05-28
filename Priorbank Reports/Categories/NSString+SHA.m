//
//  NSString+SHA.m
//  Prior
//
//  Created by Roman Gardukevich on 8/19/12.
//  Copyright (c) 2012 Roman Gardukevich. All rights reserved.
//

#import "NSString+SHA.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (SHA)

- (NSString *)sha512 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];

    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG) data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

@end
