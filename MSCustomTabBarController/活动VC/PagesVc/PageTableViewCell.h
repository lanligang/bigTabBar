//
//  PageTableViewCell.h
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/17.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^BtnSeleted)(id sender,NSIndexPath *indexPath);


@interface PageTableViewCell : UITableViewCell


@property (nonatomic, copy) BtnSeleted  seletedAction;

@property (nonatomic, strong) NSIndexPath		*currentIndexPath;


 //选择按钮
@property (weak, nonatomic) IBOutlet UIButton *seleteButton;


@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@property (weak, nonatomic) IBOutlet UILabel *shotMsgLable;

@property (weak, nonatomic) IBOutlet UILabel *msgLable;

@property (weak, nonatomic) IBOutlet UIImageView *cellImgView;



@end
