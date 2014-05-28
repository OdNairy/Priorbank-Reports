//
//  RGViewController.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGLoginViewController.h"
#import "RGNetworkManager.h"
#import "NSString+SHA.h"

@interface RGLoginViewController ()
@property(weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property(weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(weak, nonatomic) IBOutlet UIButton *signInButton;
@end

@implementation RGLoginViewController

- (void)initializeControls {
    self.loginNameTextField.placeholder = @"Login name";
    self.passwordTextField.placeholder = @"Your login password";
    [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeControls];
}

- (IBAction)signInButtonTapped {
    __weak __typeof(self) myself = self;
    NSString *loginName = myself.loginNameTextField.text;
    NSString *password = myself.passwordTextField.text;

    if (!loginName.length || !password.length) {
        // TODO: alert not-input params
        return;
    }

    [[RGNetworkManager sharedManager] initialSetupForServerToken:^(NSString *serverToken, NSError *er) {
        NSLog(@"ServerToken: %@", serverToken);

        [[RGNetworkManager sharedManager] signinWithLoginName:loginName
                                                 passwordHash:[password sha512]
                                                  serverToken:serverToken];
    }];
}


@end