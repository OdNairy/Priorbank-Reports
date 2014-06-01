//
//  RGCardTransactionsController.h
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 01.06.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RGCard;
@interface RGCardTransactionsController : UITableViewController
@property (nonatomic, strong) RGCard* card;
@property (nonatomic, strong) NSArray* transactions;
@end
