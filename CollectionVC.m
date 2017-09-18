//
//  CollectionVC.m
//  MSCustomTabBarController
//
//  Created by Macx on 2017/9/18.
//  Copyright © 2017年 MrSong. All rights reserved.
//

#import "CollectionVC.h"
#import "PageCollectionViewCell.h"
#import "LocalFileLoader.h"
#import "BaseModel.h"

#import "UIImageView+WebCache.h"

@interface CollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>



@property (weak, nonatomic) IBOutlet UICollectionView *mineCollectionView;

@property (nonatomic, strong) NSMutableArray		*dataSource;



@end

@implementation CollectionVC

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

 self.automaticallyAdjustsScrollViewInsets = NO;
 NSDictionary *dic =  [LocalFileLoader loadJsonFileWithName:@"hh"];
 BaseModel *model = [[BaseModel alloc]init];
 [model yy_modelSetWithDictionary:dic];
 [self.dataSource addObjectsFromArray:model.hhs];
 
 [_mineCollectionView registerNib:[UINib nibWithNibName:@"PageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
 _mineCollectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
 
 
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 return self.dataSource.count;;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  PageCollectionViewCell *cell =   [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
 Hero *model = self.dataSource[indexPath.row];
 
 cell.hNameLable.text = model.name;
 
 cell.hDetailTexView.text = model.detail;
 
 [cell.pageImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
 return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
