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

@property(nonatomic,strong)NSNumber *cellHeight;

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
    
    _labelContent = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //必须是这组值,这个frame是初设的，没关系，后面还会重新设置其size。
    [_labelContent setNumberOfLines:0];  //必须是这组值
    
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake(282,NSIntegerMax);
    NSString *newContent=[NSString stringWithFormat:@"%@\n\n评论：%@ 浏览：%@ %@",_news.content,_news.commentCount,_news.viewCount,_news.date];
    CGSize labelsize = [newContent boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    //UILineBreakModeWordWrap:以空格为界,保留整个单词
    _labelContent.frame = CGRectMake(9, 9, 282, labelsize.height );
    //_labelContent.backgroundColor = [UIColor colorWithHexString:@"f0f4f7"];
    _labelContent.backgroundColor=[UIColor clearColor];
    _labelContent.textColor = [UIColor colorWithHexString:@"666666"];
    _labelContent.text = newContent;
    _labelContent.font = font;
    _contentHeight=[NSNumber numberWithFloat:labelsize.height];
    //NSLog(@"contentHeight:%@",_contentHeight);
    //NSLog(@"%@",newContent);
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
                                                           [self _finishLoadMore:YES];
                                                       }
                                                       failure:^(NSError *array){
                                                           [self _finishLoadMore:YES];
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
    //NSLog(@"%i",[indexPath row]);
    //cell.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
    NSIndexPath *newIndex=[NSIndexPath indexPathForItem:[indexPath row]-3 inSection:0];
    QFComment *comment = [fetchedResultsController objectAtIndexPath:newIndex];
    NSLog(@"%@",comment);
    
    UILabel *labelComment = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [labelComment setNumberOfLines:0];
    UIFont *font = [UIFont systemFontOfSize:12];
    NSString *content=comment.content;
    
    CGSize labelsize = [content boundingRectWithSize:CGSizeMake(246,NSIntegerMax) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    
    //UILineBreakModeWordWrap:以空格为界,保留整个单词
    labelComment.frame = CGRectMake(45, 24, 246, labelsize.height );
    labelComment.backgroundColor=[UIColor clearColor];
    //labelComment.backgroundColor = [UIColor colorWithHexString:@"f0f4f7"];
    labelComment.textColor = [UIColor colorWithHexString:@"666666"];
    labelComment.text = content;
    labelComment.font = font;
    _cellHeight=[NSNumber numberWithFloat:labelsize.height];
    
    CGFloat height=_cellHeight.floatValue+24>45?_cellHeight.floatValue+24:45;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(9, 0, 300, height)];
    view.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
    [view addSubview:labelComment];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(9, 9, 27, 27)];
    [imageView setImageWithURL:[NSURL URLWithString:comment.user.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){}];
    imageView.backgroundColor=[UIColor whiteColor];
    NSLog(@"%@",comment.user.avatar);
    
    [view addSubview:imageView];
    
    UILabel *userName=[[UILabel alloc]initWithFrame:CGRectMake(45, 9, 200, 12)];
    userName.backgroundColor=[UIColor clearColor];
    userName.textColor = [UIColor colorWithHexString:@"0e9fde"];
    userName.text = comment.user.name;
    userName.font = font;
    [view addSubview:userName];
    
    [cell addSubview:view];

    
    //QFPerspectiveCell *perspectiveCell = (QFPerspectiveCell *)cell;
    //[perspectiveCell configPerspectiveCell:news];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    int row=[indexPath row];
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    if (row == count+3) {
        [self _initFooterView];
        return _footerView;
    }
    else if (row == 0) {
        if (!_firstCell) {
            _firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            _firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
            [imageView setImageWithURL:[NSURL URLWithString:_news.logo] placeholderImage:[UIImage imageNamed:@"首页PPT默认图.png"]];
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [_firstCell addSubview:imageView];
        }
        return _firstCell;
    }
    else if (row == 1)
    {
        if (!_secondCell) {
            _secondCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            _secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *LabelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            LabelTitle.numberOfLines=0;
            CGSize labelsize = [_news.title boundingRectWithSize:CGSizeMake(277.0,NSIntegerMax) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 190.0, 62.0)];
            imageView.image = [[UIImage imageNamed:@"理财评估_标题底板.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 90.0)];
            imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
            imageView.frame=CGRectMake(9.0, 9.0, labelsize.width+25.0, 31.0);
            [_secondCell addSubview:imageView];

            LabelTitle.textAlignment = NSTextAlignmentCenter;
            LabelTitle.backgroundColor=[UIColor clearColor];
            LabelTitle.frame=CGRectMake(18.0, 9.0, labelsize.width, 31.0);
            LabelTitle.font=[UIFont systemFontOfSize:14];
            LabelTitle.textColor=[UIColor colorWithHexString:@"ffffff"];
            LabelTitle.text=_news.title;
            [_secondCell addSubview:LabelTitle];
            

        }
        return _secondCell;
    }
    else if (row == 2)
    {
        if (!_thirdCell) {
            _thirdCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            _thirdCell.backgroundColor=[UIColor clearColor];
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(9, 0, 300, _contentHeight.floatValue+18)];
            view.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
            [view addSubview:_labelContent];
            _thirdCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [_thirdCell addSubview:view];
            
        }
        return _thirdCell;
        
    }

    static NSString *CellIdentifier = @"QFCommentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
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
    if (row == count+3) {
        if (count < 10) {
            return 0.0;
        }
        else {
            return 50.0;
        }
    }
    if (row == 0) {
        return 180.0;
    }
    else if (row == 1) {
        
        return 48.0;
    }
    else if(row==2)
    {
        return _contentHeight.floatValue+27;
        //return 50;
    }
    
    return _cellHeight.floatValue+24>45?_cellHeight.floatValue+24:45;
}


@end
