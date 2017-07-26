//
//  AiFinishCell.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/25.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "AiFinishCell.h"
#import "hButton.h"

@interface AiFinishCell()

@property (nonatomic,strong) hButton *finishBtn;

@end

@implementation AiFinishCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self doSetUp];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self doSetUp];
}

- (void) doSetUp
{
    _finishBtn = [[hButton alloc]init];
    _finishBtn.isRound = YES;
    _finishBtn.layer.borderWidth = 1;
    _finishBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _finishBtn.titleNormal = @"查看录入资料";
    [_finishBtn setBackgroundColor:[UIColor orangeColor]];
    [_finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//40 170  240
    _finishBtn.enableHighlightedAnimation = YES;
    
    [self addSubview:_finishBtn];
    
    [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.offset(220);
        make.height.offset(35);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
