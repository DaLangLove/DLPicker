//
//  DLPickerPresentation.m
//  Pods-Example
//
//  Created by Dalang on 2019/1/24.
//

#import "DLPickerPresentation.h"

@interface DLPickerTransitioningDelegate ()

@property (nonatomic, assign) BOOL disappearWhenTapBacground;

@property (nonatomic, assign) CGSize pickerSize;

@end

@implementation DLPickerTransitioningDelegate

- (instancetype)initWithDisappearWhenTapBacground:(BOOL)disappearWhenTapBacground pickerSize:(CGSize)pickerSize
{
    self = [super init];
    if (self) {
        _disappearWhenTapBacground = disappearWhenTapBacground;
        _pickerSize = pickerSize;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source
{
    return [[DLPickerAnimatedTransitioning alloc] initWithPresented:YES];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DLPickerAnimatedTransitioning alloc] initWithPresented:NO];
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                               presentingViewController:(nullable UIViewController *)presenting
                                                                   sourceViewController:(UIViewController *)source
{
    return [[DLPickerPresentationController alloc] initWithPresentedViewController:presented
                                                          presentingViewController:presenting
                                                         disappearWhenTapBacground:_disappearWhenTapBacground
                                                                        pickerSize:_pickerSize];
}

@end


#pragma mark -
#pragma mark - DLPickerAnimatedTransitioning

@interface DLPickerAnimatedTransitioning ()

@property (nonatomic, assign) BOOL isPresented;

@end

@implementation DLPickerAnimatedTransitioning

- (instancetype)initWithPresented:(BOOL)isPresented
{
    self = [super init];
    if (self) {
        _isPresented = isPresented;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UITransitionContextViewControllerKey key = _isPresented ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey;
    UIViewController *controller = [transitionContext viewControllerForKey:key];

    if (_isPresented) {
        [transitionContext.containerView addSubview:controller.view];
    }
    
    CGRect presentedFrame = [transitionContext finalFrameForViewController:controller];
    CGRect dismissedFrame = presentedFrame;
    dismissedFrame.origin.y = transitionContext.containerView.frame.size.height;
    
    CGRect initialFrame = _isPresented ? dismissedFrame : presentedFrame;
    CGRect finalFrame = _isPresented ? presentedFrame : dismissedFrame;
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    controller.view.frame = initialFrame;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         controller.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:finished];
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

@end

#pragma mark -
#pragma mark - DLPickerPresentationController

@interface DLPickerPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@property (nonatomic, assign) BOOL disappearWhenTapBacground;

@property (nonatomic, assign) CGSize pickerSize;

@end

@implementation DLPickerPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                      disappearWhenTapBacground:(BOOL)disappearWhenTapBacground
                                     pickerSize:(CGSize)pickerSize
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _disappearWhenTapBacground = disappearWhenTapBacground;
        _pickerSize = pickerSize;
        [self setupDimmingView];
    }
    return self;
}

- (void)setupDimmingView
{
    _dimmingView = [[UIView alloc] initWithFrame:CGRectZero];
    _dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _dimmingView.alpha = 0;
    
    if (_disappearWhenTapBacground) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disapear)];
        [_dimmingView addGestureRecognizer:tap];
    }
}

#pragma mark - 点击背景消失
- (void)disapear
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Overrides
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect frame = CGRectZero;
    frame.size = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:self.containerView.bounds.size];
    frame.origin.y = self.containerView.frame.size.height - _pickerSize.height;
    return frame;
}

- (void)presentationTransitionWillBegin
{
    [self.containerView insertSubview:_dimmingView atIndex:0];
    NSDictionary *views = NSDictionaryOfVariableBindings(_dimmingView);
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dimmingView]|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dimmingView]|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views]];
    
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator == nil) {
        _dimmingView.alpha = 1.0;
        return;
    }
    __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.dimmingView.alpha = 1.0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)dismissalTransitionWillBegin
{
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator == nil) {
        _dimmingView.alpha = 0;
        return;
    }
    __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.dimmingView.alpha = 0.0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)containerViewWillLayoutSubviews
{
    self.presentedView.frame = self.frameOfPresentedViewInContainerView;
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    return CGSizeMake(parentSize.width, _pickerSize.height);
}

@end

#pragma mark -
#pragma mark - DLPickerPopoverPresentationControllerDelegate

@interface DLPickerPopoverPresentationControllerDelegate ()

@property (nonatomic, assign) BOOL disappearWhenTapBacground;

@end

@implementation DLPickerPopoverPresentationControllerDelegate

- (instancetype)initWithDisappearWhenTapBacground:(BOOL)disappearWhenTapBacground
{
    self = [super init];
    if (self) {
        _disappearWhenTapBacground = disappearWhenTapBacground;
    }
    return self;
}

#pragma mark - UIPopoverPresentationControllerDelegate
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return _disappearWhenTapBacground;
}

@end
