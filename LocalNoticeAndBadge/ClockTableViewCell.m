//
//  ClockTableViewCell.m
//  CBayelProjectManage
//
//  Created by gcf on 16/6/23.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import "ClockTableViewCell.h"

@implementation ClockTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kGap10, kGap15, kGap50, kLineHeight25)];
    self.titleLabel.text = @"重复";
    self.titleLabel.font = [UIFont systemFontOfSize:kFontSize15];
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), kGap15, kScreenWidth - 100, kLineHeight25)];
    self.detailLabel.text = @"不重复";
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textColor = [UIColor grayColor];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.detailLabel];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
