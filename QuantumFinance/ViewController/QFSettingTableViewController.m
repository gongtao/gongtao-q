//
//  QFSettingTableViewController.m
//  QuantumFinance
//
//  Created by 曼瑜 朱 on 14-4-5.
//  Copyright (c) 2014年 龚涛. All rights reserved.
//

#import "QFSettingTableViewController.h"

@interface QFSettingTableViewController ()


@end

static NSString *cellIdentifier = @"settingCell";

@implementation QFSettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[self.tableView setSeparatorColor:[UIColor colorWithHexString:@"0e9fde"]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    //if (!cell) {
        //UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.layer.borderWidth=1;
    cell.layer.borderColor=[UIColor colorWithHexString:@"0e9fde"].CGColor;
    cell.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 280, 30)];
    textField.center=CGPointMake(self.view.frame.size.width/2, 15);
    //textField.backgroundColor=[UIColor clearColor];

    textField.backgroundColor=[UIColor colorWithHexString:@"f0f4f7"];
    //[textField setBorderStyle:UITextBorderStyleLine];
    //textField.layer.borderWidth = 1.0;
    //textField.layer.borderColor = [UIColor colorWithHexString:@"0e9fde"].CGColor;
    textField.font=[UIFont systemFontOfSize:12];
    textField.textColor=[UIColor colorWithHexString:@"999999"];
    textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    textField.textAlignment=NSTextAlignmentRight;
    
    textField.delegate=self;
    
    [cell.contentView addSubview:textField];
    /*UIView *verticalLine1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 30)];
    UIView *verticalLine2=[[UIView alloc]initWithFrame:CGRectMake(300, 0, 1, 30)];
    UIView *horizontalLine1=[[UIView alloc]initWithFrame:CGRectMake(0, 30, 300, 1)];
    verticalLine1.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
    verticalLine2.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
    horizontalLine1.backgroundColor=[UIColor colorWithHexString:@"0e9fde"];
    [cell.contentView addSubview:verticalLine1];
    [cell.contentView addSubview:verticalLine2];
    [cell.contentView addSubview:horizontalLine1];*/
    if ([indexPath row]!=0) {
        //UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(1, 0, 298, 1)];
        //horizontalLine.backgroundColor=[UIColor colorWithHexString:@"ff0000"];
        //[cell.contentView addSubview:horizontalLine];
    }
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 12, 70, 15)];

    textLabel.textColor=[UIColor colorWithHexString:@"666666"];
    textLabel.font=[UIFont systemFontOfSize:12];
    //textLabel.textAlignment=UITextAlignmentCenter;
    switch ([indexPath row]) {
        case 0:
            textLabel.text=@"昵称";
            textField.text=@"Soda Lee";
            break;
        case 1:
            textLabel.text=@"手机";
            textField.keyboardType=UIKeyboardTypePhonePad;
            textField.text=@"13900000000";
            break;
        case 2:
            textLabel.text=@"密码";
            textField.secureTextEntry = YES;
            textField.text=@"passWord";
            break;
        case 3:
            textLabel.text=@"邮箱";
            textField.keyboardType=UIKeyboardTypeEmailAddress;
            textField.text=@"sodalee@126.com";
            break;
        case 4:
        {
            textLabel.text=@"社交账号";
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 53, 20)];
            UIImageView *imagView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            imagView1.image=[UIImage imageNamed:@"社交账号weibo.png"];
            [view addSubview:imagView1];
            UIImageView *imagView2=[[UIImageView alloc]initWithFrame:CGRectMake(30, 0, 20, 20)];
            imagView2.image=[UIImage imageNamed:@"社交账号QQ.png"];
            [view addSubview:imagView2];
            textField.rightView=view;
            textField.rightViewMode=UITextFieldViewModeAlways;
        }
            break;
        default:
            break;
    }
    textField.leftView=textLabel;
    //textField.leftView.center=CGPointMake(60, 15);
    textField.leftViewMode = UITextFieldViewModeAlways;

    //}
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(50, 12, 70, 15);
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
