//
//  PBRSimulateButtonPress.h
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 01/07/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "PBRBehaviour.h"

@interface PBRSimulateButtonPress : PBRBehaviour<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIControl* responder;
@end
