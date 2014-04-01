//
//  QFNews.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/1/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QFNews : NSManagedObject

@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * viewCount;
@property (nonatomic, retain) NSNumber * commentCount;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * synopsis;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * isCollect;
@property (nonatomic, retain) NSSet *comments;
@end

@interface QFNews (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
