//
//  RGAppDelegate.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBRRootViewController.h"

@interface RGAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) PBRRootViewController* rootViewController;

@end
