//
//  QFNewsDetailTableViewController.h
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-10.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "GTTableViewController.h"

@interface QFNewsDetailTableViewController : GTTableViewController

- (id)initWithRequest:(NSFetchRequest *)request cacheName:(NSString *)cache;

- (void)startLoadingTableViewData;

//- (void)doneLoadingTableViewData;

@property(nonatomic,strong)QFNews *news;


@end
