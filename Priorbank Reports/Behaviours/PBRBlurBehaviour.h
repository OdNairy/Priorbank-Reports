//
//  PBRBlurBehaviour.h
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 30/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "PBRBehaviour.h"

@interface PBRBlurBehaviour : PBRBehaviour
@property (nonatomic, assign) IBOutlet UIImageView* targetImageView;
@property (nonatomic, strong) NSString* imageName;

@property (nonatomic, assign) CGFloat blurRadius;
@end
