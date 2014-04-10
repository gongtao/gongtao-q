//
//  QFHeadLineView.m
//  QuantumFinance
//
//  Created by 龚涛 on 4/8/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFHeadLineView.h"

@interface QFHeadLineView ()

- (NSManagedObjectContext *)managedObjectContext;

@end

@implementation QFHeadLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"首页PPT默认图.png"];
        [self addSubview:imageView];
        
        _cyclePageView = [[GTCyclePageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        _cyclePageView.scrollView.showsHorizontalScrollIndicator = YES;
        _cyclePageView.dataSource = self;
        _cyclePageView.delegate = self;
        [self addSubview:_cyclePageView];
        [_cyclePageView reloadData];
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    id appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate managedObjectContext];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:HeadLine_Entity inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(%K > 0) && (%K <= 3)", kHid, kHid]];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:kHid ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:@"headLine"];
    _fetchedResultsController.delegate = self;
    
    NSError *error = NULL;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - GTCyclePageViewDataSource

- (NSUInteger)numberOfPagesInCyclePageView:(GTCyclePageView *)cyclePageView
{
    return [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
}

- (GTCyclePageViewCell *)cyclePageView:(GTCyclePageView *)cyclePageView index:(NSUInteger)index
{
    static NSString *identifier = @"cyclePageView";
    GTCyclePageViewCell *cell = [cyclePageView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[GTCyclePageViewCell alloc] initWithReuseIdentifier:identifier];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 99;
        [cell addSubview:imageView];
    }
    QFHeadLine *headLine = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:99];
    [imageView setImageWithURL:[NSURL URLWithString:headLine.logo]];
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [_cyclePageView reloadData];
}

@end
