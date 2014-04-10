//
//  QFPerspectiveTableViewController.h
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-8.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "GTTableViewController.h"

#import "EGORefreshTableHeaderView.h"

@interface QFPerspectiveTableViewController : GTTableViewController<EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
    
    //NSInteger _postId;
}

- (id)initWithRequest:(NSFetchRequest *)request cacheName:(NSString *)cache;

- (void)refreshLastUpdateTime;

- (void)startLoadingTableViewData;

- (void)doneLoadingTableViewData;

@end
