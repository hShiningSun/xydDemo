//
//  AiCell.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "AiCell.h"

@interface AiCell()

@property (nonatomic,strong) UIView *_contentView;

@end

@implementation AiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    AiCell * cell =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [cell doSetUp];
    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [self doSetUp];
}

- (void) doSetUp
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headImageView = [[UIImageView alloc]init];
    self.chatImageView = [[UIImageView alloc]init];
    
    self.headImageView.image = [UIImage imageNamed:@"xyd"];
    self.chatImageView.image = [UIImage imageNamed:@"chat_bg_left"];
    
    self.chatLabel = [[UILabel alloc]init];
    self.chatLabel.backgroundColor = [UIColor clearColor];
    self.chatLabel.contentMode = UIViewContentModeScaleToFill;
    self.chatLabel.textAlignment = NSTextAlignmentLeft;
    self.chatLabel.font = [UIFont customFontWithSize:12];
    self.chatLabel.preferredMaxLayoutWidth = kSCREEN_WIDTH - 30;
    self.chatLabel.text = @"12314214";
    
    [self addSubview:self.headImageView];
    [self addSubview:self.chatImageView];
    [self addSubview:self.chatLabel];
    
    [self setLayout];
    
    
    self.chatImageView.alpha = 0;
    self.chatLabel.alpha = 0;
    self.headImageView.alpha = 0;

}
- (void) setLayout
{
    
    
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.offset(50);
    }];
    
    

    
    [self.chatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.width.offset(0).priority(252);
        make.height.offset(0).priority(252);
    }];
    
    [self.chatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatLabel).offset(0);
        make.left.equalTo(self.chatLabel).offset(-15);
        make.bottom.equalTo(self.chatLabel).offset(0);
        make.right.equalTo(self.chatLabel).offset(5);
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end







