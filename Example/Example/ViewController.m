//
//  ViewController.m
//  Example
//
//  Created by Dalang on 2019/1/24.
//  Copyright © 2019 Dalang. All rights reserved.
//

#import "ViewController.h"

#import "DLStringPicker.h"

#import "DLDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (IBAction)leftAction:(id)sender {
    
    DLDatePicker *datePicker = [[DLDatePicker alloc] initWithTitle:@"请选择"
                                                   pickerConfigure:^(UIDatePicker * _Nonnull datePickerView) {
                                                       datePickerView.datePickerMode = UIDatePickerModeDate;
                                                   } doneBlock:^(DLDatePicker * _Nullable picker, id  _Nullable selectedValue) {
                                                       NSLog(@"%@ %@", picker, selectedValue);
                                                   } cancelBlock:^(DLDatePicker * _Nullable picker) {
                                                       NSLog(@"%@", picker);
                                                   } from:sender];
    [datePicker show];
}

- (IBAction)rightAction:(id)sender {
    DLDatePicker *datePicker = [[DLDatePicker alloc] initWithTitle:@"请选择"
                                                   pickerConfigure:^(UIDatePicker * _Nonnull datePickerView) {
                                                       datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
                                                   } doneBlock:^(DLDatePicker * _Nullable picker, id  _Nullable selectedValue) {
                                                       NSLog(@"%@ %@", picker, selectedValue);
                                                   } cancelBlock:^(DLDatePicker * _Nullable picker) {
                                                       NSLog(@"%@", picker);
                                                   } from:sender];
    [datePicker show];
}

- (IBAction)showAction:(id)sender {
    
     DLStringPicker *picker = [[DLStringPicker alloc] initWithTitle:@"请选择"
                                                               rows:@[@"1", @"2", @"3", @"4", @"5"]
                                                   initialSelection:3
                                                          doneBlock:^(DLStringPicker * _Nullable picker, NSUInteger selecedIndex, NSString * _Nullable selectedValue) {
                                                              NSLog(@"%@ %@ %@", picker, @(selecedIndex), selectedValue);
                                                          } cancelBlock:^(DLStringPicker * _Nullable picker) {
                                                              NSLog(@"%@", picker);
                                                          } from:sender];
    
    picker.topBarBackgroundColor = [UIColor brownColor];
    picker.topBarTitleColor = [UIColor whiteColor];
    picker.topBarTitleFont = [UIFont systemFontOfSize:20];
    picker.topBarActionButtonTitleColor = [UIColor yellowColor];
    picker.topBarActionButtonTitleFont = [UIFont systemFontOfSize:18];
    
    picker.rowHeight = 50.f;
    picker.rowTitleFont = [UIFont systemFontOfSize:18];
    picker.rowTitleColor = [UIColor grayColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"无固定期限" style:UIBarButtonItemStylePlain target:nil action:nil];
    [picker setRightButtons:@[item]];
    [picker show];
    
}




@end
