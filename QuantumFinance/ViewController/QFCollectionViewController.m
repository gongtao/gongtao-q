//
//  QFCollectionViewController.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-14.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFCollectionViewController.h"

#import "QFCollectionTableViewController.h"

@interface QFCollectionViewController ()

@end

@implementation QFCollectionViewController

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
    CGFloat y = IS_IOS7?64.0:44.0;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName: News_Entity inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"isCollect == %@",[NSNumber numberWithBool:YES]];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    
    QFCollectionTableViewController *newsVC = [[QFCollectionTableViewController alloc] initWithRequest:request cacheName:@"cacheCollection"];
    newsVC.view.frame=CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height);
    newsVC.tableView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    newsVC.view.backgroundColor=[UIColor clearColor];
    [self addChildViewController:newsVC];
    [self.view addSubview:newsVC.view];
    //[newsVC startLoadingTableViewData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
