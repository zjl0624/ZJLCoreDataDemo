//
//  CategoryViewController.m
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCollectionViewCell.h"
#import "CategoryEntity+CoreDataClass.h"
#import "AddCategoryViewController.h"

@interface CategoryViewController () {
	DataSource *dataSource;
	Delegate *delegate;
	NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self readCategoryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CoreData
- (void)readCategoryData {
	[CoreData readDataWithEntityName:@"CategoryEntity" predicate:nil success:^(NSArray *resultArr) {
		dataArray = [NSMutableArray arrayWithArray:resultArr];
		[dataArray addObject:@"Add"];
		[dataSource setDataArray:dataArray];
		[_collectionview reloadData];
	} failure:nil];
}

#pragma mark - InitCollectionView
- (void)initCollectionView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.navigationItem.title = @"分类";
	dataArray = [[NSMutableArray alloc] init];
//	[dataArray addObject:@"Add"];
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.itemSize = CGSizeMake(ScreenWidth/3, ScreenWidth/3*1.5);
	layout.minimumLineSpacing = 0;
	layout.minimumInteritemSpacing = 0;
	_collectionview.collectionViewLayout = layout;
	[_collectionview registerNib:[UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryCell"];
	[_collectionview registerNib:[UINib nibWithNibName:@"AddCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AddCell"];
	dataSource = [[DataSource alloc] initWithDataArray:dataArray cellIDConfigureBlock:^NSString *(NSIndexPath *indexPath, id model) {
		if (indexPath.row == dataArray.count - 1) {
			return @"AddCell";
		}
		return @"CategoryCell";
	} cellConfigure:^(NSIndexPath *indexPath, id model, id cell) {
		if (indexPath.row == dataArray.count - 1) {
			AddCollectionViewCell *addCell = (AddCollectionViewCell *)cell;
			addCell.delegate = self;
		}
	}];
	_collectionview.dataSource = dataSource;
	delegate = [[Delegate alloc] initWithSelectedBlock:^(NSIndexPath *indexPath) {
		
	}];
	[_collectionview reloadData];
}

#pragma mark - AddCollectionViewCellClickDelegate
- (void)clickAddCollectionViewCell:(AddCollectionViewCell *)cell sender:(UIButton *)sender {
	AddCategoryViewController *addVC = [[AddCategoryViewController alloc] initWithNibName:@"AddCategoryViewController" bundle:nil];
	[self presentViewController:addVC animated:YES completion:nil];
}
@end
