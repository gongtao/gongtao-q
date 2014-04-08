//
//  QFNewsManager.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFNewsManager.h"

#import <SDImageCache.h>

#import "QFUtils.h"

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

#pragma mark - Interface

- (void)createProductListFromNetworking:(NSArray *)array type:(QFNewsType)type context:(NSManagedObjectContext *)context
{
    if (array && (NSNull *)array != [NSNull null] && array.count>0) {
        NSArray *olderArray = [self getRecommendProductsByType:type context:context];
        [olderArray enumerateObjectsUsingBlock:^(QFProduct *obj, NSUInteger idx, BOOL *stop){
            obj.order = [NSNumber numberWithInteger:0];
        }];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop){
            QFProduct *product = [self createProduct:obj context:context];
            product.type = [NSNumber numberWithInteger:type];
            product.order = [NSNumber numberWithInteger:idx+1];
        }];
    }
}

- (void)createNewsListFromNetworking:(NSArray *)array context:(NSManagedObjectContext *)context
{
    if (array && (NSNull *)array != [NSNull null] && array.count>0) {
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop){
            QFNews *news = [self createNews:obj context:context];
            news.isNew = [NSNumber numberWithBool:YES];
        }];
    }
}

#pragma mark - Database

//Product
- (QFProduct *)createProduct:(NSDictionary *)dic context:(NSManagedObjectContext *)context
{
    NSNumber *pid = dic[@"id"];
    
    if (!pid || (NSNull *)pid == [NSNull null]) {
        NSLog(@"Product: pid null");
        return nil;
    }
    
    QFProduct *product = [self getProductById:pid.integerValue context:context];
    
    if (!product) {
        product = [NSEntityDescription insertNewObjectForEntityForName:Product_Entity inManagedObjectContext:context];
        product.pid = pid;
    }
    
    NSString *deadline = dic[@"deadline"];
    if (deadline && (NSNull *)deadline != [NSNull null]) {
        product.deadline = [NSNumber numberWithInteger:[deadline integerValue]];
    }
    
    NSString *eair = dic[@"eair"];
    if (eair && (NSNull *)eair != [NSNull null]) {
        product.eair = eair;
    }
    
    NSString *schedule = dic[@"schedule"];
    if (schedule && (NSNull *)schedule != [NSNull null]) {
        product.schedule = schedule;
    }
    
    NSString *source = dic[@"source"];
    if (source && (NSNull *)source != [NSNull null]) {
        product.source = source;
    }
    
    NSString *title = dic[@"title"];
    if (title && (NSNull *)title != [NSNull null]) {
        product.title = title;
    }
    
    return product;
}

- (QFProduct *)getProductById:(NSUInteger)pid context:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:Product_Entity inManagedObjectContext:context];
    
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K == %i", kPid, pid]];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error && results.count > 0) {
        return results[0];
    }
    return nil;
}

- (NSArray *)getRecommendProductsByType:(QFNewsType)type context:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:Product_Entity inManagedObjectContext:context];
    
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(%K == %i) AND (%K > %i) AND (%K <= %i)", kType, type, kOrder, 0, kOrder, 10]];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error && results.count > 0) {
        return results;
    }
    return nil;
}

//News
- (QFNews *)createNews:(NSDictionary *)dic context:(NSManagedObjectContext *)context
{
    NSNumber *nid = dic[@"id"];
    
    if (!nid || (NSNull *)nid == [NSNull null]) {
        NSLog(@"Product: pid null");
        return nil;
    }
    
    QFNews *news = [self getNewsById:nid.integerValue context:context];
    
    if (!news) {
        news = [NSEntityDescription insertNewObjectForEntityForName:News_Entity inManagedObjectContext:context];
        news.nid = nid;
    }
    
    NSNumber *viewCount = dic[@"view_count"];
    if (viewCount && (NSNull *)viewCount != [NSNull null]) {
        news.viewCount = viewCount;
    }
    
    NSNumber *commentCount = dic[@"comments"];
    if (commentCount && (NSNull *)commentCount != [NSNull null]) {
        news.commentCount = commentCount;
    }
    
    NSString *date = dic[@"updated_at"];
    if (date && (NSNull *)date != [NSNull null]) {
        news.date = [QFUtils dateFromString:date];
    }
    
    NSString *logo = dic[@"logo"];
    if (logo && (NSNull *)logo != [NSNull null]) {
        news.logo = logo;
    }
    
    NSString *content = dic[@"content"];
    if (content && (NSNull *)content != [NSNull null]) {
        news.content = content;
    }
    
    NSString *title = dic[@"title"];
    if (title && (NSNull *)title != [NSNull null]) {
        news.title = title;
    }
    
    return news;
}

- (QFNews *)getNewsById:(NSUInteger)nid context:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:News_Entity inManagedObjectContext:context];
    
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K == %i", kNid, nid]];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error && results.count > 0) {
        return results[0];
    }
    return nil;
}

- (NSArray *)getAllNewsByContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:Product_Entity inManagedObjectContext:context];
    
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"headLine == %@", Nil]];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error && results.count > 0) {
        return results;
    }
    return nil;
}

#pragma mark - Networking

- (AFHTTPRequestOperation *)getProductListType:(QFNewsType)type
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
            
            NSManagedObjectContext *temporaryContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            temporaryContext.parentContext = [self managedObjectContext];
            
            [temporaryContext performBlock:^{
                [self createProductListFromNetworking:responseObject type:type context:temporaryContext];
                [self saveContext:temporaryContext];
                // save parent to disk asynchronously
                [temporaryContext.parentContext performBlock:^{
                    [self saveContext:temporaryContext.parentContext];
                    if (success) {
                        success(nil);
                    }
                }];
            }];
        }
        else {
            if (failure) {
                failure(nil);
            }
        }
    };
    
    void (^requestFailure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    };
    
    AFHTTPRequestOperation *op = [_manager GET:@"loan_informations/promoted_products.json" parameters:param success:requestSuccess failure:requestFailure];
    NSLog(@"request: %@", op.request.URL.absoluteString);
    return op;
}

- (AFHTTPRequestOperation *)getNewsListPage:(NSUInteger)page
                                    success:(void (^)(NSArray *array))success
                                    failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"page": [NSNumber numberWithInt:page],
                            @"per_page": [NSNumber numberWithInt:10]};
    
    void (^requestSuccess)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != [NSNull null]) {
            NSLog(@"%@", responseObject);
            
            NSManagedObjectContext *temporaryContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            temporaryContext.parentContext = [self managedObjectContext];
            
            [temporaryContext performBlock:^{
                if (page == 1) {
                    NSArray *array = [self getAllNewsByContext:temporaryContext];
                    [array enumerateObjectsUsingBlock:^(QFNews *obj, NSUInteger idx, BOOL *stop){
                        obj.isNew = [NSNumber numberWithBool:NO];
                    }];
                }
                [self createNewsListFromNetworking:responseObject context:temporaryContext];
                [self saveContext:temporaryContext];
                // save parent to disk asynchronously
                [temporaryContext.parentContext performBlock:^{
                    [self saveContext:temporaryContext.parentContext];
                    if (success) {
                        success(nil);
                    }
                }];
            }];
        }
        else {
            if (failure) {
                failure(nil);
            }
        }
    };
    
    void (^requestFailure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    };
    
    AFHTTPRequestOperation *op = [_manager GET:@"comments/expert_comments_list.json" parameters:param success:requestSuccess failure:requestFailure];
    NSLog(@"request: %@", op.request.URL.absoluteString);
    return op;
}


@end
