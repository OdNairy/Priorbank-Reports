//
//  RGViewController.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGLoginViewController.h"
#import "RGNetworkManager.h"
#import "NSString+RGCrypto.h"
#import "XMLReader.h"
#import "RGAuthorization.h"
#import "RGCardsList.h"
#import "RGCardsListController.h"

#import "RGHUD.h"

static NSString* kPushCardsList = @"OpenCardsList";

@interface RGLoginViewController ()
@property(weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property(weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(weak, nonatomic) IBOutlet UIButton *signInButton;

@property (nonatomic, strong) RGCardsList* cardsList;
@end

@implementation RGLoginViewController

- (void)initializeControls {
    self.loginNameTextField.placeholder = @"Login name";
    self.passwordTextField.placeholder = @"Your login password";
    [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    
#ifdef DEBUG
    self.loginNameTextField.text = @"demo";
    self.passwordTextField.text = @"demo";
#endif
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeControls];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:(UIBarButtonItemStyleDone) target:nil action:nil];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

#pragma mark -

- (IBAction)signInButtonTapped {
    __weak __typeof(self) myself = self;
    NSString *loginName = myself.loginNameTextField.text;
    NSString *password = myself.passwordTextField.text;

    if (!loginName.length || !password.length) {
        // TODO: alert not-input params
        return;
    }

    RGHUD* hud = [RGHUD HUDWithGrace:kDefaultGracePeriod inView:self.view];
    hud.labelText = @"Initial setup";
    [hud show:YES];
    hud.progress = 0;
    
    
    __weak __typeof(self) weakSelf = self;
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    [RGNetworkManager initialSetupForServerToken].then(^(NSString* serverToken){
        return  urlEncodedValue([serverToken encryptByPriorKeys]);
    }).then(^(NSString* encryptedToken){
        hud.labelText = @"Authentification";
        return [RGNetworkManager signinWithLogin:loginName password:[password sha512] token:encryptedToken];
    }).then(^(NSData* signinData){
//        RGAuthorization* authorization = [RGAuthorization authorizationWithData:signinData];
        hud.labelText = @"Retriving cards list";
        return [RGNetworkManager cardList];
    }).thenOn(backgroundQueue,^(NSData* cardsData){
        weakSelf.cardsList = [RGCardsList cardListWithData:cardsData];
//        return [Promise promiseWithValue:_cardsList];
    }).then(^(){
        [weakSelf performSegueWithIdentifier:kPushCardsList sender:weakSelf];
    }).finally(^{
        hud.taskInProgress = NO;
        [hud hide:YES];
    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:kPushCardsList]) {
        RGCardsListController* cardsListController = segue.destinationViewController;
        cardsListController.cardsList = self.cardsList;
    }
}


@end
