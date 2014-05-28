//
//  NSString+SHA.m
//  Prior
//
//  Created by Roman Gardukevich on 8/19/12.
//  Copyright (c) 2012 Roman Gardukevich. All rights reserved.
//

#import "NSString+RGCrypto.h"
#include <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (RGCrypto)

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

- (NSString *)encryptByPriorKeys {
    NSData *input = [[NSData alloc] initWithBase64EncodedString:self options:0];

    NSData *key = [[NSData alloc] initWithBase64EncodedString:@"Nm4wMy5nOiM3JSpWfnwzOXFpNzRcfjB5MVNEKl8mWkw="
                                                      options:0];
    NSData *initialVector = [[NSData alloc] initWithBase64EncodedString:@"OSMqNE11fGUoLDg5Mmk1WQ==" options:0];

    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));

    [key getBytes:keyPtr length:sizeof(keyPtr)];


    NSUInteger dataLength = [input length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(kCCEncrypt,
            kCCAlgorithmAES,
            kCCOptionPKCS7Padding,
            keyPtr,
            kCCKeySizeAES256,
            [initialVector bytes],
            [input bytes], dataLength,
            buffer, bufferSize, &numBytesEncrypted);

    if (cryptorStatus != kCCSuccess) {
        NSLog(@"cryptorStatus = %i", cryptorStatus);
    }

    NSData *encryptedData = [[NSData alloc] initWithBytes:buffer length:numBytesEncrypted];

    return [encryptedData base64EncodedStringWithOptions:0];
}


@end
