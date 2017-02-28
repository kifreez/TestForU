//
//  KFListViewController.m
//  TestForU
//
//  Created by Kif on 27.02.17.
//  Copyright © 2017 KifApp. All rights reserved.
//

#import "KFListViewController.h"
#import "KFCustomTableViewCell.h"
#import "KFMemberRepository.h"

@interface KFListViewController ()

@property (strong, nonatomic) KFMemberRepository *member;

@end

@implementation KFListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeTextField.delegate = self;
    self.member = [[KFMemberRepository alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    [self.addTextButton addTarget:self action:@selector(setTextToLabel:) forControlEvents:UIControlEventTouchDown];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.member getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    KFCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.title.text = [NSString stringWithFormat:@"%@", [self.member getName:indexPath.row]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if(editingStyle == UITableViewCellEditingStyleDelete){

        UIAlertController *deleteAlert = [UIAlertController
                                           alertControllerWithTitle:@"Delete"
                                                            message:@"Are you sure that you want to remove this item?"
                                                     preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", nil)
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * _Nonnull action) {

            [self.member deleteName:indexPath.row];
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
            [tableView reloadData];
        }];

        [deleteAlert addAction:okAction];
        [self presentViewController:deleteAlert animated:YES completion:nil];

    }
}

#pragma mark - Keyboard mhetods

- (void)registerForKeyboardNotifications {

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)deregisterFromKeyboardNotifications {

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWasShown:(NSNotification *)notification {

    CGFloat keyboardHight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGPoint buttonOrigin = self.addTextButton.frame.origin;
    CGFloat buttonHeight = self.addTextButton.frame.size.height;
    CGRect visibleRect = self.scrollView.frame;

    visibleRect.size.height -= keyboardHight;

    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){

        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);

        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setTextToLabel:nil];
    [self.typeTextField resignFirstResponder];
    return YES;
}

#pragma mark - Button Action

-(IBAction)setTextToLabel:(UIButton*)sender {

    if (self.typeTextField.text.length > 0) {
        [self.member addName:self.typeTextField.text];
        [self.listTable reloadData];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Text field is empty" message:@"You should to write more than 1 symbol" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okAction];

        [self presentViewController:alert animated:YES completion:nil];
    }

}

@end
