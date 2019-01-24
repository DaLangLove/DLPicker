//
//  DLStringPicker.m
//  DLPicker
//
//  Created by Dalang on 2019/1/24.
//

#import "DLStringPicker.h"

@interface DLStringPicker ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation DLStringPicker

- (instancetype)initWithTitle:(NSString *)title
                         rows:(NSArray <NSString *> *)rows
             initialSelection:(NSUInteger)selection
              pickerConfigure:(DLPickerViewConfigureBlock)configure
                    doneBlock:(DLPickerDoneBlock)done
                  cancelBlock:(DLPickerCancelBlock)cancel
                         from:(id)from
{
    self = [super initWithPickerFrom:from];
    if (self) {
        self.title = title;
        
        _rows = rows;
        _selectedIndex = selection;
        _doneBlock = done;
        _cancelBlock = cancel;
        _configureBlock = configure;
    }
    return self;
}

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    [self layoutPickerView:_pickerView];
    
    if (_configureBlock != nil) {
        _configureBlock(_pickerView);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:_selectedIndex inComponent:0 animated:YES];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _rows.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _rows[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedIndex = row;
}

#pragma mark - Private

#pragma mark - Override
- (void)cancelButtonAction
{
    if (_cancelBlock) {
        _cancelBlock(self);
    }
    [self dismiss];
}

- (void)doneButtonAction
{
    if (_doneBlock) {
        _doneBlock(self, _selectedIndex, _rows[_selectedIndex]);
    }
    [self dismiss];
}

@end
