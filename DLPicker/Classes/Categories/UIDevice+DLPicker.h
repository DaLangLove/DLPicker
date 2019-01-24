//
//  UIDevice+DLPicker.h
//  Pods-Example
//
//  Created by Dalang on 2019/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (DLPicker)

/**
 是否设备底部有安全区域

 @return YES/NO
 */
+ (BOOL)isHaveSafeArea;

@end

NS_ASSUME_NONNULL_END
