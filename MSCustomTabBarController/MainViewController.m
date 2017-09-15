//
//  MainViewController.m
//  MusicFM
//
//  Created by Macx on 2017/9/2.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import "MainViewController.h"
#import "LocalFileLoader.h"

#import "MCPlayer.h"
#import "NSObject+CGD_ADD.h"
#import "MusicPlayerVC.h"
#import "MusicTableViewCell.h"

#import "BaseModel.h"
#import "UIImageView+WebCache.h"
#import "PlayerManager.h"

#import "BezierPathView.h"



@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray		*dataSource;
@property (strong, nonatomic)  UIView *topView;


@property (strong, nonatomic)  UITableView *listTableView;

@property (nonatomic, strong) UIScrollView		*bottomScrollView;

@property (nonatomic, strong) UIImageView		*topImageView;
@property (weak, nonatomic) IBOutlet UILabel *navTitleLable;


@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated
{
 [super viewWillAppear:animated];
 self.navigationController.navigationBar.subviews[0].alpha = 0;
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 __weak MainViewController *weakSelf = self;
 [self.view addSubview:self.bottomScrollView];
 [_bottomScrollView addSubview:self.topImageView];
 
 
 [self.view addSubview:self.listTableView];
 CGRect rect =   [UIScreen mainScreen].bounds;

 if (_isPresent)
  {
  self.topView.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
   _listTableView.frame = CGRectMake(0, 60.0f, CGRectGetWidth(rect), CGRectGetHeight(rect)-60.0f);
  [self.view bringSubviewToFront:_topView];
  UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  closeBtn.frame = CGRectMake(CGRectGetWidth(_topView.frame)-35, 25, 20, 20);
  [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
  [closeBtn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
  [_topView addSubview:closeBtn];
  
 }else{
  _listTableView.frame = self.view.bounds;
  
  UIView *headerView = [UIView new];
  headerView.frame = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetWidth(rect));
  _listTableView.tableHeaderView = headerView;
  
  _listTableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
 CGRect frameRect =  CGRectMake(0, CGRectGetWidth(rect)-80.0f, CGRectGetWidth(rect), 80.0f);
  BezierPathView *pathView = [[BezierPathView alloc]initWithFrame:frameRect];
  [headerView addSubview:pathView];
  
 }
 
 [self.listTableView registerNib:[UINib nibWithNibName:@"MusicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicTableViewCell"];
 
 [self aSyns:^{
  NSDictionary *dic =  [LocalFileLoader loadJsonFileWithName:@"huanjiu"];
  NSDictionary *xsdic =  [LocalFileLoader loadJsonFileWithName:@"xs"];
  NSMutableArray *hjArr = [NSMutableArray new];
  NSMutableArray *xsArr = [NSMutableArray new];
  [weakSelf mainSys:^{
	NSArray *trancks  = dic[@"tracks"];
	 NSArray *xstrancks  = xsdic[@"tracks"];
	for (NSDictionary *dict in trancks)
	 {
	 BaseModel *model = [[BaseModel alloc]init];
	 [model yy_modelSetWithDictionary:dict];
	 [hjArr addObject:model];

	 }
	for (NSDictionary *dict in xstrancks)
	 {
	 BaseModel *model = [[BaseModel alloc]init];
	 [model yy_modelSetWithDictionary:dict];
	 [xsArr addObject:model];
	 
	 }
    BaseModel *model = 	hjArr[0];
	[weakSelf.topImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_large]];
	
	[weakSelf.dataSource addObject:hjArr];
	[weakSelf.dataSource addObject:xsArr];
	  [self.listTableView reloadData];
  }];
 }];
 
 

 
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
 CGFloat firstHeight =  CGRectGetWidth(self.view.bounds);
 
 if (scrollView.contentOffset.y<0)
 {
 _topImageView.bounds =CGRectMake(0, 0, self.view.bounds.size.width-scrollView.contentOffset.y, firstHeight-scrollView.contentOffset.y);
 _topImageView.center  = CGPointMake(self.view.bounds.size.width/2.0f, firstHeight/2.0f+scrollView.contentOffset.y/2.0f);
 
 self.navigationController.navigationBar.subviews[0].alpha = 0.0f;
 _navTitleLable.alpha = 0.0f;
 _navTitleLable.textColor = [UIColor whiteColor];
 }else{
  if (scrollView.contentOffset.y>=(firstHeight-64))
	{
	_navTitleLable.alpha = 1.0f;
	self.navigationController.navigationBar.subviews[0].alpha =1.0f;
	 _navTitleLable.textColor = [UIColor blackColor];
  }else{
	self.navigationController.navigationBar.subviews[0].alpha = (scrollView.contentOffset.y)/(firstHeight-64);
	_navTitleLable.alpha = (scrollView.contentOffset.y)/(firstHeight-64);

  }
 }
 _bottomScrollView.contentOffset = scrollView.contentOffset;
}



#pragma mark - ****************tableview Delegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 static NSString *identifier = @"MusicTableViewCell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
 
 MusicTableViewCell *musicCell = (MusicTableViewCell *)cell;
 
 BaseModel *model = self.dataSource[indexPath.section][indexPath.row];
 [musicCell.musicImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_small]];
 musicCell.musicName.text = model.track_title;
 
 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
 
 return cell;
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
 if (self.isPresent)
 {
    BaseModel *model = self.dataSource[indexPath.section][indexPath.row];
	 NSMutableArray *aDataSource =self.dataSource[indexPath.section];
  NSDictionary *dic = @{@"model":model,
							  @"dataSource":aDataSource,
							  @"path":indexPath
							  };
  self.completion(dic);
 
  [self dismissViewControllerAnimated:YES completion:nil];
 }else{
  MusicPlayerVC *musicPlayerVc = [[MusicPlayerVC alloc]init];
  musicPlayerVc.modalPresentationStyle =UIModalPresentationCustom;
  BaseModel *model = self.dataSource[indexPath.section][indexPath.row];
  [_topImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_large]];
  musicPlayerVc.imageUrl =model.cover_url_large;
  musicPlayerVc.musicUrl = model.play_url_64;
  musicPlayerVc.musicName = model.track_title;
  musicPlayerVc.dataSource = self.dataSource[indexPath.section];
  musicPlayerVc.currentPlayNum = indexPath.row;
  
  [PlayerManager playerUrl:model.play_url_64];
  
  [self presentViewController:musicPlayerVc animated:NO completion:nil];

 }
 
}
- (IBAction)dismissAction:(id)sender {
 [self dismissViewControllerAnimated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return 80.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 return [self.dataSource[section] count];
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

-(NSMutableArray *)dataSource
{
 if (_dataSource==nil)
  {
		_dataSource = [[NSMutableArray alloc]init];
  }
	return _dataSource;
}

-(UITableView *)listTableView
{
 if (_listTableView==nil)
  {
		_listTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
  _listTableView.delegate = self;
  _listTableView.dataSource = self;
  }
	return _listTableView;
}

-(UIView *)topView
{
 if (_topView==nil)
  {
		_topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60.0f)];
      _topView.hidden = YES;
  _topView.backgroundColor = [UIColor whiteColor];
  
  [self.view addSubview:_topView];
  }
	return _topView;
}

-(UIScrollView *)bottomScrollView
{
 if (_bottomScrollView==nil)
  {
		_bottomScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
  _bottomScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)+CGRectGetWidth(self.view.bounds));
  }
	return _bottomScrollView;
}
-(UIImageView *)topImageView
{
 if (_topImageView==nil)
  {
		_topImageView = [[UIImageView alloc]init];
  _topImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
  }
	return _topImageView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
