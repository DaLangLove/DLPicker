//
//  DLPicker.m
//  Pods-Example
//
//  Created by Dalang on 2019/1/24.
//

#import "DLPicker.h"

#import "DLPickerPresentation.h"

#import "UIDevice+DLPicker.h"
#import "UIViewController+DLPicker.h"

@interface DLPicker ()

@property (nonatomic, strong) DLPickerTransitioningDelegate *transitioningDelegate;

@property (nonatomic, strong) DLPickerPopoverPresentationControllerDelegate *popoverPresentationControllerDelegate;

@property (nonatomic, strong) NSMutableArray *leftBarButtons;

@property (nonatomic, strong) NSMutableArray *rightBarButtons;

@property (nonatomic, strong) UIBarButtonItem *cancelButton;

@property (nonatomic, strong) UIBarButtonItem *doneButton;

/**
 Picker的尺寸
 */
@property (nonatomic, assign) CGSize pickerSize;

@end

@implementation DLPicker

#pragma mark - Initizlized

- (instancetype)initWithPickerFrom:(id)from
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _from = from;
        [self defaultSetup];
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self defaultSetup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self defaultSetup];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSetup];
    }
    return self;
}



#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBar];
    
    [self setButtons];
}

#pragma mark - Public methods
- (void)show
{
    UIViewController *topViewController = [self topViewController];
    if (topViewController == nil) {
        NSLog(@"topViewController = %@", topViewController);
        return;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (_from == nil) {
            NSLog(@"from = %@", _from);
            return;
        }
    }
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        nav.transitioningDelegate = self.transitioningDelegate;
        nav.modalPresentationStyle = UIModalPresentationCustom;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nav.modalPresentationStyle = UIModalPresentationPopover;
        nav.preferredContentSize = self.pickerSize;
        nav.popoverPresentationController.delegate = self.popoverPresentationControllerDelegate;
        
        if ([_from isKindOfClass:[UIBarButtonItem class]]) {
            nav.popoverPresentationController.barButtonItem = _from;
        } else if ([_from isKindOfClass:[UIView class]]) {
            nav.popoverPresentationController.sourceView = _from;
            nav.popoverPresentationController.sourceRect = [_from bounds];
        }
    }
    [topViewController presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setCancelButton:(UIBarButtonItem *)cancelButton
{
    if (cancelButton != nil) {
        cancelButton.target = self;
        cancelButton.action = @selector(cancelButtonAction);
        _cancelButton = cancelButton;
        [self setButtons];
    }
}

- (void)setDoneButton:(UIBarButtonItem *)doneButton
{
    if (doneButton != nil) {
        doneButton.target = self;
        doneButton.action = @selector(doneButtonAction);
        _doneButton = doneButton;
        [self setButtons];
    }
}
- (void)setLeftButtons:(NSArray <UIBarButtonItem *> *)leftButtons;
{
    if (leftButtons.count > 0) {
        [_leftBarButtons removeAllObjects];
        [_leftBarButtons addObjectsFromArray:leftButtons];
        [self setButtons];
    }
}

- (void)setRightButtons:(NSArray <UIBarButtonItem *> *)rightButtons

{
    if (rightButtons.count > 0) {
        [_rightBarButtons removeAllObjects];
        [_rightBarButtons addObjectsFromArray:rightButtons];
        [self setButtons];
    }
}

- (void)layoutPickerView:(__kindof UIView *)pickerView
{
    pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view removeConstraints:self.view.constraints];
    
    NSLayoutConstraint *top, *bottom, *left, *right;
    if (@available(iOS 11, *)) {
        top = [NSLayoutConstraint constraintWithItem:pickerView
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:self.view.safeAreaLayoutGuide
                                           attribute:NSLayoutAttributeTop
                                          multiplier:1
                                            constant:0];
        bottom = [NSLayoutConstraint constraintWithItem:pickerView
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view.safeAreaLayoutGuide
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1
                                               constant:0];
        left = [NSLayoutConstraint constraintWithItem:pickerView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.view.safeAreaLayoutGuide
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1
                                             constant:0];
        right = [NSLayoutConstraint constraintWithItem:pickerView
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.view.safeAreaLayoutGuide
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1
                                              constant:0];
    } else {
        top = [NSLayoutConstraint constraintWithItem:pickerView
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:self.view
                                           attribute:NSLayoutAttributeTop
                                          multiplier:1
                                            constant:0];
        bottom = [NSLayoutConstraint constraintWithItem:pickerView
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1
                                               constant:0];
        left = [NSLayoutConstraint constraintWithItem:pickerView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.view
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1
                                             constant:0];
        right = [NSLayoutConstraint constraintWithItem:pickerView
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.view
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1
                                              constant:0];
    }
    [self.view addConstraints:@[top, bottom, left, right]];
    
}

#pragma mark - Private


#pragma mark - methods
- (void)defaultSetup
{
    _disappearWhenTapBackground = YES;
    
    CGFloat width, height;
    width = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 414.f : [UIScreen mainScreen].bounds.size.width;
    height = [UIDevice isHaveSafeArea] ? 294.f : 260.f;
    _pickerSize = CGSizeMake(width, height);
    
    _leftBarButtons = [[NSMutableArray alloc] init];
    _rightBarButtons = [[NSMutableArray alloc] init];
    
    _topBarTitleFont = [UIFont systemFontOfSize:15];
    _topBarTitleColor = [UIColor blackColor];
    _topBarActionButtonTitleFont = [UIFont systemFontOfSize:15];
    _topBarActionButtonTitleColor = [UIColor blueColor];
    _topBarBackgroundColor = [UIColor whiteColor];
    
}

- (void)setButtons
{
    if (_cancelButton == nil) {
        _cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
    }
    
    if (_doneButton == nil) {
        _doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonAction)];
    }
    
    NSMutableArray *lefts = [NSMutableArray array];
    [lefts addObject:_cancelButton];
    [lefts addObjectsFromArray:_leftBarButtons];
    self.navigationItem.leftBarButtonItems = lefts;
    
    NSMutableArray *rights = [NSMutableArray array];
    [rights addObject:_doneButton];
    [rights addObjectsFromArray:_rightBarButtons];
    self.navigationItem.rightBarButtonItems = rights;
    
    NSDictionary *attibutes = @{
                                NSFontAttributeName: _topBarActionButtonTitleFont,
                                NSForegroundColorAttributeName: _topBarActionButtonTitleColor
                                };
    
    for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems) {
        [item setTitleTextAttributes:attibutes forState:UIControlStateNormal];
    }
    
    for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
        [item setTitleTextAttributes:attibutes forState:UIControlStateNormal];
    }
}

- (void)setNavigationBar
{
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setTitleTextAttributes:@{
                                  NSFontAttributeName: _topBarTitleFont,
                                  NSForegroundColorAttributeName: _topBarTitleColor
                                  }];
    [bar setBarTintColor:_topBarBackgroundColor];
    [bar setTranslucent:NO];
}

- (UIViewController *)topViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController.topmost;
}

- (void)cancelButtonAction
{
    
}

- (void)doneButtonAction
{
    
}

#pragma mark - Properties
- (DLPickerTransitioningDelegate *)transitioningDelegate
{
    if (_transitioningDelegate == nil) {
        _transitioningDelegate = [[DLPickerTransitioningDelegate alloc] initWithDisappearWhenTapBacground:_disappearWhenTapBackground pickerSize:_pickerSize];
    }
    return _transitioningDelegate;
}

- (DLPickerPopoverPresentationControllerDelegate *)popoverPresentationControllerDelegate
{
    if (_popoverPresentationControllerDelegate == nil) {
        _popoverPresentationControllerDelegate = [[DLPickerPopoverPresentationControllerDelegate alloc] initWithDisappearWhenTapBacground:_disappearWhenTapBackground];
    }
    return _popoverPresentationControllerDelegate;
}

- (void)setDisappearWhenTapBackground:(BOOL)disappearWhenTapBackground
{
    _disappearWhenTapBackground = disappearWhenTapBackground;
    _transitioningDelegate = [[DLPickerTransitioningDelegate alloc] initWithDisappearWhenTapBacground:_disappearWhenTapBackground pickerSize:_pickerSize];
    _popoverPresentationControllerDelegate = [[DLPickerPopoverPresentationControllerDelegate alloc] initWithDisappearWhenTapBacground:_disappearWhenTapBackground];
}

- (void)setPickerSize:(CGSize)pickerSize
{
    _pickerSize = pickerSize;
    _transitioningDelegate = [[DLPickerTransitioningDelegate alloc] initWithDisappearWhenTapBacground:_disappearWhenTapBackground pickerSize:_pickerSize];
    _popoverPresentationControllerDelegate = [[DLPickerPopoverPresentationControllerDelegate alloc] initWithDisappearWhenTapBacground:_disappearWhenTapBackground];
}


- (void)setTopBarTitleFont:(UIFont *)topBarTitleFont
{
    _topBarTitleFont = topBarTitleFont;
    [self setNavigationBar];
}

- (void)setTopBarTitleColor:(UIColor *)topBarTitleColor
{
    _topBarTitleColor = topBarTitleColor;
    [self setNavigationBar];
}

- (void)setTopBarActionButtonTitleFont:(UIFont *)topBarActionButtonTitleFont
{
    _topBarActionButtonTitleFont = topBarActionButtonTitleFont;
    [self setButtons];
}

- (void)setTopBarActionButtonTitleColor:(UIColor *)topBarActionButtonTitleColor
{
    _topBarActionButtonTitleColor = topBarActionButtonTitleColor;
    [self setButtons];
}

- (void)setTopBarBackgroundColor:(UIColor *)topBarBackgroundColor
{
    _topBarBackgroundColor = topBarBackgroundColor;
    [self setNavigationBar];
}

@end
