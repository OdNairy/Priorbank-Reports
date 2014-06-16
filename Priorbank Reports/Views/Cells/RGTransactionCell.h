//
//  RGTransactionCell.h
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 16/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGTransactionCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel* titleLabel;
@property (nonatomic, weak) IBOutlet UILabel* dateLabel;
@property (nonatomic, weak) IBOutlet UILabel* amountLabel;

@end
