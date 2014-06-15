//
//  RGHUD.h
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 15/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "MBProgressHUD.h"
static CGFloat kDefaultGracePeriod = .3f;

@interface RGHUD : MBProgressHUD
+(instancetype)HUDWithGrace:(CGFloat)gracePeriod inView:(UIView*)view;
@end
