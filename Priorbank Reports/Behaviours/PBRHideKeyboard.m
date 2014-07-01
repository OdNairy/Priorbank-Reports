//
//  PBRHideKeyboard.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 01/07/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "PBRHideKeyboard.h"

@implementation PBRHideKeyboard
-(IBAction)hideKeyboard:(id)sender{
    [[[UIApplication sharedApplication].delegate window].rootViewController.view endEditing:YES];
}
@end
