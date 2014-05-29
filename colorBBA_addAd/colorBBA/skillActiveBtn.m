//
//  skillActiveBtn.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "skillActiveBtn.h"


@implementation skillActiveBtn

- (id)init:(CGPoint)position {
    self = [super init];
    if (self) {
        self = [skillActiveBtn spriteNodeWithImageNamed:@"active_Btn_skill.png"];
        self.position = position;
        self.userInteractionEnabled = YES;
        self.xScale = 0.25f;
        self.yScale = 0.25f;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(skillActiveAction:)]) {
        [self.delegate skillActiveAction:self];
    }
}


@end
