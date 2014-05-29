//
//  colorGet.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "colorGet.h"

@implementation colorGet

//RGBの色値を取得
- (void)getRGBA:(UIColor *)color red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    *red   = components[0];
    *green = components[1];
    *blue  = components[2];
    *alpha = components[3];
}

@end
