//
//  QFNews.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/8/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFComment;

@interface QFNews : NSManagedObject

@property (nonatomic, retain) NSNumber * commentCount;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * isCollect;
@property (nonatomic, retain) NSNumber * isGood;
@property (nonatomic, retain) NSNumber * isNew;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSString * synopsis;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * viewCount;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSManagedObject *headLine;
@end

@interface QFNews (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(QFComment *)value;
- (void)removeCommentsObject:(QFComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
