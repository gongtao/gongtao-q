//
//  QFSubBaseViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFSubBaseViewController.h"

#import "QFCustomButton.h"

@interface QFSubBaseViewController ()

- (void)_backButtonPressed:(UIButton *)button;

@end

@implementation QFSubBaseViewController

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
    self.customNavigationBar.titleLabel.text = self.title;
    
    QFCustomButton *button = [[QFCustomButton alloc] initWithFrame:CGRectMake(0.0, self.customNavigationBar.frame.size.height-44.0, 44.0, 44.0)];
    button.imageRect = CGRectMake(6.0, 13.0, 32.0, 18.0);
    [button setImage:[UIImage imageNamed:@"标题栏返回.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)_backButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
