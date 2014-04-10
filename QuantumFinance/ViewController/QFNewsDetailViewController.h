//
//  QFNewsDetailViewController.h
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-9.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFSubBaseViewController.h"

@interface QFNewsDetailViewController : QFSubBaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)QFNews *news;

@end
