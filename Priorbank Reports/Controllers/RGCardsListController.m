//
//  RGCardsListController.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 31.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGCardsListController.h"
#import "RGCardsList.h"
#import "RGCard.h"
#import "RGBalance.h"
#import "RGCardInListCell.h"
#import "RGNetworkManager.h"
#import "RGCardTransactionsController.h"
#import "RGHUD.h"
#import "RXMLElement.h"
#import "RGTransaction.h"

static NSString* kOpenCardSegue = @"OpenCard";

@interface RGCardsListController ()

@end

@implementation RGCardsListController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self isMovingFromParentViewController]) {
        self.navigationController.navigationBarHidden = YES;
    }
}

-(void)setCardsList:(RGCardsList *)cardsList{
    _cardsList = cardsList;
    [self.tableView reloadData];
}

-(NSArray*)cardsArrayForSection:(NSInteger)section{
    if (section == 0) {
        return self.cardsList.cards;
    }else if (section == 1){
        return self.cardsList.pltCards;
    }
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self cardsArrayForSection:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RGCardInListCell *cell = (RGCardInListCell*)[tableView dequeueReusableCellWithIdentifier:@"CardCell"];

    RGCard* card = [self cardsArrayForSection:indexPath.section][indexPath.row];
    
    cell.descriptionLabel.text = [card presentName];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RGCard* card = [self cardsArrayForSection:indexPath.section][indexPath.row];
    NSLog(@"Selected card: %@",card.cardIdentifier);

    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -3;
    NSDate *fromDate = [(NSCalendar *)[NSCalendar currentCalendar] dateByAddingComponents:components
                                                                                   toDate:[NSDate date] options:0];
    __weak __typeof(self) weakSelf = self;
    
    RGHUD* hud = [RGHUD HUDWithGrace:kDefaultGracePeriod inView:self.view];
    hud.labelText = @"Loading transactions list";
    [hud show:YES];
    
    [RGNetworkManager transactionsForCardId:card.cardIdentifier from:fromDate to:[NSDate date]]
    .thenOn(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^(NSData* data){
        NSMutableArray * transactions = [NSMutableArray array];
        RXMLElement *rxmlElement = [RXMLElement elementFromXMLData:data];
        [rxmlElement iterateWithRootXPath:@"//TRANSACTION" usingBlock:^(RXMLElement *transactionXMLElement) {
            [transactions addObject:[RGTransaction transactionWithXMLElement:transactionXMLElement]];
        }];
        return [Promise promiseWithValue:transactions];
    }).then(^(NSArray* transactions){
        hud.taskInProgress = NO;
        [hud hide:YES];
        RGCardTransactionsController* transactionsController = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"RGCardTransactionsController"];
        transactionsController.transactions = transactions;
        transactionsController.card = card;
        [weakSelf.navigationController pushViewController:transactionsController animated:YES];
    });
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"Cards",@"PltCards"][section];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
