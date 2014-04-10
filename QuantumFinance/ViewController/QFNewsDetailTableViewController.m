//
//  QFNewsDetailTableViewController.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-10.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFNewsDetailTableViewController.h"

@interface QFNewsDetailTableViewController ()
{
    NSString *_cache;
    
    UIView *_footerLoadingView;
    
    UIButton *_footerButton;
    
    UIActivityIndicatorView *_activityView;
    
    AFHTTPRequestOperation *_request;
    
    UITableViewCell *_footerView;
    
    NSInteger _page;
}

@property (nonatomic,strong)NSFetchRequest* fetchRequest;

@property(nonatomic,strong)NSNumber *contentHeight;

@property (nonatomic, strong) UITableViewCell *firstCell;

@property (nonatomic, strong) UITableViewCell *secondCell;

@property(nonatomic,strong)UITableViewCell *thirdCell;

@property(nonatomic,strong)UILabel *labelContent;

- (void)_finishLoadMore:(BOOL)isFinished;

- (void)_loadMore:(UIButton *)sender;

- (void)_initFooterView;


@end

@implementation QFNewsDetailTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRequest:(NSFetchRequest *)request cacheName:(NSString *)cache
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        _fetchRequest = request;
        _fetchRequest.fetchBatchSize = 10;
        _cache = cache;
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
    
    [self _initFooterView];
    
    _labelContent = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//必须是这组值,这个frame是初设的，没关系，后面还会重新设置其size。
    [_labelContent setNumberOfLines:0];  //必须是这组值
    
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake(300,3000);
    NSString *newContent=[NSString stringWithFormat:@"%@\n\n评论：%@ 浏览：%@ %@",_news.content,_news.commentCount,_news.viewCount,_news.date];
    CGSize labelsize = [newContent sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeWordWrap:以空格为界,保留整个单词
    _labelContent.frame = CGRectMake(10, 240, labelsize.width, labelsize.height );
    _labelContent.backgroundColor = [UIColor colorWithHexString:@"f0f4f7"];
    _labelContent.textColor = [UIColor colorWithHexString:@"666666"];
    _labelContent.text = newContent;
    _labelContent.font = font;
    _contentHeight=[NSNumber numberWithFloat:labelsize.height];
    
    [NSFetchedResultsController deleteCacheWithName:[self cacheName]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [NSFetchedResultsController deleteCacheWithName:[self cacheName]];
}

- (void)startLoadingTableViewData
{
    NSInteger count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if (0 == count) {
        _page = 1;
        [self reloadTableViewDataSource];
        
    }
    else {
        _page = count/10+((count%10!=0)?2:1);
    }
}

- (void)reloadTableViewDataSource
{
    if (_request) {
        [_request cancel];
        _request = nil;
    }
    [self _finishLoadMore:YES];
    _page = 1;
    _request=[[QFNewsManager sharedManager]getCommentsListNews:_news
                                                          Page:_page
                                                       success:^(NSArray *array){
                                                           //[self _finishLoadMore:YES];
                                                       }
                                                       failure:^(NSError *array){
                                                           //[self _finishLoadMore:YES];
                                                       }];

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
    _request=[[QFNewsManager sharedManager]getCommentsListNews:_news
                                                          Page:_page
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
    if (_fetchRequest) {
        return _fetchRequest;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:Comment_Entity inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:kCommentDate ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"news.nid == %@",_news.nid];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    return request;
}

- (NSString *)cacheName
{
    return _cache;
}

- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    QFComment *comment = [fetchedResultsController objectAtIndexPath:indexPath];
    //QFPerspectiveCell *perspectiveCell = (QFPerspectiveCell *)cell;
    //[perspectiveCell configPerspectiveCell:news];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    int row=[indexPath row];
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if (row == count) {
        [self _initFooterView];
        return _footerView;
    }
    else if (row == 0) {
        if (!_firstCell) {
            _firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            _firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 180)];
            [imageView setImageWithURL:[NSURL URLWithString:_news.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){}];
            [_firstCell addSubview:imageView];
        }
        return _firstCell;
    }
    else if (row==1)
    {
        if (!_secondCell) {
            _secondCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            _secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *LabelTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 82, 40)];
            //LabelTitle.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"xx.png"]];
            LabelTitle.backgroundColor=[UIColor colorWithHexString:@"0f9fde"];
            LabelTitle.font=[UIFont systemFontOfSize:14];
            LabelTitle.textColor=[UIColor colorWithHexString:@"ffffff"];
            LabelTitle.text=_news.title;
            [_secondCell addSubview:LabelTitle];
        }
        return _secondCell;
    }
    else if (row==2)
    {
        if (!_thirdCell) {
            _thirdCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            _thirdCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [_thirdCell addSubview:_labelContent];
        }
        return _thirdCell;
        
    }

    static NSString *CellIdentifier = @"QFCommentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    [self configCell:cell cellForRowAtIndexPath:indexPath fetchedResultsController:fetchedResultsController];
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [super controller:controller didChangeObject:anObject atIndexPath:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:indexPath.section] forChangeType:type newIndexPath:[NSIndexPath indexPathForRow:newIndexPath.row+3 inSection:newIndexPath.section]];
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
    return count+3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if (row == count) {
        if (count < 10) {
            return 0.0;
        }
        else {
            return 50.0;
        }
    }
    if (row == 0) {
        return 156.0;
    }
    else if (row == 1) {
        return 50.0;
    }
    else if(row==2)
    {
        return _contentHeight.floatValue;
    }
    return 108.0;
}


@end