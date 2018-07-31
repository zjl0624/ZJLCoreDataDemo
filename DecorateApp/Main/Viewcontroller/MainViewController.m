//
//  MainViewController.m
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "MainViewController.h"
#import "PagesView.h"
#import "OneCategoryViewController.h"
#import "CategoryViewController.h"
#import "AddCategoryViewController.h"
#import "CategoryEntity+CoreDataClass.h"

@interface MainViewController () {
	NSMutableArray *titlesArray;
	NSMutableArray *viewControllersArray;
	PagesView *pageView;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initView];

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self getCategory];
	[self createPageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CoreData
- (void)getCategory {
	[CoreData readDataWithEntityName:@"CategoryEntity" predicate:nil success:^(NSArray *resultArr) {
		[titlesArray removeAllObjects];
		[viewControllersArray removeAllObjects];
		[resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			CategoryEntity *en = (CategoryEntity *)obj;
			[titlesArray addObject:en.name];
			OneCategoryViewController *vc = [[OneCategoryViewController alloc] initWithNibName:@"OneCategoryViewController" bundle:nil];
			vc.currentCategoryID = en.id;
			[viewControllersArray addObject:vc];
//			[pageView setDataSource:titlesArray viewcontorllersArray:viewControllersArray];
		}];
	} failure:nil];

	
}

#pragma mark - PageView
- (void)createPageView {
	if (pageView) {
		[pageView removeFromSuperview];
	}
	pageView = [[PagesView alloc] initPagesViewWithTitleArray:[titlesArray copy] viewControllersArray:[viewControllersArray copy] viewController:self];
	pageView.isTitleScroll = YES;
//	[pageView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 48)];
	[self.view addSubview:pageView];
}
#pragma mark - private method
- (void)initView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	titlesArray = [[NSMutableArray alloc] init];
	viewControllersArray = [[NSMutableArray alloc] init];
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
	self.navigationItem.rightBarButtonItem = rightItem;
	self.navigationItem.title = @"首页";
}

- (void)rightBarButtonItemClick {
	CategoryViewController *vc = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
	vc.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:vc animated:YES];
	
}
@end
