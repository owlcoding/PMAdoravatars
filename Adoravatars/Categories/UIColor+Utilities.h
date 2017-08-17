//
// Created by Pawel Maczewski on 28/07/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Utilities)

+ (UIColor *)colorWithRgb:(int)rgb;

+ (UIColor *)colorWithRgb:(int)rgb alpha:(float)alpha;

+ (UIColor *)statusOkColor;

+ (UIColor *)statusErrorColor;

+ (UIColor *)statusInProgressColor;

+ (UIColor *)statusUnknownColor;
@end