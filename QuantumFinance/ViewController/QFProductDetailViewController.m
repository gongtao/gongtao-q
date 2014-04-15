//
//  QFProductDetailViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 4/15/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFProductDetailViewController.h"

@interface QFProductDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation QFProductDetailViewController

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
    CGFloat y = CGRectGetMaxY(self.customNavigationBar.frame);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, y, 320.0, self.view.bounds.size.height-y)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
