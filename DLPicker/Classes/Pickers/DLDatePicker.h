//
//  DLDatePicker.h
//  DLPicker
//
//  Created by Dalang on 2019/1/24.
//

#import "DLPicker.h"

NS_ASSUME_NONNULL_BEGIN

@class DLDatePicker;

typedef void(^DLDatePickerDoneBlock)(DLDatePicker * _Nullable picker,  id _Nullable selectedValue);
typedef void(^DLDatePickerCancelBlock)(DLDatePicker *_Nullable picker);
typedef void(^DLDatePickerViewConfigureBlock)(UIDatePicker * _Nonnull datePickerView);

@interface DLDatePicker : DLPicker

@property (nonatomic, copy) DLDatePickerDoneBlock doneBlock;

@property (nonatomic, copy) DLDatePickerCancelBlock cancelBlock;

@property (nonatomic, copy) DLDatePickerViewConfigureBlock configure;

- (instancetype)initWithTitle:(NSString * _Nullable)title
              pickerConfigure:(DLDatePickerViewConfigureBlock _Nullable)configure
                    doneBlock:(DLDatePickerDoneBlock _Nullable)done
                  cancelBlock:(DLDatePickerCancelBlock _Nullable)cancel
                         from:(id _Nullable)from;

@end

NS_ASSUME_NONNULL_END
