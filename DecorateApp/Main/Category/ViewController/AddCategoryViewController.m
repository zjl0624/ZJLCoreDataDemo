//
//  AddCategoryViewController.m
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "CategoryEntity+CoreDataClass.h"

@interface AddCategoryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)sureBtn:(id)sender;
- (IBAction)backBtn:(id)sender;


@end

@implementation AddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)sureBtn:(id)sender {
	CategoryEntity *en = [NSEntityDescription insertNewObjectForEntityForName:@"CategoryEntity" inManagedObjectContext:[BaseEngine sharedInstance].context];
	en.id = [CoreData GetNum];
	en.name = self.nameTextField.text;
	[CoreData insertWithData:en num:en.id success:^{
		[self dismissViewControllerAnimated:YES completion:nil];
	} failure:nil];
	
}

- (IBAction)backBtn:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
