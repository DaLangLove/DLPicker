//
//  UIViewController+DLPicker.m
//  Pods-Example
//
//  Created by Dalang on 2019/1/24.
//

#import "UIViewController+DLPicker.h"

@implementation UIViewController (DLPicker)

- (UIViewController *)topmost
{
    UIViewController *topmost = self;
    UIViewController *above = topmost.presentedViewController;
    while (above != nil) {
        topmost = above;
        above = above.presentedViewController;
    }
    return topmost;
}

@end
