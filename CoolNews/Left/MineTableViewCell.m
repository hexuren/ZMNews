//
//  MineTableViewCell.m
//  ElectricityPatrolSystem
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 KevinWu. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageCountLabel;
@property (strong, nonatomic) UILabel *syncCountLabel;


@end

@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //布局
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.messageCountLabel];
        [self.contentView addSubview:self.syncCountLabel];

    }
    return self;
}

#pragma mark - setter
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 15, 20, 17)];
    }
    return _iconImageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.frame.size.width +self.iconImageView.frame.origin.x + 17, 15, 100, 17)];
    }
    return _titleLabel;
}

- (UILabel *)messageCountLabel{
    if (_messageCountLabel == nil) {
        _messageCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(MINE_VC_WIDTH - 17-44, 3, 44, 44)];
        [_messageCountLabel setTextColor:gTextColorSpecial];
    }
    return _messageCountLabel;
}

- (UILabel *)syncCountLabel{
    if (_syncCountLabel == nil) {
        _syncCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(MINE_VC_WIDTH - 17-44, 3, 44, 44)];
        [_syncCountLabel setTextColor:gTextColorSpecial];
    }
    return _syncCountLabel;
}
#pragma mark - utilities
- (void)setvalueForcellWithDictionary:(NSDictionary *)dict{
    
    [self.iconImageView setImage:[UIImage imageNamed:dict[@"imageName"]]];
    [self.titleLabel setText:dict[@"title"]];
    
}

- (void)setSelectedValueForcellWithDictionary:(NSDictionary *)dict{
    [self.iconImageView setImage:[UIImage imageNamed:dict[@"imageName_on"]]];
}

- (void)setUnreadMessageCountValue:(NSInteger)count{
    [self.messageCountLabel setHidden:NO];
    [self.messageCountLabel setText:[NSString stringWithFormat:@"%ld",(long)count]];
}

- (void)setNoUnreadMessageCount{
    [self.messageCountLabel setHidden:YES];
}

- (void)setsyncDataCountValue:(NSInteger)count{
    [self.syncCountLabel setHidden:NO];
    [self.syncCountLabel setText:[NSString stringWithFormat:@"%ld",(long)count]];
}

- (void)setNosyncData{
    [self.syncCountLabel setHidden:YES];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.titleLabel setTextColor:gMainColor];
    }
    else{
        [self.titleLabel setTextColor:gTextColorMain];
    }

    // Configure the view for the selected state
}

@end
