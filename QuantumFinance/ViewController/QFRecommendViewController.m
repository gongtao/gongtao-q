//
//  QFRecommendViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFRecommendViewController.h"

#import "QFRecommendProductCell.h"

#import "QFHeadLineView.h"

@interface QFRecommendViewController ()
{
    NSUInteger _loadCount;
}

@property (nonatomic, strong) UITableViewCell *firstCell;

@property (nonatomic, strong) UITableViewCell *secondCell;

@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
    
@property (nonatomic, assign) BOOL reloading;
    
@property (nonatomic, assign) QFNewsType type;

@end

@implementation QFRecommendViewController

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
    self.type = QFNewsSolidType;
    
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
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)startLoadingTableViewData
{
    if (_reloading) {
        [self doneLoadingTableViewData];
    }
    NSInteger count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if (0 == count) {
        [_refreshHeaderView egoRefreshScrollViewWillBeginDragging:self.tableView];
        [UIView animateWithDuration:0.3
                         animations:^(void){
                             self.tableView.contentOffset = CGPointMake(0.0, -65.0);
                         }
                         completion:^(BOOL finished){
                             [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.tableView];
                         }];
    }
}

#pragma mark - Override

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:Product_Entity inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(%K == %@) AND (%K > %@) AND (%K <= %@)", kType, [NSNumber numberWithInteger:QFNewsSolidType], kOrder, [NSNumber numberWithInteger:0], kOrder, [NSNumber numberWithInteger:10]]];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:kOrder ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    return request;
}

- (NSString *)cacheName
{
    return @"Recommend";
}

- (void)configCell:(QFRecommendProductCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    NSInteger row = [indexPath row];
    QFProduct *product = [fetchedResultsController objectAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    if ([indexPath row] == 0) {
        if (!_firstCell) {
            _firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            QFHeadLineView *headLineView = [[QFHeadLineView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 156.0)];
            [_firstCell addSubview:headLineView];
        }
        return _firstCell;
    }
    else if ([indexPath row] == 1) {
        if (!_secondCell) {
            _secondCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        return _secondCell;
    }
    
    static NSString *CellIdentifier = @"RecommendListCell";
    QFRecommendProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[QFRecommendProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configCell:cell cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:indexPath.section] fetchedResultsController:fetchedResultsController];
    
    return cell;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    _loadCount = 3;
    [[QFNewsManager sharedManager] getPPTListPage:1
                                          success:^(NSArray *array){
                                              [self doneLoadingTableViewData];
                                          }
                                          failure:^(NSError *error){
                                              [self doneLoadingTableViewData];
                                          }];
    
    [[QFNewsManager sharedManager] getProductListType:QFNewsRadicalType
                                                 Page:1
                                              success:^(NSArray *array){
                                                  [self doneLoadingTableViewData];
                                              }
                                              failure:^(NSError *error){
                                                  [self doneLoadingTableViewData];
                                              }];
    
    [[QFNewsManager sharedManager] getProductListType:QFNewsSolidType
                                                 Page:1
                                              success:^(NSArray *array){
                                                  [self doneLoadingTableViewData];
                                              }
                                              failure:^(NSError *error){
                                                  [self doneLoadingTableViewData];
                                              }];
}

- (void)doneLoadingTableViewData
{
    _loadCount--;
    if (_loadCount == 0) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
//    [self refreshLastUpdateTime];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [super controller:controller didChangeObject:anObject atIndexPath:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:indexPath.section] forChangeType:type newIndexPath:[NSIndexPath indexPathForRow:newIndexPath.row+2 inSection:newIndexPath.section]];
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    return count+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    if (row == 0) {
        return 156.0;
    }
    else if (row == 1) {
        return 44.0;
    }
    return 109.0;
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
