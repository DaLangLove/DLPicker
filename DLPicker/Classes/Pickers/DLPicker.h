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
 顶部导航栏标题颜色，默认 [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *topBarTitleColor;

/**
 顶部导航栏标题字体, 默认 [UIFont systemFontOfSize:15]
 */
@property (nonatomic, strong) UIFont *topBarTitleFont;

/**
 顶部导航栏按钮标题颜色，默认 [UIColor blueColor]
 */
@property (nonatomic, strong) UIColor *topBarActionButtonTitleColor;

/**
 顶部导航栏按钮标题字体，默认 [UIFont systemFontOfSize:15]
 */
@property (nonatomic, strong) UIFont *topBarActionButtonTitleFont;

/**
 顶部导航栏背景色，默认 [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *topBarBackgroundColor;

/**
 点击背景是否消失 默认YES
 */
@property (nonatomic, assign) BOOL disappearWhenTapBackground;

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
