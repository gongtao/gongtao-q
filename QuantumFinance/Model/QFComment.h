//
//  QFComment.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/8/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFNews, QFUser;

@interface QFComment : NSManagedObject

@property (nonatomic, retain) NSNumber * cid;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) QFNews *news;
@property (nonatomic, retain) QFUser *replyUser;
@property (nonatomic, retain) QFUser *user;

@end
