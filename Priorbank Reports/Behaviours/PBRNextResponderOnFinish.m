//
//  PBRNextResponderOnFinish.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 01/07/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "PBRNextResponderOnFinish.h"

@implementation PBRNextResponderOnFinish

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return ![self.nextResponderOnFinish becomeFirstResponder];
}

@end
