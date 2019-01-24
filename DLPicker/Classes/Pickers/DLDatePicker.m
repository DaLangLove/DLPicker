//
//  DLDatePicker.m
//  DLPicker
//
//  Created by Dalang on 2019/1/24.
//

#import "DLDatePicker.h"

@interface DLDatePicker ()

@property (nonatomic, strong) UIDatePicker *datePicker;


@end

@implementation DLDatePicker

- (instancetype)initWithTitle:(NSString *)title
              pickerConfigure:(DLDatePickerViewConfigureBlock)configure
                    doneBlock:(DLDatePickerDoneBlock)done
                  cancelBlock:(DLDatePickerCancelBlock)cancel
                         from:(id)from
{
    self = [super initWithPickerFrom:from];
    if (self) {
        self.title = title;
        _configure = configure;
        _doneBlock = done;
        _cancelBlock = cancel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_datePicker];
    [self layoutPickerView:_datePicker];

    if (_configure) {
        _configure(_datePicker);
    }
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
        _doneBlock(self, _datePicker.date);
    }
    [self dismiss];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
