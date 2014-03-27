//
//  BMCustomButton.h
//  BananaNews
//
//  Created by 龚 涛 on 14-1-2.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFCustomButton : UIButton

@property (nonatomic, assign) CGRect titleRect;

@property (nonatomic, assign) CGRect imageRect;

@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, strong) UIColor *highlightedBgColor;

@end
