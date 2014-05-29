//
//  vegitableEnemy.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/08.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "vegitableEnemy.h"

@implementation vegitableEnemy

@synthesize isTeasure = _isTeasure;
@synthesize keyTreasure = _keyTreasure;
@synthesize stamina = _stamina;
@synthesize experience = _experience;
@synthesize enemyTag = _enemyTag;

- (id)init:(CGPoint)position enemyImageName:(NSString *)str {
    self = [super init];
    if (self) {
        //モンスターのステータス
//        _isTeasure = 0;
//        _keyTreasure = 0;
//        _stamina = 0;
//        _experience = 0;
//        _enemyTag = 0;
        self = [vegitableEnemy spriteNodeWithImageNamed:str];
        self.position = position;
        self.xScale = 0.35f;
        self.yScale = 0.35f;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(vegitableEnemyTouch:)]) {
        [self.delegate vegitableEnemyTouch:self];
    }
}

- (void)setStamina:(int)stamina {
    _stamina = stamina;
}

- (int)stamina {
    return _stamina;
}

@end
