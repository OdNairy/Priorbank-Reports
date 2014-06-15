//
//  RGNavigationController.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 15/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGNavigationController.h"

@implementation RGNavigationController
-(BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}
-(NSUInteger)supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}
@end
