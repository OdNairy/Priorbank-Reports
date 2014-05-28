//
//  NSString+SHA.h
//  Prior
//
//  Created by Roman Gardukevich on 8/19/12.
//  Copyright (c) 2012 Roman Gardukevich. All rights reserved.
//

@interface NSString (RGCrypto)
- (NSString *)sha512;
- (NSString *)encryptByPriorKeys;
@end
