//
//  OneCategoryViewController.m
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "OneCategoryViewController.h"
#import "OneCategoryCollectionViewCell.h"
#import "GoodsInfo+CoreDataClass.h"
#import "AddGoodsViewController.h"

@interface OneCategoryViewController () {
	DataSource *dataSource;
	Delegate *delegate;
	NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@end

@implementation OneCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initCollectionView];
	[self readGoodsData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self readGoodsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - CurrentViewControllerDismissDelegate
- (void)currentViewControllerDismiss {
	[self readGoodsData];
}

#pragma mark - CoreData
- (void)readGoodsData {
	[CoreData readDataWithEntityName:@"GoodsInfo" predicate:[NSPredicate predicateWithFormat:@"categoryID=%d",self.currentCategoryID] success:^(NSArray *resultArr) {
		dataArray = [NSMutableArray arrayWithArray:resultArr];
		[dataArray addObject:@"Add"];
		[dataSource setDataArray:dataArray];
		[_collectionview reloadData];
	} failure:nil];
}
#pragma mark - InitCollectionView
- (void)initCollectionView {
	self.automaticallyAdjustsScrollViewInsets = NO;
//	self.navigationItem.title = @"分类";
	dataArray = [[NSMutableArray alloc] init];
	//	[dataArray addObject:@"Add"];
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.itemSize = CGSizeMake(ScreenWidth/3, ScreenWidth/3*1.5);
	layout.minimumLineSpacing = 0;
	layout.minimumInteritemSpacing = 0;
	_collectionview.collectionViewLayout = layout;
	[_collectionview registerNib:[UINib nibWithNibName:@"OneCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OneCategoryCell"];
	[_collectionview registerNib:[UINib nibWithNibName:@"AddCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AddCell"];
	dataSource = [[DataSource alloc] initWithDataArray:dataArray cellIDConfigureBlock:^NSString *(NSIndexPath *indexPath, id model) {
		if (indexPath.row == dataArray.count - 1) {
			return @"AddCell";
		}
		return @"OneCategoryCell";
	} cellConfigure:^(NSIndexPath *indexPath, id model, id cell) {
		if (indexPath.row == dataArray.count - 1) {
			AddCollectionViewCell *addCell = (AddCollectionViewCell *)cell;
			addCell.delegate = self;
		}
	}];
	_collectionview.dataSource = dataSource;
	delegate = [[Delegate alloc] initWithSelectedBlock:^(NSIndexPath *indexPath) {
		GoodsInfo *goods = dataArray[indexPath.row];
		AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
		vc.goods = goods;
		vc.ID = goods.id;
		[self presentViewController:vc animated:YES completion:nil];
		
	}];
	_collectionview.delegate = delegate;
//	[_collectionview reloadData];
}

#pragma mark - AddCollectionViewCellClickDelegate
- (void)clickAddCollectionViewCell:(AddCollectionViewCell *)cell sender:(UIButton *)sender {
	AddGoodsViewController *addVC = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
	addVC.isAdd = YES;
	addVC.delegate = self;
	[self presentViewController:addVC animated:YES completion:nil];
}

@end
