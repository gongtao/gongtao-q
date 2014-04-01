//
//  QFNewsManager.h
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

#import <AFNetworking.h>

#import "QFProduct.h"

#import "QFComment.h"

#import "QFUser.h"

#import "QFNews.h"

#define News_Entity             @"QFNews"
#define kNid                    @"nid"

#define Comment_Entity          @"QFComment"
#define kCommentDate            @"date"
#define kCommentId              @"cid"

#define User_Entity             @"QFUser"
#define kUid                    @"uid"
#define kIsMainUser             @"isMainUser"

#define Product_Entity          @"QFProduct"
#define kPid                    @"pid"

typedef enum {
    QFNewsNoneType,
    QFNewsSolidType,
    QFNewsRadicalType
}QFNewsType;

@interface QFNewsManager : NSObject

+ (QFNewsManager *)sharedManager;

- (NSManagedObjectContext *)managedObjectContext;

- (BOOL)saveContext:(NSManagedObjectContext *)context;

- (BOOL)saveContext;

/** Networking **/

- (AFHTTPRequestOperation *)getNewsListType:(QFNewsType)type
                                       Page:(NSUInteger)page
                                    success:(void (^)(NSArray *array))success
                                    failure:(void (^)(NSError *error))failure;

@end
