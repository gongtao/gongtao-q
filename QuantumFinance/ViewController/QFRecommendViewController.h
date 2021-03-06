//
//  QFRecommendViewController.h
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GTTableViewController.h>

#import "EGORefreshTableHeaderView.h"

@interface QFRecommendViewController : GTTableViewController<EGORefreshTableHeaderDelegate>

- (void)startLoadingTableViewData;

- (void)doneLoadingTableViewData;

@end
