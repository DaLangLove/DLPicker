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

@interface DLStringPicker : DLPicker

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) NSArray <NSString *> *rows;

@property (nonatomic, copy) DLPickerDoneBlock doneBlock;

@property (nonatomic, copy) DLPickerCancelBlock cancelBlock;

/**
 每行的高度，默认 40
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 每行的字体颜色，默认 [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *rowTitleColor;

/**
 每行的字体，默认 [UIFont systemFontOfSize:15]
 */
@property (nonatomic, strong) UIFont *rowTitleFont;

- (instancetype)initWithTitle:(NSString * _Nullable)title
                         rows:(NSArray <NSString *> * _Nonnull)rows
             initialSelection:(NSUInteger)selection
                    doneBlock:(DLPickerDoneBlock _Nullable)done
                  cancelBlock:(DLPickerCancelBlock _Nullable)cancel
                         from:(id _Nullable)from;
@end

NS_ASSUME_NONNULL_END
