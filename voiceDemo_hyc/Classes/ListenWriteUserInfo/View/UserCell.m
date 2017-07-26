//
//  UserCell.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "UserCell.h"

@interface UserCell()

@property (nonatomic,strong) UIImageView * headImageView;

@property (nonatomic,strong) UIImageView * chatImageView;



@property (nonatomic,strong) UIView *_contentView;

@end

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self doSetUp];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    UserCell * cell =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [cell doSetUp];
    return cell;
}

- (void) doSetUp
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headImageView = [[UIImageView alloc]init];
    self.chatImageView = [[UIImageView alloc]init];
    
    self.headImageView.image = [UIImage imageNamed:@"user"];
    self.chatImageView.image = [UIImage imageNamed:@"chat_bg_right"];
    
    self.chatLabel = [[UILabel alloc]init];
    self.chatLabel.backgroundColor = [UIColor clearColor];
    self.chatLabel.contentMode = UIViewContentModeScaleToFill;
    self.chatLabel.textAlignment = NSTextAlignmentLeft;
    self.chatLabel.font = [UIFont customFontWithSize:12];
    self.chatLabel.preferredMaxLayoutWidth = kSCREEN_WIDTH - 30;
    
    
    [self addSubview:self.headImageView];
    [self addSubview:self.chatImageView];
    [self addSubview:self.chatLabel];
    
    [self setLayout];
    
}
- (void) setLayout
{
    
    
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.offset(50);
    }];
    
    
    
    
    [self.chatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.headImageView.mas_left).offset(-10);
        make.width.offset(0).priority(252);
        make.height.offset(0).priority(252);
    }];
    
    [self.chatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatLabel).offset(0);
        make.right.equalTo(self.chatLabel).offset(15);
        make.bottom.equalTo(self.chatLabel).offset(0);
        make.left.equalTo(self.chatLabel).offset(-5);
        
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
