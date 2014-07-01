//
//  PBRBehaviour.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 30/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <objc/runtime.h>

#import "PBRBehaviour.h"


@implementation PBRBehaviour

- (void)setOwner:(id)owner{
    if (_owner != owner) {
        [self releaseLifetimeFromObject:_owner];
        _owner = owner;
        [self bindLifetimeToObject:_owner];
    }
}

- (void)bindLifetimeToObject:(id)object{
    objc_setAssociatedObject(object, (__bridge void *)self, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseLifetimeFromObject:(id)object{
    objc_setAssociatedObject(object, (__bridge void *)self, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
