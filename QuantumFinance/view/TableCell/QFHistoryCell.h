//
//  QFHistoryCell.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/11/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFHistoryCell : UITableViewCell

- (void)setLastRow:(BOOL)isLast;

- (void)setProduct:(QFProduct *)product;

@end
