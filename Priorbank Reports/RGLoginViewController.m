//
//  RGViewController.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGLoginViewController.h"

@interface RGLoginViewController ()
@property(weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property(weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation RGLoginViewController

- (void)initializeControls {
    self.loginNameTextField.placeholder = @"Login name";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeControls];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
