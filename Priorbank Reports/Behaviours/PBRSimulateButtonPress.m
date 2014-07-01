//
//  PBRSimulateButtonPress.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 01/07/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "PBRSimulateButtonPress.h"

@implementation PBRSimulateButtonPress
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.responder sendActionsForControlEvents:(UIControlEventTouchUpInside)];
    return YES;
}
@end
