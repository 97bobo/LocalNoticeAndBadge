//
//  LocalNoticeModelDBTool.m
//  LocalNoticeAndBadge
//
//  Created by gcf on 16/8/23.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import "LocalNoticeModelDBTool.h"
@interface LocalNoticeModelDBTool ()

@property (strong , nonatomic) DataBaseTool *dbTool;

@end
static id _instance;
@implementation LocalNoticeModelDBTool
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        NSString *dbName = @"fundingSys.db";
        NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [directory stringByAppendingPathComponent:dbName];
        DLog(@"%@",dbPath);
        _dbTool = [[DataBaseTool alloc] initWithPath:dbPath];
    }
    return self;
}

- (void)createTable
{
    NSString *sql = @"CREATE TABLE 'LocalNoticeModel' ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'nTime' TEXT, 'nWeek' TEXT, 'nIsOpen' TEXT);";
    if (![_dbTool tableExists:@"LocalNoticeModel"]) {
        [_dbTool executeUpdate:sql param:nil];
    }
    else
    {
        DLog(@"LocalNoticeModel表已经存在");
    }
    
    
}

- (void)insertModel:(LocalNoticeModel *)noticeModel
{
    NSString *sql = @"insert into LocalNoticeModel( nTime, nWeek, nIsOpen) values(?,?,?)";
    NSArray *param = @[noticeModel.noticeTime,noticeModel.noticeWeek,noticeModel.isOpen];
    if([_dbTool executeUpdate:sql param:param]){
        DLog(@"插入数据成功");
    }
    else
    {
        DLog(@"插入数据失败");
    }
}

-(void)deleteModelWithkey:(NSString *)key value:(NSString *)value{
    NSString *sql = [NSString stringWithFormat:@"delete from LocalNoticeModel where %@ = %@",key,value];
    if ([_dbTool executeUpdate:sql param:nil]) {
        DLog(@"删除成功");
    }
    else
    {
        DLog(@"删除失败");
    }
}

-(void)updateModelWithkey:(NSString *)key value:(NSString *)value nId:(NSString *)nId{
    NSString *sql = [NSString stringWithFormat:@"update LocalNoticeModel set %@ = %@ where Id = %@",key,value,nId];
    if ([_dbTool executeUpdate:sql param:nil]) {
        DLog(@"修改成功");
    }
    else
    {
        DLog(@"修改失败");
    }
}

- (NSArray *)selectAllModel
{
    return [_dbTool executeQuery:@"select * from LocalNoticeModel" withArgumentsInArray:nil modelClass:[LocalNoticeModel class]];
}

- (void)dropTable{
    if([_dbTool dropTable:@"LocalNoticeModel"])
    {
        DLog(@"删除成功");
    }
    else
    {
        DLog(@"删除失败");
    }
}

@end
