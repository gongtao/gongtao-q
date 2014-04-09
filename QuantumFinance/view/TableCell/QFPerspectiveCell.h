//
//  QFPerspectiveCell.h
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-8.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFPerspectiveCell : UITableViewCell

@property (nonatomic,strong)UIButton *button;

-(void)configPerspectiveCell:(QFNews *)news;

@end
