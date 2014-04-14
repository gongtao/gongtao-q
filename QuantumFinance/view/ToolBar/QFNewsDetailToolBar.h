//
//  QFNewsDetailToolBar.h
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-9.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QFNewsDetailToolBarDelegate <NSObject>

- (void)shareButtonClicked;

- (void)collectButtonClicked:(BOOL)isbuttonclicked;

- (void)commentButtonClicked;

- (void)dingButtonClicked:(BOOL)isbuttonclicked;

@end

@interface QFNewsDetailToolBar : UIView
{
    NSArray *_titleArray;
    BOOL iscollectButtonClicked;
    BOOL isdingButtonClicked;
}

@property (nonatomic, weak) id<QFNewsDetailToolBarDelegate> delegate;

@end
