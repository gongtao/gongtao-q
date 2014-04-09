//
//  QFPerspectiveViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFPerspectiveViewController.h"

#import "QFPerspectiveTableViewController.h"

@interface QFPerspectiveViewController ()

@end

@implementation QFPerspectiveViewController

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
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName: News_Entity inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDesciptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    //request.predicate = [NSPredicate predicateWithFormat:@"news.nid == %@",_news.nid];isNew == YES 和 news == Nil
    request.predicate = [NSPredicate predicateWithFormat:@"isNew == Yes AND headLine == Nil"];

    [request setSortDescriptors:[NSArray arrayWithObject:sortDesciptor]];
    
    QFPerspectiveTableViewController *newsVC = [[QFPerspectiveTableViewController alloc] initWithRequest:request cacheName:@"cachePerspectiveNews"];
    newsVC.view.frame=CGRectMake(0, 32, self.view.bounds.size.width, self.view.bounds.size.height-85);
    newsVC.tableView.frame=CGRectMake(0, 32, self.view.bounds.size.width, self.view.bounds.size.height-85);
    [self addChildViewController:newsVC];
    [self.view addSubview:newsVC.view];
    [newsVC startLoadingTableViewData];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
