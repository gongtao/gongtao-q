//
//  QFNewsManager.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFNewsManager.h"

#import <SDImageCache.h>

//#import <TencentOpenAPI/QQApiInterface.h>
//
//#import <TencentOpenAPI/TencentOAuth.h>

@interface QFNewsManager ()
{
    AFHTTPRequestOperationManager *_manager;
}

@end

@implementation QFNewsManager

+ (QFNewsManager *)sharedManager
{
    static QFNewsManager *sharedManagerInstance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[QFNewsManager alloc] init];
    });
    
    return sharedManagerInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:kBaseURL];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
        [_manager.operationQueue setMaxConcurrentOperationCount:3];
        
        NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024
                                                             diskCapacity:40 * 1024 * 1024
                                                                 diskPath:nil];
        [NSURLCache setSharedURLCache:URLCache];
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    id delegate = [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];
}

- (BOOL)saveContext:(NSManagedObjectContext *)context
{
    BOOL result = YES;
    NSError *error;
    
    if (![context hasChanges]) {
        return result;
    }
    
    result = [context save:&error];
    
    if (error) {
        NSLog(@"save context error: %@", error);
        abort();
    }
    
    return result;
}

- (BOOL)saveContext
{
    return [self saveContext:[self managedObjectContext]];
}

#pragma mark - Networking

- (AFHTTPRequestOperation *)getNewsListType:(QFNewsType)type
                                       Page:(NSUInteger)page
                                    success:(void (^)(NSArray *array))success
                                    failure:(void (^)(NSError *error))failure
{
    NSString *typeStr = nil;
    if (QFNewsSolidType == type) {
        typeStr = @"solid";
    }
    else if (QFNewsRadicalType == type) {
        typeStr = @"radical";
    }
    NSDictionary *param = @{@"type": typeStr,
                            @"page": [NSNumber numberWithInt:page],
                            @"per_page": [NSNumber numberWithInt:10]};
    
    void (^requestSuccess)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != [NSNull null]) {
            NSLog(@"%@", responseObject);
            
//            NSManagedObjectContext *temporaryContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//            temporaryContext.parentContext = [self managedObjectContext];
//            
//            [temporaryContext performBlock:^{
//                NewsCategory *newsCategory = [self getNewsCategoryById:cid context:temporaryContext];
//                
//                if (1 == page) {
//                    newsCategory.list = [NSOrderedSet orderedSet];
//                    newsCategory.refreshTime = [NSDate date];
//                }
//                
//                [self createNewsFromNetworking:responseObject newsCategory:newsCategory context:temporaryContext];
//                [self saveContext:temporaryContext];
//                // save parent to disk asynchronously
//                [temporaryContext.parentContext performBlock:^{
//                    [self saveContext:temporaryContext.parentContext];
//                    if (success) {
//                        success(nil);
//                    }
//                }];
//            }];
        }
        else {
            if (success) {
                success(nil);
            }
        }
    };
    
    void (^requestFailure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    };
    
    AFHTTPRequestOperation *op = [_manager GET:@"promoted_products.json" parameters:param success:requestSuccess failure:requestFailure];
    NSLog(@"request: %@", op.request.URL.absoluteString);
    return op;
}


@end
