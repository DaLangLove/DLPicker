//
//  DLPicker.h
//  Pods-Example
//
//  Created by Dalang on 2019/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLPicker : UIViewController

/**
 点击背景是否消失 默认YES
 */
@property (nonatomic, assign) BOOL disappearWhenTapBackground;

/**
 Picker的尺寸
 */
@property (nonatomic, assign) CGSize pickerSize;

/**
 Picker触发控件，当在iPad上不能为空
 */
@property (nonatomic, weak) id from;

/**
 Init

 @param from Picker from
 @return DLPicker
 */
- (instancetype)initWithPickerFrom:(id)from;

/**
 Present
 */
- (void)show;

/**
 Dismiss
 */
- (void)dismiss;


/**
 设置取消和确定按钮
 */
- (void)setCancelButton:(UIBarButtonItem *)cancelButton;
- (void)setDoneButton:(UIBarButtonItem *)doneButton;

/**
 设置左右测按钮
 */
- (void)setLeftButtons:(NSArray <UIBarButtonItem *> *)leftButtons;
- (void)setRightButtons:(NSArray <UIBarButtonItem *> *)rightButtons;

/**
 布局

 @param pickerView 要添加的Picker
 */
- (void)layoutPickerView:(__kindof UIView *)pickerView;

@end

NS_ASSUME_NONNULL_END
