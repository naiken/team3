//
//  mainBBASprite.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/08.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "mainBBASprite.h"

@implementation mainBBASprite

@synthesize stamina = _stamina;
@synthesize level = _level;
@synthesize experience = _experience;
@synthesize BBATag = _BBATag;

- (id)init:(CGPoint)position {
    self = [super init];
    if (self) {
        //BBAのダンジョンでのステータス
//        _stamina = 0;
//        _level = 0;
//        _experience = 0;
//        _BBATag = 0;
        
        
        NSUserDefaults* _defaults = [NSUserDefaults standardUserDefaults];
        int level = (int)[_defaults integerForKey:@"BBA_level"];
        if (1 <= level && level < 5) {
            self = [mainBBASprite spriteNodeWithImageNamed:@"01"];
        } else if (5 <= level && level < 10){
            self = [mainBBASprite spriteNodeWithImageNamed:@"02"];
        }else if (10 <= level && level < 15){
            self = [mainBBASprite spriteNodeWithImageNamed:@"03"];
        }else if (15 <= level && level < 20){
            self = [mainBBASprite spriteNodeWithImageNamed:@"04"];
        }else if (20 <= level && level < 25){
            self = [mainBBASprite spriteNodeWithImageNamed:@"05"];
        }else if(25 <= level && level < 30){
            self = [mainBBASprite spriteNodeWithImageNamed:@"06"];
        }else{
            self = [mainBBASprite spriteNodeWithImageNamed:@"07"];
        }

        self.position = position;
        self.userInteractionEnabled = YES;
        self.xScale = 0.25f;
        self.yScale = 0.25f;
    }
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        //BBAのダンジョンでのステータス
        //        _stamina = 0;
        //        _level = 0;
        //        _experience = 0;
        //        _BBATag = 0;
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(touchMainBBA:)]) {
        
        [self.delegate touchMainBBA:self];
    }
}

- (void)setStamina:(int)stamina {
    _stamina = stamina;
}

- (int)stamina {
    return _stamina;
}


@end
