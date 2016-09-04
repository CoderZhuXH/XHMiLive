//
//  XHLiveCell.m
//  XHMiLive
//
//  Created by xiaohui on 16/9/4.
//  Copyright © 2016年 returnoc.com. All rights reserved.
//

#import "XHLiveCell.h"
#import "XHLiveModel.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>

@interface XHLiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *liveImgView;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;//直播状态

@end

@implementation XHLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.stateLab.layer.cornerRadius = 13;
    self.stateLab.layer.masksToBounds = YES;
    self.stateLab.layer.borderWidth = 1.0;
    self.stateLab.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    // Initialization code
}

-(void)setModel:(XHLiveModel *)model
{
    _model = model;
    
    NSLog(@"__name=%@",model.myname);
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:model.smallpic]];
    [self.liveImgView sd_setImageWithURL:[NSURL URLWithString:model.bigpic]];
    self.nameLab.text = model.myname;
    [self.locationBtn setTitle:model.gps forState:UIControlStateNormal];
    self.numLab.text = model.allnum;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
