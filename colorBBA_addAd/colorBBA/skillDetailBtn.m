//
//  skillDetailBtn.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "skillDetailBtn.h"

@implementation skillDetailBtn

- (id)initPos:(CGPoint)position {
    self = [super init];
    if (self) {
        self = [skillDetailBtn spriteNodeWithImageNamed:@"active_Btn_skill.png"];
        self.position = position;
        self.userInteractionEnabled = YES;
        self.xScale = 0.25f;
        self.yScale = 0.25f;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(skillDetailBtn:)]) {
        [self.delegate skillDetailBtn:self];
    }
}


@end
