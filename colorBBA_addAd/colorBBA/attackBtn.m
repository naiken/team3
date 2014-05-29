//
//  attackBtn.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/08.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "attackBtn.h"

@implementation attackBtn

- (id)init:(CGPoint)position {
    self = [super init];
    if (self) {
        self = [attackBtn spriteNodeWithImageNamed:@"active_Btn_attack.png"];
        self.position = position;
        self.userInteractionEnabled = YES;
        self.xScale = 0.25f;
        self.yScale = 0.25f;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(attackTouchBtn:)]) {
        [self.delegate attackTouchBtn:self];
    }
}

@end
