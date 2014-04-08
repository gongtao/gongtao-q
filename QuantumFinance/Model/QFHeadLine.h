//
//  QFHeadLine.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/8/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFNews, QFProduct;

@interface QFHeadLine : NSManagedObject

@property (nonatomic, retain) NSNumber * hid;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) QFProduct *product;
@property (nonatomic, retain) QFNews *news;

@end
