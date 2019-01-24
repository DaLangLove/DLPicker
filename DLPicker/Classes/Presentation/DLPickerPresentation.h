//
//  DLPickerPresentation.h
//  Pods-Example
//
//  Created by Dalang on 2019/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLPickerTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>

- (instancetype)initWithDisappearWhenTapBacground:(BOOL)disappearWhenTapBacground
                                       pickerSize:(CGSize)pickerSize;

@end


@interface DLPickerAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithPresented:(BOOL)isPresented;

@end


@interface DLPickerPresentationController : UIPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                      disappearWhenTapBacground:(BOOL)disappearWhenTapBacground
                                     pickerSize:(CGSize)pickerSie;

@end


@interface DLPickerPopoverPresentationControllerDelegate : NSObject<UIPopoverPresentationControllerDelegate>

- (instancetype)initWithDisappearWhenTapBacground:(BOOL)disappearWhenTapBacground;

@end

NS_ASSUME_NONNULL_END
