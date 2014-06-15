//
//  RGHUD.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 15/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGHUD.h"

@implementation RGHUD
+(instancetype)HUDWithGrace:(CGFloat)gracePeriod inView:(UIView *)view{
    RGHUD* hud = [[RGHUD alloc] initWithView:view];
    if (hud) {
        hud.graceTime = gracePeriod;
        hud.taskInProgress = YES;
        hud.animationType = MBProgressHUDAnimationZoomIn;
        [view addSubview:hud];
    }
    return hud;
}
@end
