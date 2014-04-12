//
//  QFNewsDetailViewController.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-9.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFNewsDetailViewController.h"

#import "QFNewsDetailTableViewController.h"

#import "QFNewsDetailToolBar.h"

#import "QFNewsDetailToolBar.h"

@interface QFNewsDetailViewController ()
{
    
}

@property(nonatomic,strong)QFNewsDetailToolBar *toolBar;

@end

@implementation QFNewsDetailViewController

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
    NSLog(@"%@", self.news);
    CGFloat y = IS_IOS7?64.0:44.0;
    self.toolBar = [[QFNewsDetailToolBar alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.view.frame)-55, 320.0, 55.0)];
    NSLog(@"%f",CGRectGetMaxY(self.view.frame));
    self.toolBar.delegate = self;
    
    [self.view addSubview:self.toolBar];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName: Comment_Entity inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:kCommentDate ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"news.nid == %@",_news.nid];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    
    QFNewsDetailTableViewController *commentVC = [[QFNewsDetailTableViewController alloc] initWithRequest:request cacheName:@"cachePerspectiveComment"];
    commentVC.news=_news;
    commentVC.view.frame=CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-55-y);
    commentVC.tableView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-55-y);
    NSLog(@"%f,%f",self.view.bounds.size.width,self.view.bounds.size.height);
    [self addChildViewController:commentVC];
    [self.view addSubview:commentVC.view];
    
    [commentVC startLoadingTableViewData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
