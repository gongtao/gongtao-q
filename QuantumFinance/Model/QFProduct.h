//
//  QFProduct.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/8/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QFProduct : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * deadline;
@property (nonatomic, retain) NSString * eair;
@property (nonatomic, retain) NSNumber * isHistory;
@property (nonatomic, retain) NSString * money;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * pid;
@property (nonatomic, retain) NSString * schedule;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSManagedObject *headline;

@end
