//
//  MusicPlayerVC.m
//  MusicFM
//
//  Created by Macx on 2017/9/6.
//  Copyright © 2017年 LenSkey. All rights reserved.
//

#import "MusicPlayerVC.h"

#import "BaseModel.h"

#import "LocalFileLoader.h"

#import "MCPlayer.h"

#import "MainViewController.h"


#import "NSObject+CGD_ADD.h"

#import "UIImageView+WebCache.h"

 #import "FileQuickLookDeleVc.h"

#import "PlayerManager.h"


@interface MusicPlayerVC ()
{
 CGFloat _angle;
 NSArray *_mstArray;
 
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;

@property (weak, nonatomic) IBOutlet UISlider *playerProgress;

@property (nonatomic, strong) MCPlayer		*player;

@property (weak, nonatomic) IBOutlet UILabel *hasProgresslable;
@property (weak, nonatomic) IBOutlet UILabel *noProgresslable;
@property (weak, nonatomic) IBOutlet UILabel *misicNameLable;
@property (weak, nonatomic) IBOutlet UIButton *pasueButton;
@property (weak, nonatomic) IBOutlet UIView *lookView;

@end

@implementation MusicPlayerVC


-(void)viewDidAppear:(BOOL)animated
{
 [super viewDidAppear:animated];
 
}

-(void)viewWillAppear:(BOOL)animated
{
 [super viewWillAppear:animated];
 
//  __weak MusicPlayerVC *weakSelf = self;
 
 self.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
 [UIView animateWithDuration:0.3 animations:^{
   self.view.transform = CGAffineTransformMakeScale(1, 1);
 } completion:^(BOOL finished) {
  if (finished) {
//	[self.player playMediaWithUrl:_musicUrl tempPath:nil desPath:nil delegate:weakSelf];
  }
 }];
 
 
 _mstArray = @[@"1.doc"];
 _angle = 0.0f;
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
 
 UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
CGRect rect =  [UIScreen mainScreen].bounds;
 
 effectView.frame = CGRectMake(0, 0,CGRectGetWidth(rect), CGRectGetHeight(rect));
 effectView.alpha = 0.9f;
 [self.bgImageView addSubview:effectView];
 
 [_bgImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];

	_playerImageView.layer.cornerRadius =CGRectGetWidth(rect)/4.0f;
 _misicNameLable.text = _musicName;
 [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
 
   FileQuickLookDeleVc *quickLookDeleVc = [[FileQuickLookDeleVc alloc]init];
	[self addChildViewController:quickLookDeleVc];
 
  //注册通知
  //PlayTimeSecondNotification 秒数
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PlayEndNotification:) name:@"PlayEndNotification" object:nil];
 
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PlayTimeSecondNotification:) name:@"PlayTimeSecondNotification" object:nil];
  //PlayFailNotification
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PlayFailNotification:) name:@"PlayFailNotification" object:nil];
 
}

-(void)PlayEndNotification:(NSNotification *)noti
{
 _currentPlayNum++;
 _currentPlayNum = _currentPlayNum%self.dataSource.count;
 BaseModel *model = self.dataSource[_currentPlayNum];
 
 [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_large]];
 _misicNameLable.text = model.track_title;
 [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_small]];
 [_player stopMedia];
 [PlayerManager playerUrl:model.play_url_64];
 
// [self.player playMediaWithUrl:model.play_url_64 tempPath:nil desPath:nil delegate:self];
 
// self.playerProgress.value = 0;
 _angle = 0;

}

-(void)PlayFailNotification:(NSNotification *)noti
{
 
}

-(void)PlayTimeSecondNotification:(NSNotification *)noti
{
    NSDictionary *dic =   noti.object;
 
 NSString *currentString = dic[@"currentString"];
 NSString *residueStr = dic[@"residueStr"];
  //CGFloat seconds = [dic[@"seconds"] floatValue];
 _hasProgresslable.text = currentString;
 _noProgresslable.text = residueStr;
 
 CGFloat musicDuration =  [self.player getDuration];
 
 CGFloat currentDuration =  [self.player getCurrentTime];
 self.playerProgress.value = currentDuration/musicDuration;
	_angle+=2;
 self.playerImageView.transform =CGAffineTransformMakeRotation(_angle*M_PI/(180));
 if (_angle==360)
  {
  _angle = 0;
  }
 
}

//- (void)playerPlayTimeSecond:(CGFloat)seconds currentStr:(NSString *)currentString withResidueStr:(NSString *)residueStr
//{
// _hasProgresslable.text = currentString;
// _noProgresslable.text = residueStr;
// 
//  CGFloat musicDuration =  [self.player getDuration];
// 
// CGFloat currentDuration =  [self.player getCurrentTime];
//   self.playerProgress.value = currentDuration/musicDuration;
//	_angle+=2;
//   self.playerImageView.transform =CGAffineTransformMakeRotation(_angle*M_PI/(180));
// if (_angle==360)
// {
//  _angle = 0;
// }
// if (currentDuration>(musicDuration-0.4))
//  {
//  _currentPlayNum++;
//  _currentPlayNum = _currentPlayNum%self.dataSource.count;
//  BaseModel *model = self.dataSource[_currentPlayNum];
//  
//  [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_large]];
//  _misicNameLable.text = model.track_title;
//  [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_small]];
//  [_player stopMedia];
//  [self.player playMediaWithUrl:model.play_url_64 tempPath:nil desPath:nil delegate:self];
//  _angle = 0;
// }
//
//
//}
//- (void)playerLoadingValue:(double)cache duration:(CGFloat)duration
//{
//   NSLog(@"%f  %f",cache,duration);
// 
//}

 //值改变
- (IBAction)valueChange:(id)sender
{
   CGFloat musicDuration =  [self.player getDuration];

 [self.player seekToTime:musicDuration*self.playerProgress.value];

 _pasueButton.selected = NO;
 
}
- (IBAction)nextAction:(id)sender {
  _currentPlayNum--;
 
 if (_currentPlayNum<0)
 {
   _currentPlayNum = self.dataSource.count-1;
 }
  _currentPlayNum = _currentPlayNum%self.dataSource.count;
  BaseModel *model = self.dataSource[_currentPlayNum];
 
  [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_large]];
  _misicNameLable.text = model.track_title;
  [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_small]];
 [PlayerManager playerUrl:model.play_url_64];

 _angle = 0;

}
- (IBAction)last:(id)sender {
 
 _currentPlayNum++;
 _currentPlayNum = _currentPlayNum%self.dataSource.count;
 BaseModel *model = self.dataSource[_currentPlayNum];
 
 [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_large]];
 _misicNameLable.text = model.track_title;
 [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_small]];
  //
 [PlayerManager playerUrl:model.play_url_64];
 
 
 _angle = 0;

}
- (IBAction)lookBook:(id)sender {
 
 self.lookView.hidden = !_lookView.hidden;
 
 
}
- (IBAction)pasuePlayAction:(id)sender {
 
 
 UIButton *button = sender;
 button.selected = !button.selected;
 if (button.selected) {
   [self.player pauseMedia];
 }else{
   [self.player playMedia];
 }
}


//播放器
- (MCPlayer *)player
{
 _player  = [PlayerManager share].player;
 
 return [PlayerManager share].player;
}

- (IBAction)backAction:(id)sender {
 
 [self dismissViewControllerAnimated:YES completion:nil];
 
}

- (IBAction)listAction:(id)sender {
 
 
 __weak MusicPlayerVC *weakSelf = self;

 MainViewController *mainVc = [[MainViewController alloc]init];
 [mainVc setCompletion:^(id obj){
	//model
	//dataSource
	//path
  NSDictionary *dic = (NSDictionary *)obj;
  NSIndexPath *indexPath = dic[@"path"];
  NSArray *aDataSource  = dic[@"dataSource"];
  BaseModel *model   = dic[@"model"];
  
  _currentPlayNum = indexPath.row;
  weakSelf.dataSource = aDataSource;
  _currentPlayNum = _currentPlayNum%self.dataSource.count;
  
  [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_large]];
  _misicNameLable.text = model.track_title;
  [weakSelf.playerImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_url_small]];
  [_player stopMedia];
  [weakSelf.player playMediaWithUrl:model.play_url_64 tempPath:nil desPath:nil delegate:weakSelf];
  weakSelf.player.playerState = MCPlayerStatePlaying;
  
  _angle = 0;
 }];
 mainVc.modalPresentationStyle = UIModalPresentationCustom;
 mainVc.isPresent = YES;
 [self presentViewController:mainVc animated:YES completion:nil];
 
}

-(void)dealloc
{
 _player = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - ****************tableview Delegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 static NSString *identifier = @"Cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
 
 if (!cell)
  {
  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }

  cell.textLabel.text = _mstArray[indexPath.row];
 
 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
 
 return cell;
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
 FileQuickLookDeleVc *quickLookDeleVc = (FileQuickLookDeleVc *)self.childViewControllers[0];
 NSString *name = [_mstArray[indexPath.row] componentsSeparatedByString:@"."][0];
 NSString *type = [_mstArray[indexPath.row] componentsSeparatedByString:@"."][1];
 NSString *path =  [[NSBundle mainBundle]pathForResource:name ofType:type];

 if (path)
 {
  quickLookDeleVc.fileURL = [NSURL fileURLWithPath:path];
  
  QLPreviewController *preview = [[QLPreviewController alloc] initWithNibName:nil bundle:nil];
  preview.dataSource = quickLookDeleVc;
  preview.delegate = quickLookDeleVc;
  [preview setCurrentPreviewItemIndex:0];
  preview.modalPresentationStyle = UIModalPresentationCustom;
  
  [self presentViewController:preview animated:YES completion:nil];

 }
 
  // [self.navigationController pushViewController:preview animated:YES];

 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 return _mstArray.count;
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






@end
