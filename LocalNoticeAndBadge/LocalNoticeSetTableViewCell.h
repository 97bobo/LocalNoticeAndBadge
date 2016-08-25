//
//  LocalNoticeSetTableViewCell.h
//  LocalNoticeAndBadge
//
//  Created by gcf on 16/8/19.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalNoticeSetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *noticeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeWeekLabel;
@property (weak, nonatomic) IBOutlet UISwitch *noticeSwitch;


@end
