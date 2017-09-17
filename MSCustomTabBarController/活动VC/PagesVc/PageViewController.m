//
//  PageViewController.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/16.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import "PageViewController.h"

#import "PageTableViewCell.h"

#import "BaseModel.h"

#import "LocalFileLoader.h"
#import "UIImageView+WebCache.h"

#import "NSString+YYAdd.h"
#import "NSObject+CGD_ADD.h"


@interface PageViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mineTableView;
@property (nonatomic, strong) NSMutableArray		*dataSource;


@end

@implementation PageViewController


-(NSMutableArray *)dataSource
{
 if (_dataSource==nil)
  {
		_dataSource = [[NSMutableArray alloc]init];
  }
	return _dataSource;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
 NSDictionary *dic =  [LocalFileLoader loadJsonFileWithName:@"huanjiu"];
 NSDictionary *dic2 =  [LocalFileLoader loadJsonFileWithName:@"xs"];
 __weak __typeof(self) weakSelf = self;

 [self aSyns:^{
  
  BaseModel *model = [[BaseModel alloc]init];
  BaseModel *model2 = [[BaseModel alloc]init];
  
  [model yy_modelSetWithDictionary:dic];
  [model2 yy_modelSetWithDictionary:dic2];
  [weakSelf.dataSource addObjectsFromArray:model.tracks];
  [weakSelf.dataSource addObjectsFromArray:model2.tracks];
  
  [weakSelf mainSys:^{
	
	[weakSelf.mineTableView reloadData];
	
  }];
 }];

 
 [_mineTableView registerNib:[UINib nibWithNibName:@"PageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}


#pragma mark - ****************tableview Delegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 static NSString *identifier = @"cell";
 PageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
 
 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 cell.currentIndexPath = indexPath;
  BaseModel *model =  self.dataSource[indexPath.row];
 cell.seleteButton.selected = [self.dataSource[indexPath.row] isSeleted];
 
 cell.nameLable.text =model.track_title;
 [cell.cellImgView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_small]];
 cell.msgLable.text = model.track_intro;
 cell.clipsToBounds  = YES;
  __weak __typeof(self) weakSelf = self;
 
 
 [cell setSeletedAction:^(UIButton *sender,NSIndexPath *actionIndexPath){
  
  [weakSelf.dataSource[actionIndexPath.row] setIsSeleted:sender.selected];
  [weakSelf.mineTableView reloadData];
  
 }];
 
 
 
 
 return cell;
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
 
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 
   BaseModel *model =  self.dataSource[indexPath.row];

  return model.cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
 
 return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
 
 return nil;
 
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
