//
//  QFRootViewController.h
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFBaseViewController.h"

#import "QFToolBar.h"

@interface QFRootViewController : QFBaseViewController <QFToolBarDelegate>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) NSMutableDictionary *subVCDic;

@property (nonatomic, assign) NSUInteger index;

@end
