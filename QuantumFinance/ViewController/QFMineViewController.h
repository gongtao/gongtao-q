//
//  QFMineViewController.h
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QFSubBaseViewController.h"

@interface QFMineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView * tableView;

@end
