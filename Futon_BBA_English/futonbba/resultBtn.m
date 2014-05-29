//
//  resultBtn.m
//  FutonBBA
//
//  Created by Doi Daihei on 2014/05/16.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "resultBtn.h"


@implementation resultBtn

@synthesize delegate = _delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(resultBtn:)]) {
        [_delegate resultBtn:self];
    }
}

@end
