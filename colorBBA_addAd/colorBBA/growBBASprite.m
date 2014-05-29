//
//  growBBASprite.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "growBBASprite.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation growBBASprite

- (id)initPos:(CGPoint)pos {
    self = [super init];
    if (self) {
        NSUserDefaults* _defaults = [NSUserDefaults standardUserDefaults];
        int level = [_defaults integerForKey:@"BBA_level"];
        if (1 <= level && level < 5) {
            self = [growBBASprite spriteNodeWithImageNamed:@"01"];
        } else if (5 <= level && level < 10){
            self = [growBBASprite spriteNodeWithImageNamed:@"02"];
        }else if (10 <= level && level < 15){
            self = [growBBASprite spriteNodeWithImageNamed:@"03"];
        }else if (15 <= level && level < 20){
            self = [growBBASprite spriteNodeWithImageNamed:@"04"];
        }else if (20 <= level && level < 25){
            self = [growBBASprite spriteNodeWithImageNamed:@"05"];
        }else if(25 <= level && level < 30){
            self = [growBBASprite spriteNodeWithImageNamed:@"06"];
        }else{
            self = [growBBASprite spriteNodeWithImageNamed:@"07"];
        }

        self.position = pos;
        self.userInteractionEnabled = YES;
        self.xScale = 0.25f;
        self.yScale = 0.25f;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(growBBASpriteTouched:)]) {
        [self.delegate growBBASpriteTouched:self];
    }
}

+ (SKAction*)moveTo:(float)random {
    
    
    float rand1 = (((float)arc4random() / ARC4RANDOM_MAX) * 2.0f) - 1.0f;
    float rand2 = (random * 2) - 1.0f;
    NSLog(@"%f", rand1);
    NSLog(@"%f", rand2);
    float randomX = rand2 * 120;
    float randomY = rand1 * 120;
    if (abs(randomX) <= 10) {
        randomX = 0;
    }
    if (abs(randomY) <= 10) {
        randomY = 0;
    }
    SKAction* moveBy = [SKAction moveByX:randomX y:randomY duration:2.0f];
    
    switch (arc4random() % 4) {
        case 0:
            moveBy.timingMode = SKActionTimingEaseIn;
            break;
            
        case 1:
            moveBy.timingMode = SKActionTimingEaseOut;
            break;
            
        case 2:
            moveBy.timingMode = SKActionTimingEaseInEaseOut;
            break;
            
        default:
            moveBy.timingMode = SKActionTimingLinear;
            break;
    }
    
    return moveBy;
}

@end
