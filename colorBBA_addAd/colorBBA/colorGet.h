//
//  colorGet.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface colorGet : NSObject


- (void)getRGBA:(UIColor *)color red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

@end
