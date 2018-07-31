//
//  AddGoodsViewController.m
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "AddGoodsViewController.h"
#import "GoodsInfo+CoreDataClass.h"
#import "AddGoodsTableViewCell.h"
#import "GoodsCacheModel.h"
#import "ImagePickerViewController.h"
@interface AddGoodsViewController ()<TxtFieldDelegate> {
	DataSource *dataSource;
	Delegate *delegate;
	NSMutableArray *dataArray;
	BOOL isEditing;
	GoodsCacheModel *en;
	ImagePickerViewController *imageActionsheet;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation AddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InitTableview
- (void)initTableview {
	self.automaticallyAdjustsScrollViewInsets = NO;
	en = [[GoodsCacheModel alloc] init];
	if (self.isAdd) {
		isEditing = YES;
	}else {
		isEditing = NO;
	}
	dataArray = [[NSMutableArray alloc] init];
//	[dataArray addObject:@{@"title":@"id:",@"content":@(self.goods.id),@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	[dataArray addObject:@{@"title":@"分类:",@"content":@(self.goods.categoryID),@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	NSString *brand = @"";
	if (self.goods.brand) {
		brand = self.goods.brand;
	}
	[dataArray addObject:@{@"title":@"品牌:",@"content":brand,@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	[dataArray addObject:@{@"title":@"价格:",@"content":@(self.goods.price),@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	[dataArray addObject:@{@"title":@"长:",@"content":@(self.goods.length),@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	[dataArray addObject:@{@"title":@"宽:",@"content":@(self.goods.width),@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	[dataArray addObject:@{@"title":@"高:",@"content":@(self.goods.height),@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	NSString *remark = @"";
	if (self.goods.remark) {
		remark = self.goods.remark;
	}
	[dataArray addObject:@{@"title":@"备注:",@"content":remark,@"isAdd":@(self.isAdd),@"isEditing":@(isEditing)}];
	

	[_tableview registerNib:[UINib nibWithNibName:@"AddGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsInfoCell"];
	[_tableview registerNib:[UINib nibWithNibName:@"AddGoodsImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsImageCell"];
	dataSource = [[DataSource alloc] initWithDataArray:dataArray cellIDConfigureBlock:^NSString *(NSIndexPath *indexPath, id model) {
		if (indexPath.row <= 6){
			return @"GoodsInfoCell";
		}else {
			return @"GoodsImageCell";
		}
	} cellConfigure:^(NSIndexPath *indexPath, id model, id cell) {
		if (indexPath.row <= 6){
			AddGoodsTableViewCell *addCell = (AddGoodsTableViewCell *)cell;
			addCell.delegate = self;
		}
	}];
	
	_tableview.dataSource = dataSource;
	delegate = [[Delegate alloc] initWithSelectedBlock:^(NSIndexPath *indexPath) {
		
	} TableviewCellHeightBlock:^CGFloat(NSIndexPath *indexPath) {
		if (indexPath.row <= 6) {
			return 44;
		}
		return ScreenWidth;
	} TableviewSectionHeaderHeightBlock:^CGFloat(NSInteger section) {
		return 0;
	} TableviewSectionFooterHeightBlock:^CGFloat(NSInteger section) {
		return 0;
	}];
	_tableview.delegate = delegate;
	_tableview.tableHeaderView = [self createTableViewHeaderView];
	_tableview.tableFooterView = [self createTableviewFooterView];
}
- (UIView *)createTableViewHeaderView {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
	view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
	float rightBtnSize = 40;
	rightBtn.frame = CGRectMake(ScreenWidth - rightBtnSize - 10 , 24 - rightBtnSize/2, rightBtnSize, rightBtnSize);
	rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
	[view addSubview:rightBtn];
	[rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	if (self.isAdd) {
		[rightBtn setTitle:@"完成" forState:UIControlStateNormal];
	}else {
		if (isEditing) {
			[rightBtn setTitle:@"保存" forState:UIControlStateNormal];
		}else {
			[rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
		}
	}
	UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
	leftBtn.frame = CGRectMake(10,24 - rightBtnSize/2, rightBtnSize, rightBtnSize);
	leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
	[view addSubview:leftBtn];
	[leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
	[leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	return view;
}
- (void)rightBtnClick:(UIButton *)sender {
	if ([sender.titleLabel.text isEqual:@"完成"]) {
		GoodsInfo *gi = [NSEntityDescription insertNewObjectForEntityForName:@"GoodsInfo" inManagedObjectContext:[BaseEngine sharedInstance].context];
		gi.id = [CoreData GetNum];
		gi.categoryID = en.categoryID;
//		gi.image = en.image;
		gi.brand = en.brand;
		gi.price = en.price;
		gi.length = en.length;
		gi.width = en.width;
		gi.height = en.height;
		gi.isCheck = en.isCheck;
		gi.remark = en.remark;
		[CoreData insertWithData:gi num:gi.id success:^{
			[self.delegate currentViewControllerDismiss];
			[self dismissViewControllerAnimated:YES completion:nil];
		} failure:nil];
	}else {
		if ([sender.titleLabel.text isEqual:@"编辑"]){
			[sender setTitle:@"保存" forState:UIControlStateNormal];
			isEditing = YES;
			[dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				NSMutableDictionary *dic = [(NSDictionary *)obj mutableCopy];
				dic[@"isEditing"] = @(isEditing);
				dataArray[idx] = [dic copy];
			}];
			[_tableview reloadData];
		}else {
			[sender setTitle:@"编辑" forState:UIControlStateNormal];
			isEditing = NO;
			[self update];
		}

	}
}
- (void)leftBtnClick:(UIButton *)sender {
	[self.delegate currentViewControllerDismiss];
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (UIView *)createTableviewFooterView {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
	UIButton *addImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
	addImageBtn.frame = CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(view.frame));
	addImageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
	[addImageBtn setTitle:@"添加图片" forState:UIControlStateNormal];
	[view addSubview:addImageBtn];
	[addImageBtn addTarget:self action:@selector(addImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
	return view;
}

- (void)addImageBtnClick {
	imageActionsheet = [[ImagePickerViewController alloc] init];
	__weak AddGoodsViewController *weakself = self;
	[imageActionsheet InitImagePickerViewController:weakself finishBlock:^(UIImage *image, NSURL *imageUrl) {
		NSLog(@"%@",imageUrl);
		[dataArray addObject:image];
		[_tableview reloadData];
	}];
	
}

#pragma mark - FinishTxtFieldDelegate
- (void)didBeginEditing:(UITextField *)textField cell:(AddGoodsTableViewCell *)cell {
	NSIndexPath *indexpath = [_tableview indexPathForCell:cell];
		if ([[dataArray[indexpath.row] objectForKey:@"title"]  isEqual: @"分类:"]) {
			[textField resignFirstResponder];
			UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"分类" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
					[CoreData readDataWithEntityName:CategoryEntityName predicate:nil success:^(NSArray *resultArr) {
						[resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
							CategoryEntity *categoryEntity = (CategoryEntity *)obj;
							UIAlertAction *action = [UIAlertAction actionWithTitle:categoryEntity.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
								en.categoryID = categoryEntity.id;
								NSMutableDictionary *dic = [dataArray[indexpath.row] mutableCopy];
								dic[@"content"] = @(categoryEntity.id);
								dataArray[indexpath.row] = [dic copy];
								dispatch_async(dispatch_get_main_queue(), ^{
									[_tableview reloadData];
								});
							}];
							[actionSheet addAction:action];
						}];
					} failure:nil];
					[actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			
					}]];
			[self presentViewController:actionSheet animated:YES completion:nil];
			
		}

}

- (void)finishEditeWithTitle:(NSString *)title content:(NSString *)content {
	if ([title isEqualToString:@"id:"]) {
		en.id = [content intValue];
	}else if ([title isEqualToString:@"分类:"]){
		en.categoryID = [content intValue];
	}else if ([title isEqualToString:@"品牌:"]){
		en.brand = content;
	}else if ([title isEqualToString:@"价格:"]){
		en.price = [content intValue];
	}else if ([title isEqualToString:@"长:"]){
		en.length = [content floatValue];
	}else if ([title isEqualToString:@"宽:"]){
		en.width = [content floatValue];
	}else if ([title isEqualToString:@"高:"]){
		en.height = [content floatValue];
	}else if ([title isEqualToString:@"备注:"]){
		en.remark = content;
	}
}

- (void)update {
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GoodsInfo"];
	
	NSPredicate *pre = [NSPredicate predicateWithFormat:@"id = %d", self.goods.id];
	request.predicate = pre;
	
	//发送请求
	NSArray *resArray = [[BaseEngine sharedInstance].context executeFetchRequest:request error:nil];
	
	//修改
	for (GoodsInfo *goods in resArray) {
		if (en.brand) {
			goods.brand = en.brand;
		}
		if (en.remark) {
			goods.remark = en.remark;
		}
		if (en.categoryID != 0) {
			goods.categoryID = en.categoryID;
		}
		if (en.price != 0) {
			goods.price = en.price;
		}
		if (en.length != 0) {
			goods.length = en.length;
		}
		if (en.width != 0) {
			goods.width = en.width;
		}
		if (en.height != 0) {
			goods.height = en.height;
		}
	}
	
	
	//保存
	NSError *error = nil;
	if ([[BaseEngine sharedInstance].context save:&error]) {
		[ZJLHud showCustomHud:YES type:alertType title:@"修改成功"];
		[self dismissViewControllerAnimated:YES completion:nil];
	}else{
		[ZJLHud showCustomHud:YES type:alertType title:@"修改失败"];
	}
}
@end
