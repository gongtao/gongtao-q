//
//  QFCollectionTableViewController.h
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-14.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "GTTableViewController.h"

@interface QFCollectionTableViewController : GTTableViewController

- (id)initWithRequest:(NSFetchRequest *)request cacheName:(NSString *)cache;

@end
