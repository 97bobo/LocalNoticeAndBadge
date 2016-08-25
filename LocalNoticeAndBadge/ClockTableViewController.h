//
//  ClockTableViewController.h
//  CBayelProjectManage
//
//  Created by gcf on 16/6/23.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockTableViewController : UITableViewController
/**
 *  通知页面单例
 */
+(instancetype)shareClockTableViewController;

// 设置本地通知
+ (void)registerLocalNotification:(NSString *)timeStr;
// 取消本地通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key;

/**
 *  闹铃时间
 */
@property(strong,nonatomic)NSString *timeStr;
/**
 *  重复时间
 */
@property(strong,nonatomic)NSString *weeksStr;
@end
