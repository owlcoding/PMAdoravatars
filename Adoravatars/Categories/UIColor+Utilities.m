//
// Created by Pawel Maczewski on 28/07/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import "UIColor+Utilities.h"


@implementation UIColor (Utilities)

+ (UIColor *)colorWithRgb:(int)rgb {
    return [UIColor colorWithRgb:rgb alpha:1];
}

+ (UIColor *)colorWithRgb:(int)rgb alpha:(float)alpha {
    return [UIColor colorWithRed:((float) ((rgb & 0xFF0000) >> 16)) / 255.0 green:((float) ((rgb & 0xFF00) >> 8)) / 255.0 blue:((float) (rgb & 0xFF)) / 255.0 alpha:alpha];
}

+ (UIColor *)statusOkColor {
    return [UIColor colorWithRgb:0xA1C517];
}

+ (UIColor *)statusErrorColor {
    return [UIColor colorWithRgb:0xCA171D];
}

+ (UIColor *)statusInProgressColor {
    return [UIColor colorWithRgb:0xE5EDF3];
}

+ (UIColor *)statusUnknownColor {
    return [UIColor colorWithRgb:0x808080];
}

@end