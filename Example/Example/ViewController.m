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
                                                  initialSelection:2
                                                   pickerConfigure:^(UIPickerView * _Nonnull picker) {
                                                       
                                                   } doneBlock:^(DLStringPicker * _Nonnull picker, NSUInteger selectedIndex, NSString * _Nonnull selectedValue) {
                                                       NSLog(@"%@ %@ %@", picker, @(selectedIndex), selectedValue);
                                                   } cancelBlock:^(DLStringPicker * _Nonnull picker) {
                                                       NSLog(@"%@", picker);
                                                   } from:sender];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"无固定期限" style:UIBarButtonItemStylePlain target:nil action:nil];
    [picker setRightButtons:@[item]];
    [picker show];
    
}




@end
