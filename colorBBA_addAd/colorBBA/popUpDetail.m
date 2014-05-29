//
//  popUpDetail.m
//  colorBBA
//
//  Created by 池田　春菜 on 2014/05/26.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "popUpDetail.h"

@implementation popUpDetail

@synthesize delegate = _delegate;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(touchToPopUpDetail:)]) {
        [self.delegate touchToPopUpDetail:self];
    }
}

@end
