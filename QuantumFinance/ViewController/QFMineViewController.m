//
//  QFMineViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFMineViewController.h"

#import "QFCustomButton.h"

@interface QFMineViewController ()

@end

static NSString *cellIdentifier = @"mineCell";

@implementation QFMineViewController

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
    //_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 84, self.view.bounds.size.width, self.view.bounds.size.height-44)];
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds];

    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    QFCustomButton *button=[[QFCustomButton alloc]initWithFrame:CGRectMake(0, 0, 300, 60)];
    button.imageRect=CGRectMake(0, 0, 130, 60);
    button.titleRect=CGRectMake(200, 17, 80, 25);
    button.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
    [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    button.center=CGPointMake(cell.frame.size.width/2, 40);
    //NSLog(@"%f,%f",cell.frame.size.width,cell.frame.size.height);
    //UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_图标底板.png"]];
    NSString *imageName,*titleName;
    NSString *buttonIdentifier;
    switch ([indexPath row]) {
        case 0:
            buttonIdentifier=@"settingViewController";
            button.tag=50+[indexPath row];
            imageName=@"我的_个人设置图标.png";
            titleName=@"我的账号";
            
            break;
        case 1:
            buttonIdentifier=@"evaluationViewController";
            button.tag=50+[indexPath row];
            imageName=@"我的_理财评估图标.png";
            titleName=@"理财评估";
            break;
        case 2:
            buttonIdentifier=@"collectionViewController";
            button.tag=50+[indexPath row];
            imageName=@"我的_我的收藏图标.png";
            titleName=@"我的收藏";
            break;
        case 3:
            buttonIdentifier=@"aboutViewController";
            button.tag=50+[indexPath row];
            imageName=@"我的_关于我们图标.png";
            titleName=@"关于我们";
            break;
        default:
            break;
    }
    [button setTitle:titleName forState:UIControlStateNormal];
    UIImage *image1=[UIImage imageNamed:@"我的_图标底板.png"];
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    UIImage *image2=[UIImage imageNamed:imageName];
    [image2 drawInRect:CGRectMake(40, 20, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [button setImage:resultingImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickWithIdentifier:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:button];
    
    return cell;
    
}

-(void)buttonClickWithIdentifier:(UIButton *)button
{
    NSString *vcIdentifier;
    switch (button.tag) {
        case 50:
            vcIdentifier=@"settingViewController";
            break;
        case 51:
            vcIdentifier=@"evaluationViewController";
            break;
        case 52:
            vcIdentifier=@"collectionViewController";
            break;
        case 53:
            vcIdentifier=@"aboutViewController";
            break;
        default:
            break;
    }
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:vcIdentifier];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
