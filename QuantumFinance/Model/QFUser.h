//
//  QFUser.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/8/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFComment;

@interface QFUser : NSManagedObject

@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSNumber * isMainUser;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) NSSet *replyComment;
@end

@interface QFUser (CoreDataGeneratedAccessors)

- (void)addCommentObject:(QFComment *)value;
- (void)removeCommentObject:(QFComment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

- (void)addReplyCommentObject:(QFComment *)value;
- (void)removeReplyCommentObject:(QFComment *)value;
- (void)addReplyComment:(NSSet *)values;
- (void)removeReplyComment:(NSSet *)values;

@end
