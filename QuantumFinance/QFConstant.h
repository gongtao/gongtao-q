//
//  QFConstant.h
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#ifndef QuantumFinance_QFConstant_h
#define QuantumFinance_QFConstant_h

#define kBaseURL    [NSURL URLWithString:@"http://42.121.104.18:8089"]

#define IS_IOS7     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define IS_IPhone5_or_5s    ([UIScreen mainScreen].bounds.size.width == 568.0)

#define Color_MainBlue              [UIColor colorWithHexString:@"0e9fde"]
#define Color_DarkBlue              [UIColor colorWithHexString:@"1b4f6d"]

#define Color_NewsFont              [UIColor colorWithHexString:@"666666"]

#endif
