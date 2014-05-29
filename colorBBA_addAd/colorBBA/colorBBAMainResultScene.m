//
//  colorBBAMainResultScene.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/20.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "colorBBAMainResultScene.h"

@interface colorBBAMainResultScene () {
    
    CGPoint _frameCenter;
    
    NSUserDefaults* _defaults;
    
    int _needExp;
    int _nowBBAExp;
    int _totalExp;
    int _getExp;
    
    UIProgressView* _expBarProgress;
    
    int _timeCount;
    int _touchCount;
    int _levelCount;
    
    int _level;
}

@end

@implementation colorBBAMainResultScene

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        
        _frameCenter = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        _touchCount = 0;
        _timeCount = 0;
        
        
        //背景
        SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"main_4inch"];
        bg.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        bg.position = _frameCenter;
        [self addChild:bg];
        
        SKSpriteNode* bgWhite = [SKSpriteNode spriteNodeWithImageNamed:@"bg_main_black_4inch"];
        bgWhite.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        bgWhite.position = _frameCenter;
        [self addChild:bgWhite];
        
        _defaults = [NSUserDefaults standardUserDefaults];
        _getExp = (int)[_defaults integerForKey:@"experience_recenet_Battle"];
        int usedStamina = (int)[_defaults integerForKey:@"used_stamina"];
        _level = (int)[_defaults integerForKey:@"BBA_level"];
        int oneTimeAgoStamina = (int)[_defaults integerForKey:@"BBA_stamina"];
        int updateStamina = oneTimeAgoStamina - usedStamina;
        [_defaults setInteger:updateStamina forKey:@"BBA_stamina"];
        
        int nowNeedsExp = [self nextLevel:_level];
        int oneAgoExp = 0;
        if (_level > 1) {
            oneAgoExp = [self nextLevel:_level - 1];
        }
        
        //BBAの今の合計所持経験値
        _totalExp = (int)[_defaults doubleForKey:@"BBA_experience"];
        
        //次に必要な経験値。
        _needExp = nowNeedsExp - oneAgoExp;
        
        //BBAの今の経験値。
        _nowBBAExp = _totalExp - oneAgoExp;
        
        _expBarProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _expBarProgress.progress = (float)_nowBBAExp / (float)_needExp;
        _expBarProgress.progressTintColor = [UIColor blueColor];
        _expBarProgress.trackTintColor = [UIColor blackColor];
        _expBarProgress.frame = CGRectMake(_frameCenter.x - 100, _frameCenter.y * 0.65f, 200, 33);
        _expBarProgress.transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        
        SKLabelNode* kekkaLabel = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        kekkaLabel.text = @"Result";
        kekkaLabel.fontSize = 30.0f;
        kekkaLabel.position = CGPointMake(_frameCenter.x, _frameCenter.y * 1.55f);
        [self addChild:kekkaLabel];
        kekkaLabel.fontColor = [SKColor blackColor];
        
        SKLabelNode* experienceLabel = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        experienceLabel.text = [NSString stringWithFormat:@"EXP: %d",_getExp];
        experienceLabel.fontSize = 30.0f;
        experienceLabel.position = CGPointMake(_frameCenter.x, _frameCenter.y * 1.4f);
        experienceLabel.fontColor = [SKColor blackColor];
        [self addChild:experienceLabel];
        
        SKLabelNode* usedStaminaLabel = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        usedStaminaLabel.text = [NSString stringWithFormat:@"Stamina: %d",usedStamina];
        usedStaminaLabel.fontSize = 30.0f;
        usedStaminaLabel.position = CGPointMake(_frameCenter.x, _frameCenter.y * 1.2f);
        usedStaminaLabel.fontColor = [SKColor blackColor];
        [self addChild:usedStaminaLabel];
        
        SKLabelNode* getTresureLabel = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        getTresureLabel.text = [NSString stringWithFormat:@"GET ITEM"];
        getTresureLabel.fontSize = 30.0f;
        getTresureLabel.position = CGPointMake(_frameCenter.x, _frameCenter.y * 1.05f);
        getTresureLabel.fontColor = [SKColor greenColor];
        [self addChild:getTresureLabel];
        
        NSArray* getTresureBox = [_defaults stringArrayForKey:@"tresure_Array"];
        
        switch (getTresureBox.count) {
            case 0:{
                SKLabelNode* notTresureLabel = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
                notTresureLabel.text = [NSString stringWithFormat:@"NO"];
                notTresureLabel.fontSize = 30.0f;
                notTresureLabel.position = CGPointMake(_frameCenter.x, _frameCenter.y * 0.8f);
                notTresureLabel.fontColor = [SKColor greenColor];
                [self addChild:notTresureLabel];
            }break;
            
            case 1:{
                CGPoint pos_1 = CGPointMake(_frameCenter.x, _frameCenter.y * 0.75f);
                for (NSString* imageName in getTresureBox) {
                    tresureNode* tresure = [[tresureNode alloc] init:pos_1 imageName:imageName];
                    [self addChild:tresure];
                }
            }break;
                
            case 2:{
                int tresureCount = 0;
                CGPoint pos[2];
                pos[0] = CGPointMake(_frameCenter.x - 75, _frameCenter.y * 0.75f);
                pos[1] = CGPointMake(_frameCenter.x + 75, _frameCenter.y * 0.75f);
                for (NSString* imageName in getTresureBox) {
                    tresureNode* tresure = [[tresureNode alloc] init:pos[tresureCount] imageName:imageName];
                    [self addChild:tresure];
                    tresureCount++;
                }
            }break;
                
            case 3:{
                int tresureCount = 0;
                CGPoint pos[3];
                pos[0] = CGPointMake(_frameCenter.x * 0.4f, _frameCenter.y * 0.75f);
                pos[1] = CGPointMake(_frameCenter.x, _frameCenter.y * 0.75f);
                pos[2] = CGPointMake(_frameCenter.x * 1.6f, _frameCenter.y * 0.75f);
                for (NSString* imageName in getTresureBox) {
                    tresureNode* tresure = [[tresureNode alloc] init:pos[tresureCount] imageName:imageName];
                    [self addChild:tresure];
                    tresureCount++;
                }
            }break;
                
            case 4:{
                int tresureCount = 0;
                CGPoint pos[4];
                pos[0] = CGPointMake(_frameCenter.x * 0.4f, _frameCenter.y * 0.75f);
                pos[1] = CGPointMake(_frameCenter.x, _frameCenter.y * 0.75f);
                pos[2] = CGPointMake(_frameCenter.x * 1.6f, _frameCenter.y * 0.75f);
                pos[3] = CGPointMake(_frameCenter.x, _frameCenter.y * 0.35f);
                for (NSString* imageName in getTresureBox) {
                    tresureNode* tresure = [[tresureNode alloc] init:pos[tresureCount] imageName:imageName];
                    [self addChild:tresure];
                    tresureCount++;
                }
            }break;
                
            case 5:{
                int tresureCount = 0;
                CGPoint pos[5];
                pos[0] = CGPointMake(_frameCenter.x * 0.4f, _frameCenter.y * 0.75f);
                pos[1] = CGPointMake(_frameCenter.x, _frameCenter.y * 0.75f);
                pos[2] = CGPointMake(_frameCenter.x * 1.6f, _frameCenter.y * 0.75f);
                pos[3] = CGPointMake(_frameCenter.x - 75, _frameCenter.y * 0.35f);
                pos[4] = CGPointMake(_frameCenter.x + 75, _frameCenter.y * 0.35f);
                for (NSString* imageName in getTresureBox) {
                    tresureNode* tresure = [[tresureNode alloc] init:pos[tresureCount] imageName:imageName];
                    [self addChild:tresure];
                    tresureCount++;
                }
            }break;
                
            case 6:{
                int tresureCount = 0;
                CGPoint pos[6];
                pos[0] = CGPointMake(_frameCenter.x * 0.4f, _frameCenter.y * 0.75f);
                pos[1] = CGPointMake(_frameCenter.x, _frameCenter.y * 0.75f);
                pos[2] = CGPointMake(_frameCenter.x * 1.6f, _frameCenter.y * 0.75f);
                pos[3] = CGPointMake(_frameCenter.x * 0.4f, _frameCenter.y * 0.35f);
                pos[4] = CGPointMake(_frameCenter.x, _frameCenter.y * 0.35f);
                pos[5] = CGPointMake(_frameCenter.x * 1.6f, _frameCenter.y * 0.35f);
                for (NSString* imageName in getTresureBox) {
                    tresureNode* tresure = [[tresureNode alloc] init:pos[tresureCount] imageName:imageName];
                    [self addChild:tresure];
                    tresureCount++;
                }
            }break;
            default:
                break;
        }
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    
    _timeCount++;
    
    if (_timeCount == 100) {
        [self.view addSubview:_expBarProgress];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _touchCount++;
    if (_touchCount == 1) {
        if (_levelCount == 0 ) {
            _totalExp = _totalExp + _getExp;
            _nowBBAExp = _nowBBAExp + _getExp;
            [_defaults setDouble:_totalExp forKey:@"BBA_experience"];
        }
        float gettedExpProgess = (float)_nowBBAExp / (float)_needExp;
        
        if (gettedExpProgess >= 1) {
            gettedExpProgess = 1;
            
            if (_level >= 30) {
                _touchCount = 2;
                [_expBarProgress setProgress:gettedExpProgess animated:YES];
            } else {
                _level = _level + 1;
                self.view.userInteractionEnabled = NO;
                
                [_expBarProgress setProgress:gettedExpProgess animated:YES];
                [_defaults setInteger:_level forKey:@"BBA_level"];
                [_defaults setInteger:_level * 100 forKey:@"BBA_stamina"];
                
                SKSpriteNode* levelUPSprite = [SKSpriteNode spriteNodeWithImageNamed:@"levelup"];
                levelUPSprite.xScale = 0.5f;
                levelUPSprite.yScale = 0.5f;
                levelUPSprite.position = _frameCenter;
                levelUPSprite.alpha = 0.0f;
                
                SKAction* fadeIn = [SKAction fadeInWithDuration:1.0f];
                SKAction* scale = [SKAction scaleTo:1.0f duration:1.0f];
                SKAction* fadeOut = [SKAction fadeOutWithDuration:1.0f];
                SKAction* sel = [SKAction performSelector:@selector(nextLevelFrag) onTarget:self];
                fadeIn.timingMode = SKActionTimingEaseOut;
                
                SKAction* gp1 = [SKAction group:@[fadeIn, scale]];
                SKAction* gp2 = [SKAction group:@[fadeOut, sel]];
                [levelUPSprite runAction:[SKAction sequence:@[gp1, gp2]]];
                [self addChild:levelUPSprite];
            }
        } else {
            [_expBarProgress setProgress:gettedExpProgess animated:YES];
            [_defaults setInteger:_level forKey:@"BBA_level"];
        }
    } else {
        [colorBBAMainMyScene sharedManager].BBAHPBar = nil;
        [colorBBAMainMyScene sharedManager].enemyHPBar = nil;
        
        [[colorBBAMainMyScene sharedManager] removeAllChildren];
        [[colorBBAMainMyScene sharedManager] removeAllActions];
        [[colorBBAMainMyScene sharedManager] removeFromParent];

        self.view.window.rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
        
    
    }
    
}

- (void)nextLevelFrag {
    
    _levelCount = 1;
    int nowNeedsExp = [self nextLevel:_level];
    int oneAgoExp = 0;
    if (_level > 1) {
        oneAgoExp = [self nextLevel:_level - 1];
    }
    
    _expBarProgress.progress = 0;
    
    //BBAの今の合計所持経験値
    _totalExp = (int)[_defaults doubleForKey:@"BBA_experience"];
    
    //次に必要な経験値。
    _needExp = nowNeedsExp - oneAgoExp;
    
    //BBAの今の経験値。
    _nowBBAExp = _totalExp - oneAgoExp;
    
    _touchCount = 0;
    self.view.userInteractionEnabled = YES;
}

//次のレベル経験値＝（初期値×（１＋（１÷（１＋（現在レベル＋（１÷引数Ａ））×引数Ｂ）））＾（現在レベル－１））×現在レベル
- (int)nextLevel:(int)nowLevel {
    double exp_1 = nowLevel + (1 / ARGUMENT_A);                //（現在レベル＋（１÷引数Ａ）)     = exp_1
    double exp_2 = 1 + (exp_1 * ARGUMENT_B);                   //（１＋（exp_1）×引数Ｂ））      = exp_2
    double exp_3 = 1 + (1 / (exp_2));                          //（１＋（１÷exp_2））           = exp_3
    double exp_4 = nowLevel - 1;                               //（現在レベル－１）              = exp_4
    double exp_5 = pow(exp_3, exp_4);                          //exp_3＾（exp_4）              = exp_5
    int exp_6 = INITVALUE * exp_5 * nowLevel;                  //次のレベルの経験値
    return exp_6;
}

@end
