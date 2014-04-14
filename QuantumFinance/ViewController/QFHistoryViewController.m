//
//  QFHistoryViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFHistoryViewController.h"

#import "QFHistorySectionView.h"

#import "QFHistoryCell.h"

@interface QFHistoryViewController ()
{
    NSString *_cache;
    
    UIView *_footerLoadingView;
    
    UIButton *_footerButton;
    
    UIActivityIndicatorView *_activityView;
    
    AFHTTPRequestOperation *_request;
    
    UIView *_footerView;
    
    NSInteger _page;
    
}

- (void)reloadTableViewDataSource;

- (void)_finishLoadMore:(BOOL)isFinished;

- (void)_loadMore:(UIButton *)sender;

- (void)_initFooterView;

- (NSUInteger)_getDataCount;

@end

@implementation QFHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.rowAnimation = UITableViewRowAnimationNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QFHistorySectionView class] forHeaderFooterViewReuseIdentifier:@"headerView"];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    [self _initFooterView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - Public

- (void)refreshLastUpdateTime
{
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)startLoadingTableViewData
{
    if (_reloading) {
        [self doneLoadingTableViewData];
    }
    NSInteger count = [self _getDataCount];
    if (0 == count) {
        _page = 1;
        [_refreshHeaderView egoRefreshScrollViewWillBeginDragging:self.tableView];
        [UIView animateWithDuration:0.3
                         animations:^(void){
                             self.tableView.contentOffset = CGPointMake(0.0, -65.0);
                             
                         }
                         completion:^(BOOL finished){
                             self.tableView.contentOffset = CGPointMake(0.0, -65.0);
                             [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.tableView];
                         }];
    }
    else {
        _page = count/10+((count%10!=0)?2:1);
    }
}

- (void)_finishLoadMore:(BOOL)isFinished
{
    if (isFinished) {
        [_activityView stopAnimating];
    }
    else {
        [_activityView startAnimating];
    }
    [_footerLoadingView setHidden:isFinished];
    [_footerButton setHidden:!isFinished];
}

- (void)_loadMore:(UIButton *)sender
{
    [self _finishLoadMore:NO];
    _request = [[QFNewsManager sharedManager] getHistoryListPage:_page
                                                         success:^(NSArray *array){
                                                             [self _finishLoadMore:YES];
                                                         }
                                                         failure:^(NSError *error){
                                                             [self _finishLoadMore:YES];
                                                         }];
}

- (void)_initFooterView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        _footerButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
        _footerButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_footerButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [_footerButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [_footerButton addTarget:self action:@selector(_loadMore:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_footerButton];
        
        _footerLoadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
        _footerLoadingView.backgroundColor = [UIColor clearColor];
        [_footerView addSubview:_footerLoadingView];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithHexString:@"999999"];
        label.text = @"正在加载更多。。。";
        [label sizeToFit];
        label.center = CGPointMake(160.0, 25.0);
        [_footerLoadingView addSubview:label];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.center = CGPointMake(70.0, 25.0);
        [_footerLoadingView addSubview:_activityView];
        
        [self _finishLoadMore:YES];
    }
}

- (NSUInteger)_getDataCount
{
    __block NSUInteger count = 0;
    [[self.fetchedResultsController sections] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        count += [obj numberOfObjects];
    }];
    return count;
}

#pragma mark - Super Method

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:Product_Entity inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"isHistory == YES"];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    return request;
}

- (NSString *)sectionNameKeyPath
{
    return @"date";
}

- (NSString *)cacheName
{
    return @"History";
}

- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    static NSString *CellIdentifier = @"HistoryCell";
    QFHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[QFHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configCell:cell cellForRowAtIndexPath:indexPath fetchedResultsController:fetchedResultsController];
    return cell;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    if (_request) {
        [_request cancel];
        _request = nil;
    }
    [self _finishLoadMore:YES];
    _reloading = YES;
    _page = 1;
    _request = [[QFNewsManager sharedManager] getHistoryListPage:_page
                                                         success:^(NSArray *array){
                                                             [self doneLoadingTableViewData];
                                                         }
                                                         failure:^(NSError *error){
                                                             [self doneLoadingTableViewData];
                                                         }];
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self refreshLastUpdateTime];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.tableView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        [_refreshHeaderView egoRefreshScrollViewWillBeginDragging:scrollView];
    }
}


#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([[self.fetchedResultsController sections] count] == section) {
        [self _initFooterView];
        return _footerView;
    }
    QFHistorySectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!sectionView) {
        sectionView = [[QFHistorySectionView alloc] initWithReuseIdentifier:@"headerView"];
    }
    [sectionView setFirstSection:(0 == section)];
    id<NSFetchedResultsSectionInfo> obj = [[self.fetchedResultsController sections] objectAtIndex:section];
    [sectionView setSectionTitle:[obj name]];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSUInteger count = [self _getDataCount];
    if (0 == count) {
        _page = 1;
    }
    else {
        _page = count/10+((count%10==0)?1:2);
    }
    if ([[self.fetchedResultsController sections] count] == section) {
        if (count < 10) {
            return 0.0;
        }
        return 50.0;
    }
    return 49.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"section num %i", [[self.fetchedResultsController sections] count]);
    return [[self.fetchedResultsController sections] count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section %i", section);
    if ([[self.fetchedResultsController sections] count] == section) {
        return 0;
    }
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0;
}

#pragma mark EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _reloading; // should return if data source model is reloading
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate new];
    
}

#pragma mark - 

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:self.rowAnimation];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:self.rowAnimation];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:self.rowAnimation];
            break;
        case NSFetchedResultsChangeMove:
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:self.rowAnimation];
            break;
            
    }
}

@end
