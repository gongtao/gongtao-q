//
//  QFHistoryViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFHistoryViewController.h"

@interface QFHistoryViewController ()
{
    NSString *_cache;
    
    UIView *_footerLoadingView;
    
    UIButton *_footerButton;
    
    UIActivityIndicatorView *_activityView;
    
    AFHTTPRequestOperation *_request;
    
    UITableViewCell *_footerView;
    
    NSInteger _page;
    
}

- (void)reloadTableViewDataSource;

- (void)_finishLoadMore:(BOOL)isFinished;

- (void)_loadMore:(UIButton *)sender;

- (void)_initFooterView;

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
    NSInteger count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
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
    _request=[[QFNewsManager sharedManager]getNewsListPage:_page
                                                   success:^(NSArray *array){
                                                       [self _finishLoadMore:YES];
                                                       
                                                   }
                                                   failure:^(NSError *array){
                                                       [self _finishLoadMore:YES];
                                                   }];
}

- (void)_initFooterView
{
    if (!_footerView) {
        _footerView = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _footerView.backgroundColor = [UIColor clearColor];
        _footerView.selectionStyle = UITableViewCellSelectionStyleNone;
        
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


- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:Product_Entity inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"isHistory == Yes"];
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
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if ([indexPath row] == count) {
        [self _initFooterView];
        return _footerView;
    }
    static NSString *CellIdentifier = @"HistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if (0 == count) {
        _page = 1;
    }
    else {
        _page = count/10+((count%10==0)?1:2);
    }
    return count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if (row == count) {
        if (count < 10) {
            return 0.0;
        }
        else {
            return 50.0;
        }
    }
    return 120;
    
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

@end
