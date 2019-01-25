//
//  DLStringPicker.h
//  DLPicker
//
//  Created by Dalang on 2019/1/24.
//

#import "DLPicker.h"

NS_ASSUME_NONNULL_BEGIN

@class DLStringPicker;
typedef void(^DLPickerDoneBlock)(DLStringPicker * _Nullable picker, NSUInteger selecedIndex, NSString * _Nullable selectedValue);
typedef void(^DLPickerCancelBlock)(DLStringPicker *_Nullable picker);
typedef void(^DLPickerViewConfigureBlock)(UIPickerView *_Nonnull picker);

@interface DLStringPicker : DLPicker

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) NSArray <NSString *> *rows;

@property (nonatomic, copy) DLPickerDoneBlock doneBlock;

@property (nonatomic, copy) DLPickerCancelBlock cancelBlock;

@property (nonatomic, copy) DLPickerViewConfigureBlock configureBlock;

- (instancetype)initWithTitle:(NSString * _Nullable)title
                         rows:(NSArray <NSString *> * _Nonnull)rows
             initialSelection:(NSUInteger)selection
              pickerConfigure:(DLPickerViewConfigureBlock)configure
                    doneBlock:(DLPickerDoneBlock _Nullable)done
                  cancelBlock:(DLPickerCancelBlock _Nullable)cancel
                         from:(id _Nullable)from;
@end

NS_ASSUME_NONNULL_END
