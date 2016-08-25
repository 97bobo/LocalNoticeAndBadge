//
//  LocalNoticeSetTableViewController.m
//  LocalNoticeAndBadge
//
//  Created by gcf on 16/8/19.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import "LocalNoticeSetTableViewController.h"

@interface LocalNoticeSetTableViewController ()
@property (strong , nonatomic) NSMutableArray *dataArr;
@end
static NSString * const localNoticeSetCell = @"localNoticeSetCell";
@implementation LocalNoticeSetTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editCellAction:)];
        self.navigationItem.leftBarButtonItem = leftBtn;
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addCellAction)];
        self.navigationItem.rightBarButtonItem = rightBtn;
        
    }
    return self;
}

- (void)editCellAction:(UIBarButtonItem *)barBtn{
    //刷新列表
    [self.tableView reloadData];
    //如果当前正在编辑
    if (self.tableView.editing) {
        barBtn.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
    }
    else
    {
        barBtn.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }
}

- (void)addCellAction{
    [self.navigationController pushViewController:[ClockTableViewController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    self.navigationItem.title = @"闹钟";
    self.tableView.backgroundColor = [UIColor whiteColor];
    //取消系统自定义下划线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //取消空白部分线条
    //self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"LocalNoticeSetTableViewCell" bundle:nil] forCellReuseIdentifier:localNoticeSetCell];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/**
 *  获取数据
 */
-(void)requestData{
    self.dataArr = [[NSMutableArray alloc]init];
    LocalNoticeModelDBTool *noticeModelDBTool = [LocalNoticeModelDBTool shareInstance];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[noticeModelDBTool selectAllModel]];
    for (NSDictionary *dict in arr) {
        LocalNoticeModel *model = [[LocalNoticeModel alloc]init];
        model.noticeId = [dict valueForKey:@"noticeId"];
        model.noticeTime = [dict valueForKey:@"noticeTime"];
        model.noticeWeek = [dict valueForKey:@"noticeWeek"];
        model.isOpen = [dict valueForKey:@"isOpen"];
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocalNoticeSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:localNoticeSetCell forIndexPath:indexPath];
    
    LocalNoticeModel *noticeModel = self.dataArr[indexPath.row];
    
    //将时间串转换为HH:mm格式时间
    cell.noticeTimeLabel.text = [self getTimeStrWithNoticeTime:noticeModel.noticeTime];
    
    //将日期数组转化为日期字符串
    NSArray *weeksArr = [noticeModel.noticeWeek objectFromJSONString];
    NSUInteger totalCount = weeksArr.count;
    switch (totalCount) {
        case 0:
        {
            cell.noticeWeekLabel.text = @"永不";
            break;
        }
        case 2:
        {
            int weeksDayCount = 0;
            NSMutableString *weeksStr = [[NSMutableString alloc]initWithString:@""];
            for (NSString *str in weeksArr) {
                if ([str isEqualToString:@"周六"] || [str isEqualToString:@"周日"]) {
                    weeksDayCount ++;
                }
                [weeksStr appendFormat:@" %@",str];
            }
            if (weeksDayCount == 2) {
                cell.noticeWeekLabel.text = @"周末";
            }
            else
            {
                cell.noticeWeekLabel.text = weeksStr;
            }
            break;
        }
        case 5:
        {
            int weeksDayCount = 0;
            NSMutableString *weeksStr = [[NSMutableString alloc]initWithString:@""];
            for (NSString *str in weeksArr) {
                if (![str isEqualToString:@"周六"] && ![str isEqualToString:@"周日"]) {
                    weeksDayCount ++;
                }
                [weeksStr appendFormat:@" %@",str];
            }
            if (weeksDayCount == 5) {
                cell.noticeWeekLabel.text = @"工作日";
            }
            else
            {
                cell.noticeWeekLabel.text = weeksStr;
            }
            break;
        }
        case 7:
        {
            cell.noticeWeekLabel.text = @"每天";
            break;
        }
        default:
        {
            NSMutableString *weeksStr = [[NSMutableString alloc]initWithString:@""];
            for (NSString *str in weeksArr) {
                [weeksStr appendFormat:@" %@",str];
            }
            cell.noticeWeekLabel.text = weeksStr;
            break;
        }
    }
    
    cell.noticeSwitch.on = [noticeModel.isOpen isEqualToString:@"1"]?YES:NO;
    cell.noticeSwitch.tag = [noticeModel.noticeId intValue] + 1000;
    //如果当前正在编辑
    if (self.tableView.editing) {
        cell.noticeSwitch.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.noticeSwitch.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell.noticeSwitch addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

-(void)changeState:(UISwitch *)noticeSwitch{
    
    NSString *isOpen = noticeSwitch.on?@"1":@"0";
    LocalNoticeModelDBTool *noticeDBTool = [LocalNoticeModelDBTool shareInstance];
    NSString *nId = [NSString stringWithFormat:@"%ld",(noticeSwitch.tag - 1000)];
    [noticeDBTool updateModelWithkey:@"nIsOpen" value:isOpen nId:nId];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果当前正在编辑
    if (self.tableView.editing) {
        self.navigationItem.leftBarButtonItem.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
        ClockTableViewController *clockVC = [ClockTableViewController new];
        LocalNoticeModel *noticeModel = self.dataArr[indexPath.row];
        clockVC.timeStr = [self getTimeStrWithNoticeTime:noticeModel.noticeTime];
        clockVC.weeksStr = noticeModel.noticeWeek;
        [self.navigationController pushViewController:clockVC animated:YES];
    }
    else
    {
        
    }
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        LocalNoticeModel *noticeModel = self.dataArr[indexPath.row];
        LocalNoticeModelDBTool *noticeDBTool = [LocalNoticeModelDBTool shareInstance];
        [noticeDBTool deleteModelWithkey:@"Id" value:noticeModel.noticeId];
        [self.dataArr removeObject:noticeModel];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//将时间字符串转换为HH：mm
-(NSString *)getTimeStrWithNoticeTime:(NSString *)noticeTime{
    NSInteger num = [noticeTime integerValue];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // 这里是用大写的 H
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:num];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //从详情页返回时刷新页面
    [self requestData];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
