//
//  KFListViewController.h
//  TestForU
//
//  Created by Kif on 27.02.17.
//  Copyright © 2017 KifApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> 

@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UIButton *addTextButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *listTable;


@end
