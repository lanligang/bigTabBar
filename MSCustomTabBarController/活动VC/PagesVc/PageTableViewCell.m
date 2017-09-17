//
//  PageTableViewCell.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/17.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import "PageTableViewCell.h"

@implementation PageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark 点击方法


- (IBAction)seleteAction:(UIButton *)sender {
 
 sender.selected = !sender.selected;
 if (_seletedAction) {
  _seletedAction(sender,_currentIndexPath);
 }
 
 
}








@end
