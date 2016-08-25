//
//  LocalNoticeModel.h
//  LocalNoticeAndBadge
//
//  Created by gcf on 16/8/19.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColumnPropertyMappingDelegate.h"
@interface LocalNoticeModel : NSObject<ColumnPropertyMappingDelegate>

@property (strong , nonatomic) NSString *noticeId;
@property (strong , nonatomic) NSString *noticeTime;
@property (strong , nonatomic) NSString *noticeWeek;
@property (strong , nonatomic) NSString *isOpen;

-(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
