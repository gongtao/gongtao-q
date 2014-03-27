//
//  QFRootViewController.m
//  QuantumFinance
//
//  Created by 龚涛 on 3/27/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import "QFRootViewController.h"

@interface QFRootViewController ()

@property (nonatomic, strong) QFToolBar *toolBar;

- (void)_selectSubVCAtIndex:(NSUInteger)index;

@end

@implementation QFRootViewController

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
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, y, 320.0, self.view.frame.size.height-y-55.0)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    
    self.subVCDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    self.toolBar = [[QFToolBar alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.contentView.frame), 320.0, 55.0)];
    self.toolBar.delegate = self;
    [self.view addSubview:self.toolBar];
    [self.toolBar selectedTagAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)_selectSubVCAtIndex:(NSUInteger)index
{
    NSString *identifier = nil;
    switch (index) {
        case 0: {
            identifier = @"recommendViewController";
            break;
        }
        case 1: {
            identifier = @"perspectiveViewController";
            break;
        }
        case 2: {
            identifier = @"historyViewController";
            break;
        }
        case 3: {
            identifier = @"mineViewController";
            break;
        }
        default:
            break;
    }
    if (identifier) {
        if (self.currentVC) {
            [self.currentVC.view removeFromSuperview];
            [self.currentVC removeFromParentViewController];
            self.currentVC = nil;
        }
        self.currentVC = [self.subVCDic objectForKey:identifier];
        if (!self.currentVC) {
            self.currentVC = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
            self.currentVC.view.frame = self.contentView.bounds;
            [self.subVCDic setObject:self.currentVC forKey:identifier];
        }
        [self.contentView addSubview:self.currentVC.view];
        [self addChildViewController:self.currentVC];
        self.index = index;
        self.customNavigationBar.titleLabel.text = self.currentVC.title;
    }
}

#pragma mark - BMToolBarDelegate

- (void)didSelectTagAtIndex:(NSUInteger)index
{
    [self _selectSubVCAtIndex:index];
}

@end
