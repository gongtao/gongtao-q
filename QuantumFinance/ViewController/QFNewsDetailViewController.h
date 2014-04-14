//
//  QFNewsDetailViewController.h
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-9.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFSubBaseViewController.h"

#import "QFNewsDetailToolBar.h"

@interface QFNewsDetailViewController : QFSubBaseViewController<QFNewsDetailToolBarDelegate,UITextFieldDelegate>

@property(nonatomic,strong)QFNews *news;

@end
