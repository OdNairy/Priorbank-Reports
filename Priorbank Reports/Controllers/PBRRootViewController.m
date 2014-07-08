//
//  PBRRootViewController.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 01/07/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "PBRRootViewController.h"
#import "RGAppDelegate.h"

@interface PBRRootViewController ()

@end

@implementation PBRRootViewController


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

+(instancetype)rootController{
    RGAppDelegate* delegate = [UIApplication sharedApplication].delegate;
    return delegate.rootViewController;
}

@end
