//
//  touchSprite.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/06.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "touchSprite.h"

@implementation touchSprite
@synthesize delegate = _delegate;

- (id)init:(CGRect)setFrame {
    self = [super init];
    
    if (self) {
        self = [touchSprite spriteNodeWithColor:[SKColor clearColor] size:setFrame.size];
        self.position = setFrame.origin;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(touchColorBall:)]) {
        [_delegate touchColorBall:self];
    }
}

@end
