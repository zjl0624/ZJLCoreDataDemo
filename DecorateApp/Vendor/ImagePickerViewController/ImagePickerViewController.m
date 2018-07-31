//
//  ImagePickerViewController.m
//  DecorateApp
//
//  Created by zjl on 2018/3/13.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "ImagePickerViewController.h"

@implementation ImagePickerViewController
- (void)InitImagePickerViewController:(UIViewController *)vc finishBlock:(FinishPickImage)finishBlock{
	if (finishBlock) {
		_finishPickImageBlock = finishBlock;
	}
	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
	UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
	pickerController.delegate = self;
	[actionSheet addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		[vc presentViewController:pickerController animated:YES completion:nil];

	}]];
	[actionSheet addAction:[UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[vc presentViewController:pickerController animated:YES completion:nil];
	}]];
	[actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		
	}]];
	[vc presentViewController:actionSheet animated:YES completion:nil];
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
	
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
	UIImage *im = info[UIImagePickerControllerOriginalImage];
	NSURL *imUrl = info[UIImagePickerControllerReferenceURL];
	self.finishPickImageBlock(im, imUrl);
	[picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private method

@end
