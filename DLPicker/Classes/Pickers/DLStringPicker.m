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
        [self setup];
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
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = _rows[row];
    NSDictionary *attributes = @{
                                NSForegroundColorAttributeName: _rowTitleColor,
                                NSFontAttributeName: _rowTitleFont
                                };
    return [[NSAttributedString alloc] initWithString:string attributes:attributes];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return _rowHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedIndex = row;
}

#pragma mark - Private

- (void)setup
{
    _rowHeight = 40.f;
    _rowTitleFont = [UIFont systemFontOfSize:15];
    _rowTitleColor = [UIColor blackColor];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    [_pickerView selectRow:_selectedIndex inComponent:0 animated:YES];
}

- (void)setRows:(NSArray<NSString *> *)rows
{
    _rows = rows;
    [_pickerView reloadAllComponents];
}

- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    [_pickerView reloadAllComponents];
}

- (void)setRowTitleFont:(UIFont *)rowTitleFont
{
    _rowTitleFont = rowTitleFont;
    [_pickerView reloadAllComponents];
}

- (void)setRowTitleColor:(UIColor *)rowTitleColor
{
    _rowTitleColor = rowTitleColor;
    [_pickerView reloadAllComponents];
}

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
