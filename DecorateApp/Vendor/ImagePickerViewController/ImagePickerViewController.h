//
//  ImagePickerViewController.h
//  DecorateApp
//
//  Created by zjl on 2018/3/13.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagePickerViewController : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

typedef void(^FinishPickImage)(UIImage *image,NSURL *imageUrl);

@property (nonatomic,strong) FinishPickImage finishPickImageBlock;
- (void )InitImagePickerViewController:(UIViewController *)vc finishBlock:(FinishPickImage)finishBlock;
@end
