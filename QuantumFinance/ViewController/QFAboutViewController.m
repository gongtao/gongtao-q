//
//  QFAboutViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/28/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFAboutViewController.h"

@interface QFAboutViewController ()

@end

@implementation QFAboutViewController

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
    CGFloat y=IS_IPhone5_or_5s?130:70;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 151, 151)];
    imageView.image=[UIImage imageNamed:@"关于LOGO.png"];
    imageView.center=CGPointMake(self.view.frame.size.width/2, y+100);
    [self.view addSubview:imageView];
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-103, y+200, 103, 41)];
    imageView1.image=[UIImage imageNamed:@"关于名称底板.png"];
    [self.view addSubview:imageView1];

    UILabel *labelName=[[UILabel alloc]initWithFrame:imageView1.frame];
    labelName.center=CGPointMake(imageView1.center.x+10, imageView1.center.y);
    labelName.backgroundColor=[UIColor clearColor];
    labelName.font=[UIFont fontWithName:@"STHeitiSC-Light" size:19];
    labelName.text=@"财赋";
    labelName.textColor=[UIColor whiteColor];
    labelName.textAlignment=UITextAlignmentCenter;
   
    //self.view.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:labelName];
    UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, y+241, 90, 31)];
    imageView2.image=[UIImage imageNamed:@"关于版本底板.png"];
    [self.view addSubview:imageView2];
    
    UILabel *labelVersion=[[UILabel alloc]initWithFrame:imageView2.frame];
    labelVersion.center=imageView2.center;
    labelVersion.backgroundColor=[UIColor clearColor];
    labelVersion.font=[UIFont fontWithName:@"STHeitiSC-Light" size:15];
    labelVersion.text=@"版本：1.0";
    labelVersion.textColor=[UIColor colorWithHexString:@"0E9FDE"];
    labelVersion.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:labelVersion];
    
    UILabel *labelCompany=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 20)];
    labelCompany.center=CGPointMake(self.view.frame.size.width/2, y+330);
    labelCompany.backgroundColor=[UIColor clearColor];
    labelCompany.text=@"北京清弈谷网络科技有限公司";
    labelCompany.font=[UIFont fontWithName:@"STHeitiSC-Light" size:15];
    labelCompany.textColor=[UIColor colorWithHexString:@"666666"];
    labelCompany.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:labelCompany];
    
    UILabel *labelURL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 15)];
    labelURL.center=CGPointMake(self.view.frame.size.width/2, y+360);
    labelURL.backgroundColor=[UIColor clearColor];
    labelURL.text=@"www.qingyigu.com";
    labelURL.font=[UIFont fontWithName:@"STHeitiSC-Light" size:13];
    labelURL.textColor=[UIColor colorWithHexString:@"666666"];
    labelURL.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:labelURL];
    
    UILabel *labelTel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 15)];
    labelTel.center=CGPointMake(self.view.frame.size.width/2, y+390);
    labelTel.backgroundColor=[UIColor clearColor];
    labelTel.text=@"010-12345678";
    labelTel.font=[UIFont fontWithName:@"STHeitiSC-Light" size:13];
    labelTel.textColor=[UIColor colorWithHexString:@"666666"];
    labelTel.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:labelTel];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
