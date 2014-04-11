//
//  QFHistoryViewController.h
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GTTableViewController.h>

#import "EGORefreshTableHeaderView.h"

@interface QFHistoryViewController : GTTableViewController <EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
}

- (void)refreshLastUpdateTime;

- (void)startLoadingTableViewData;

- (void)doneLoadingTableViewData;

@end
