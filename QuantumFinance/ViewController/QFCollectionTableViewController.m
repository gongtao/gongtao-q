//
//  QFCollectionTableViewController.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-14.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFCollectionTableViewController.h"

#import "QFNewsDetailViewController.h"

#import "QFPerspectiveCell.h"

@interface QFCollectionTableViewController ()
{
    NSString *_cache;
    AFHTTPRequestOperation *_request;
}

@property (nonatomic,strong)NSFetchRequest* fetchRequest;

@end

@implementation QFCollectionTableViewController

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
        _fetchRequest.fetchBatchSize = 16;
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
    
    [NSFetchedResultsController deleteCacheWithName:[self cacheName]];
    [self reloadTableViewDataSource];
    

}

- (void)reloadTableViewDataSource
{
    if (_request) {
        [_request cancel];
        _request = nil;
    }
    _request=[[QFNewsManager sharedManager]getNewsListPage:1
                                                   success:^(NSArray *array){
                                                       
                                                   }
                                                   failure:^(NSError *error){
                                                       
                                                   }];
}

- (NSFetchRequest *)fetchRequest
{
    if (_fetchRequest) {
        return _fetchRequest;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:News_Entity inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"isCollect == %@",[NSNumber numberWithBool:YES]];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    return request;
}

- (NSString *)cacheName
{
    return _cache;
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

- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    QFNews *news = [fetchedResultsController objectAtIndexPath:indexPath];
    QFPerspectiveCell *perspectiveCell = (QFPerspectiveCell *)cell;
    [perspectiveCell configPerspectiveCell:news];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    NSLog(@"count:%i",count);
    static NSString *CellIdentifier = @"QFCollectednewsCell";
    QFPerspectiveCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[QFPerspectiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.button.tag=100+[indexPath row];
        //NSLog(@"tag:%ld",(long)cell.button.tag);
        //[cell.button addTarget:self action:@selector(cellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self configCell:cell cellForRowAtIndexPath:indexPath fetchedResultsController:fetchedResultsController];
    //[cell.contentView addSubview:cell.button];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFNews *news = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //NSLog(@"%@",news.nid);
    if (news) {
        QFNewsDetailViewController *vc = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"newsDetailViewController"];
        vc.news=news;
        //UIView *view=[vc.view viewWithTag:101];
        //[view removeFromSuperview];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


-(void)cellButtonPressed:(UIButton*)button
{
    int tag=button.tag-100;
    //NSLog(@"tag:%d",tag);
    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:tag inSection:0];
    QFNews *news = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //NSLog(@"%@",news.nid);
    if (news) {
        QFNewsDetailViewController *vc = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"newsDetailViewController"];
        vc.news=news;
        //UIView *view=[vc.view viewWithTag:101];
        //[view removeFromSuperview];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


@end
