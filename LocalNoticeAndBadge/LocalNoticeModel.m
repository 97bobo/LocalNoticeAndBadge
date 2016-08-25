//
//  LocalNoticeModel.m
//  LocalNoticeAndBadge
//
//  Created by gcf on 16/8/19.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import "LocalNoticeModel.h"

@implementation LocalNoticeModel

//重写无法正确赋值的key-value对，保证KVC对model对象赋值不出错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"对象无法正确赋值的键值对：%@",key);
    //    if ([key isEqualToString:@"id"]) {
    //        _num_id = value;
    //    }
}

//自定义初始化方法实现：方便快速构建对象
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//打印方法，辅助校验model对象的属性查看是否成功
-(NSString *)description{
    return [NSString stringWithFormat:@"noticeId:%@,noticeTime:%@,noticeWeek:%@,当前是否开启：%@",_noticeId,_noticeTime,_noticeWeek,_isOpen];
}

/**
 *  数据库字段与对象属性相互对应
 *
 *  @return 映射表
 */
-(NSDictionary *)columnPropertyMapping{
    //key为数据库字段名，value为model属性
    return @{@"Id":@"noticeId",
             @"nTime":@"noticeTime",
             @"nWeek":@"noticeWeek",
             @"nIsOpen":@"isOpen"};
}

@end
