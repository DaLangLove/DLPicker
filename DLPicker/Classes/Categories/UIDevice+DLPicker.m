//
//  UIDevice+DLPicker.m
//  Pods-Example
//
//  Created by Dalang on 2019/1/24.
//

#import "UIDevice+DLPicker.h"

@implementation UIDevice (DLPicker)

+ (BOOL)isHaveSafeArea
{
    BOOL isHave = NO;
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isHave = YES;
        }
    }
    
    return isHave;
}



@end
