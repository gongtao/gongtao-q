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

@interface QFNewsDetailViewController ()
{
    CGFloat y;
    BOOL Good;
    BOOL Collected;
    
}

@property(nonatomic,strong)QFNewsDetailToolBar *toolBar;

@property(nonatomic,strong)UIControl *mask;

-(IBAction)backgroundTap:(id)sender;


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
    //NSLog(@"%@", self.news);
    y = IS_IOS7?64.0:44.0;
    Good=_news.isGood.boolValue;
    Collected=_news.isCollect.boolValue;
    //Good=NO;
    self.toolBar = [[QFNewsDetailToolBar alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.view.frame)-55, 320.0, 55.0)];
    self.toolBar.delegate = self;
    [_toolBar checkDingButton:Good];
    [_toolBar checkCollectButton:Collected];
    
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

-(BOOL)isGood
{
    //NSLog(@"isgood:%i",Good);
    return Good;
}

-(BOOL)isCollected
{
    return  Collected;
}

- (void)shareButtonClicked
{}

- (void)collectButtonClicked:(BOOL)collected
{
    _news.isCollect=[NSNumber numberWithBool:collected];
    [[QFNewsManager sharedManager]collectNews:_news collect:collected];
    Collected=!Collected;
    //- (void)collectNews:(QFNews *)news collect:(BOOL)isCollect
    
}

- (void)dingButtonClicked
{
    _news.isGood=[NSNumber numberWithInt:1];
    [[QFNewsManager sharedManager]getPraiseNews:_news
                                        success:^{}
                                        failure:^(NSError *error){}
     ];
    Good=YES;
    
}

-(void)clickPublishButton:(UIButton *)button
{
}

- (void)commentButtonClicked
{
    _mask = [[UIControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [_mask addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    _mask.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_mask];
    
    //UIView *maskComment=[[UIView alloc]initWithFrame:CGRectMake(20, y+140, 280, 200)];
    //maskComment.backgroundColor=[UIColor clearColor];
    
    UIView *commentView=[[UIView alloc]initWithFrame:CGRectMake(20, y+140, 280, 200)];
    commentView.layer.masksToBounds=YES;
    //commentView.layer.cornerRadius=20.0;
    commentView.layer.borderWidth=1.0;
    commentView.layer.borderColor=[[UIColor colorWithHexString:@"0e9fde"] CGColor];
    commentView.backgroundColor=[UIColor whiteColor];
    commentView.alpha=0.9;
    [_mask addSubview:commentView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(125, y+150, 70, 15)];
    label.text=@"我要评论";
    label.textColor=[UIColor colorWithHexString:@"666666"];
    label.backgroundColor=[UIColor clearColor];
    [_mask addSubview:label];
    
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(30, y+182, 260, 100)];
    textView.layer.masksToBounds=YES;
    //commentView.layer.cornerRadius=20.0;
    textView.layer.borderWidth=1.0;
    textView.layer.borderColor=[[UIColor colorWithHexString:@"0e9fde"] CGColor];
    textView.backgroundColor=[UIColor  colorWithHexString:@"f0f4f7"];
    textView.text=@"评论一下吧~";
    textView.textColor=[UIColor colorWithHexString:@"999999"];
    textView.delegate=self;
    textView.tag=100;
    [_mask addSubview:textView];
    
    UIButton *publishButton=[[UIButton alloc]initWithFrame:CGRectMake(50, y+290, 100, 30)];
    publishButton.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
    [publishButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [publishButton setTitle:@"发表" forState:UIControlStateNormal];
    [publishButton addTarget:self action:@selector(clickPublishButton:) forControlEvents:UIControlEventTouchUpInside];
    [_mask addSubview:publishButton];
    
    UIButton *cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(170, y+290, 100, 30)];
    cancelButton.backgroundColor=[UIColor colorWithHexString:@"ff0000"];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [_mask addSubview:cancelButton];
    
    
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:@"commentViewAppear"context:nil];//动画开始
    [UIView setAnimationDuration:0.40];
    [UIView setAnimationDelegate:self];
    [_mask setFrame:frame];
    [UIView commitAnimations];

    
    
    //[mask addSubview:maskComment];
}



-(void)clickCancelButton:(UIButton *)button
{
    CGRect frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:@"commentViewDisappear"context:nil];//动画开始
    [UIView setAnimationDuration:0.40];
    [UIView setAnimationDelegate:self];
    [_mask setFrame:frame];
    [UIView commitAnimations];

    //[_mask removeFromSuperview];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 48.0;
    CGRect frame = CGRectMake(0, -height, _mask.frame.size.width, _mask.frame.size.height);
    //frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [_mask setFrame:frame];
    [UIView commitAnimations];
}

-(IBAction)backgroundTap:(id)sender
{
    if (_mask) {
        /*NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];*/
        UIView *uiview=[_mask viewWithTag:100];
        
        [uiview resignFirstResponder];
    }
    
}

@end
