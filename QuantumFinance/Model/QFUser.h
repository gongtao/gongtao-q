//
//  QFUser.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/1/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QFUser : NSManagedObject

@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSString * isMainUser;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) NSSet *replyComment;
@end

@interface QFUser (CoreDataGeneratedAccessors)

- (void)addCommentObject:(NSManagedObject *)value;
- (void)removeCommentObject:(NSManagedObject *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

- (void)addReplyCommentObject:(NSManagedObject *)value;
- (void)removeReplyCommentObject:(NSManagedObject *)value;
- (void)addReplyComment:(NSSet *)values;
- (void)removeReplyComment:(NSSet *)values;

@end
