//
//  colorBBAMainMyScene.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/09.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "colorBBAMainMyScene.h"

#define ARC4RANDOM_MAX 0x100000000

@interface colorBBAMainMyScene () {
    
    NSArray* _colorBallArray;
    NSArray* _colorBallBox;
    NSArray* _colorDstArray;
    NSArray* _monsterArray;
    NSArray* _skillChoiseArray;
    NSArray* _tresureArray;
    
    NSMutableArray* _tresureMutableArray;
    
    int _colorBallTouchCount;
    int _colorBallTouchTag;
    
    colorBall* _composeBall;
    SKColor* _composeColor;
    
    mainBBASprite* _BBASprite;
    vegitableEnemy* _enemy;
    attackBtn* _attackBtn;
    Monster* _monster;
    skill* _skill;
    skillActiveBtn* _skillActive;
    
    BOOL _isAttackBBA;
    BOOL _isAttackEnemy;
    BOOL _isDestroy;
    BOOL _isDead;
    BOOL _isSkillActive;
    
    SKColor* _enemyColor;
    
    CGPoint _frameCenter;
    
    UIPickerView* _skillPicker;
    
    int _monsterNumber;
    int _danjonGoTag;
    
    int _bbaHitPoint;
    float _nowBBAhp;
    
    int _enemyHitPoint;
    float _nowEnemyhp;
    int _bbaAttackPower;
    
    int _battleCount;
    int _experience;
    
    UIProgressView* _BBAHPbar;
    UIProgressView* _enemyHPbar;
    
    NSUserDefaults* _defaults;
    
    SKSpriteNode* _resultShiftNode;
    SKSpriteNode* _tresureGetSprite;
}


@end


@implementation colorBBAMainMyScene

@synthesize colorBallArray = _colorBallArray;
@synthesize colorDstArray = _colorDstArray;
@synthesize nowBBAhp = _nowBBAhp;
@synthesize nowEnemyhp = _nowEnemyhp;
@synthesize BBAHPBar = _BBAHPbar;
@synthesize enemyHPBar = _enemyHPbar;
@synthesize attackEffect01 = _attackEffect01;
@synthesize attackEffect02 = _attackEffect02;
@synthesize attackEffect03 = _attackEffect03;

static colorBBAMainMyScene* sharedColorBallMainMyScene;

+ (colorBBAMainMyScene*)sharedManager {
	@synchronized(self) {
		if (sharedColorBallMainMyScene == nil) {
			sharedColorBallMainMyScene = [[self alloc] init];
		}
	}
	return sharedColorBallMainMyScene;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
		if (sharedColorBallMainMyScene == nil) {
			sharedColorBallMainMyScene = [super allocWithZone:zone];
			return sharedColorBallMainMyScene;
		}
	}
	return sharedColorBallMainMyScene;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (float)nowBBAhp {
    return _nowBBAhp;
}

- (float)nowEnemyhp {
    return _nowEnemyhp;
}

- (void)setNowBBAhp:(float)nowBBAhp {
    _nowBBAhp = nowBBAhp;
}

- (void)setNowEnemyhp:(float)nowEnemyhp {
    _nowEnemyhp = nowEnemyhp;
}
- (void)setColorBallArray:(NSArray *)colorBallArray {
    _colorBallArray = colorBallArray;
}

- (void)setColorDstArray:(NSArray *)colorDstArray {
    _colorDstArray = colorDstArray;
}

- (NSArray*)colorBallArray {
    return _colorBallArray;
}

- (NSArray*)colorDstArray {
    return _colorDstArray;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //ここにシーン表示時したいことを書く。
        
        _isAttackBBA = NO;
        _isAttackEnemy = NO;
        _isDestroy = NO;
        _isDead = NO;
        _isSkillActive = NO;
        _monsterNumber = 0;
        _experience = 0;
        _tresureMutableArray = [NSMutableArray array];
        _colorBallTouchCount = NO;
        _colorBallTouchTag = NO;
        _nowEnemyhp = 0;
        _nowBBAhp = 0;
        _enemy = nil;
        _monster = nil;
        _attackEffect01 = [SKAction playSoundFileNamed:@"attack_1.caf" waitForCompletion:NO];
        _attackEffect02 = [SKAction playSoundFileNamed:@"attack_2.caf" waitForCompletion:NO];
        _attackEffect03 = [SKAction playSoundFileNamed:@"attack_3.caf" waitForCompletion:NO];
        
        //画面の真ん中
        _frameCenter = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        //背景
        SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"main_4inch"];
        bg.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        bg.position = _frameCenter;
        [self addChild:bg];
        
        _defaults = [NSUserDefaults standardUserDefaults];
        _danjonGoTag = (int)[_defaults integerForKey:@"danjon_go_id"];
        
        _battleCount = [danjonManager getMonsterCount:_danjonGoTag];
        
        [self setMonster:_danjonGoTag monsterNumber:_battleCount];
        
        [self monsterSet];
        
        [self BBAAppear];
        [self enemyAppear];
        
        [self getEnemyColor];
        [self colorBallAppear];
        
        
    
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //タッチされた際、呼ばれます。
    [_skillPicker removeFromSuperview];
    _skillPicker = nil;
    [_skillActive removeFromParent];
    _skillActive = nil;
}

-(void)update:(CFTimeInterval)currentTime {
    //FPS/1000s毎に呼ばれます。
    
    if (!_BBAHPbar) {
        _BBAHPbar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _BBAHPbar.progress = 1.0f;
        _BBAHPbar.progressTintColor = [UIColor greenColor];
        _BBAHPbar.trackTintColor = [UIColor blackColor];
        _BBAHPbar.frame = CGRectMake(_frameCenter.x * 0.7f, _frameCenter.y * 1.6f, 100, 20);
        _BBAHPbar.transform = CGAffineTransformMakeScale(1.0f, 2.0f);
        [self.view addSubview:_BBAHPbar];
    }
    
    if (!_enemyHPbar) {
        _enemyHPbar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _enemyHPbar.progress = 1.0f;
        _enemyHPbar.progressTintColor = [UIColor redColor];
        _enemyHPbar.trackTintColor = [UIColor whiteColor];
        _enemyHPbar.frame = CGRectMake(_frameCenter.x * 0.7f, _frameCenter.y * 0.3f, 100, 20);
        _enemyHPbar.transform = CGAffineTransformMakeScale(1.0f, 2.0f);
        [self.view addSubview:_enemyHPbar];
    }
    
    //BBAの攻撃した場合。分岐敵が死ぬ場合。死なない場合。
    if (_isAttackBBA) {
        _isAttackBBA = NO;
        if (_isDestroy) {
            _isDestroy = NO;
            _monsterNumber = _monsterNumber + 1;
            if (_monsterNumber == _battleCount) {
                _resultShiftNode = [SKSpriteNode spriteNodeWithImageNamed:@"clear"];
                _resultShiftNode.xScale = 0.5f;
                _resultShiftNode.yScale = 0.5f;
                _resultShiftNode.position = _frameCenter;
                _resultShiftNode.alpha = 0.0f;
                
                SKAction* fadeIn = [SKAction fadeInWithDuration:1.0f];
                SKAction* scale = [SKAction scaleTo:1.0f duration:1.0f];
                fadeIn.timingMode = SKActionTimingEaseOut;
                
                SKAction* gp = [SKAction group:@[fadeIn, scale]];
                SKAction* sel = [SKAction performSelector:@selector(resultTransition) onTarget:self];
                [_resultShiftNode runAction:[SKAction sequence:@[gp, sel]]];
                [self addChild:_resultShiftNode];
                _tresureArray = (NSArray*)_tresureMutableArray;
                
                [_defaults setObject:_tresureArray forKey:@"tresure_Array"];
                if (_danjonGoTag == 9) {
                    [_defaults setBool:YES forKey:[NSString stringWithFormat:@"is_danjon_clear_id%d",_danjonGoTag]];
                } else{
                    [_defaults setBool:YES forKey:[NSString stringWithFormat:@"is_danjon_clear_id%d",_danjonGoTag + 1]];
                }
                [_defaults setInteger:_experience forKey:@"experience_recenet_Battle"];
                int danjonStamina = [danjonManager getStamina:_danjonGoTag];
                
                [_defaults setInteger:danjonStamina forKey:@"used_stamina"];
                
            } else {
                _BBASprite.userInteractionEnabled = YES;
                _isSkillActive = NO;
                _composeColor = nil;
                SKAction* perform_1 = [SKAction performSelector:@selector(monsterSet) onTarget:self];
                SKAction* perform_2 = [SKAction performSelector:@selector(enemyAppear) onTarget:self];
                SKAction* perform_3 = [SKAction performSelector:@selector(getEnemyColor) onTarget:self];
                SKAction* perform_4 = [SKAction performSelector:@selector(colorBallAppear) onTarget:self];
                SKAction* run = [SKAction runBlock:^{
                    [_enemyHPbar removeFromSuperview];
                    _enemyHPbar = nil;
                    _BBAHPbar.hidden = NO;
                }];
                SKAction* wait = [SKAction waitForDuration:2.0f];
                
                [self runAction:[SKAction sequence:@[wait,run,perform_1,perform_2,perform_3,perform_4]]];
            }
        } else {
            [self enemyAttack];
        }
    }
    
    if (_isAttackEnemy) {
        _isAttackEnemy = NO;
        _BBASprite.userInteractionEnabled = YES;
        _isSkillActive = NO;
        [self colorBallAppear];
    }
    
    if (_isDead) {
        _isDead = NO;
        _BBASprite.userInteractionEnabled = NO;
        _resultShiftNode = [SKSpriteNode spriteNodeWithImageNamed:@"gameover"];
        _resultShiftNode.xScale = 0.5f;
        _resultShiftNode.yScale = 0.5f;
        _resultShiftNode.position = _frameCenter;
        _resultShiftNode.alpha = 0.0f;
        
        SKAction* fadeIn = [SKAction fadeInWithDuration:1.0f];
        SKAction* rotate1 = [SKAction rotateByAngle:-0.5f duration:1.0f];
        fadeIn.timingMode = SKActionTimingEaseOut;
        rotate1.timingMode = SKActionTimingEaseIn;
        
        SKAction* gp = [SKAction group:@[fadeIn, rotate1]];
        SKAction* sel = [SKAction performSelector:@selector(resultTransition) onTarget:self];
        [_resultShiftNode runAction:[SKAction sequence:@[gp, sel]]];
        [self addChild:_resultShiftNode];
        
        SKAction* rotate = [SKAction rotateToAngle:720 duration:1.0f];
        SKAction* fadeOut = [SKAction fadeOutWithDuration:1.0f];
        fadeOut.timingMode = SKActionTimingEaseOut;
        gp = [SKAction group:@[rotate,fadeOut]];
        [_BBASprite runAction:gp];
        _tresureArray = (NSArray*)_tresureMutableArray;
        
        [_defaults setObject:_tresureArray forKey:@"tresure_Array"];
        [_defaults setInteger:_experience forKey:@"experience_recenet_Battle"];
        
        int monsterNumber = _monsterNumber + 1;
        int danjonStamina = [danjonManager getStamina:_danjonGoTag];
        int usedStamina = (danjonStamina * monsterNumber) / _battleCount;
        [_defaults setInteger:usedStamina forKey:@"used_stamina"];
    }
    
    
}

- (void)setMonster:(int)danjonTag monsterNumber:(int)number{
    
    NSMutableArray* mutableMonsterArray = @[].mutableCopy;
    
    int monsterNumber;
    
    if (danjonTag < 5) {
        monsterNumber = danjonTag * number;
    } else {
        monsterNumber = 20 + (danjonTag - 5) * number;
    }
    
    for (int i = monsterNumber; i <= monsterNumber + number - 1; i++) {
        Monster* monster = [[Monster alloc] init:i];
        [mutableMonsterArray addObject:monster];
    }
    
    for (int i = 0; i < 50; i++) {
        int src = arc4random() % number;
        int dst = src;
        while (dst == src) {
            dst = arc4random() % number;
        }
        [mutableMonsterArray exchangeObjectAtIndex:src withObjectAtIndex:dst];
    }
    _monsterArray = (NSArray*)mutableMonsterArray;
}

- (void)monsterSet {
    _monster = (Monster*)[_monsterArray objectAtIndex:_monsterNumber];
    _enemyHitPoint = _monster.stamina;
}


- (void)BBAAppear {
    //BBA召還
    _BBASprite = [[mainBBASprite alloc] init:CGPointMake(_frameCenter.x, _frameCenter.y * 0.2f)];
    _BBASprite.delegate = self;
    [self addChild:_BBASprite];
    
    _bbaHitPoint = 100 * (int)[_defaults integerForKey:@"BBA_level"];
    _bbaAttackPower = 100 * (int)[_defaults integerForKey:@"BBA_level"];
}

- (void)enemyAppear {

    //敵召還
    
    _enemy = [[vegitableEnemy alloc] init:CGPointMake(_frameCenter.x, _frameCenter.y * 1.4f) enemyImageName:_monster.imageName];
    _enemy.delegate = self;
    _enemy.alpha = 0.0f;
    [self addChild:_enemy];
        
    SKAction* fadeIn = [SKAction fadeInWithDuration:1.5f];
    fadeIn.timingMode = SKActionTimingEaseIn;
    [_enemy runAction:fadeIn];
    
}

- (void)getEnemyColor {
    
    
    UIImage* image = [UIImage imageNamed:_monster.imageName];
    
    CGImageRef cgImage = image.CGImage;
    
    int x = image.size.width / 2;
    int y = image.size.height / 2;
    NSLog(@"%d %d", x, y);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    size_t bytePerRow = CGImageGetBytesPerRow(cgImage);
    
    UInt8* index = buffer + x * 4 + y * bytePerRow;
    
    float enemyR = (float)*(index + 0) / 255;
    float enemyG = (float)*(index + 1) / 255;
    float enemyB = (float)*(index + 2) / 255;
    float enemyA = 0.8f;
    
    NSLog(@"敵の色は%f %f %f %f", enemyR,enemyG,enemyB,enemyA);
    
    _enemyColor = [SKColor colorWithRed:enemyR green:enemyG blue:enemyB alpha:enemyA];
}

- (void)colorBallAppear {
    
    NSMutableArray* colorBallArray = @[].mutableCopy;
    NSMutableArray* colorBallBox = @[].mutableCopy;
    NSMutableArray* colorDst = @[].mutableCopy;
    
    for (int i = 0; i < 5; i++) {
        float randomR = ((float)arc4random() / ARC4RANDOM_MAX) - 0.1f;
        float randomG = ((float)arc4random() / ARC4RANDOM_MAX) - 0.1f;
        float randomB = ((float)arc4random() / ARC4RANDOM_MAX) - 0.1f;
        float randomA = ((float)arc4random() / ARC4RANDOM_MAX) + 0.3f;
        
        if (i == 0) {
            randomR = randomR + 0.8f;
            randomG = randomG - 0.3f;
            randomB = randomB - 0.3f;
        }
        
        if (i == 2) {
            randomR = randomR - 0.3f;
            randomG = randomG + 0.8f;
            randomB = randomB - 0.3f;
        }
        
        if (i == 4) {
            randomR = randomR - 0.3f;
            randomG = randomG - 0.3f;
            randomB = randomB + 0.8f;
        }
        if (randomR <= 0.0) randomR = 0.0f;
        if (randomR >= 1.0) randomR = 1.0f;
        if (randomG <= 0.0) randomG = 0.0f;
        if (randomG >= 1.0) randomG = 1.0f;
        if (randomB <= 0.0) randomB = 0.0f;
        if (randomB >= 1.0) randomB = 1.0f;
        if (randomA <= 0.0) randomA = 0.0f;
        if (randomA >= 1.0) randomA = 1.0f;
        
        NSLog(@"%f %f %f %f", randomR,randomG,randomB,randomA);
        
        SKColor* dstColor = [SKColor colorWithRed:randomR green:randomG blue:randomB alpha:randomA];
        
        colorBall* cb = [[colorBall alloc] initMaterial:CGPointMake(CGRectGetMaxX(self.frame) * (0.1f + (i * 0.2f)), _frameCenter.y * 0.7f) setColor:dstColor];
        cb.targetNode = self.scene;
        [self addChild:cb];
                                                                   
        CGRect r = CGRectMake(CGRectGetMaxX(self.frame) * (0.1f + (i * 0.2f)), _frameCenter.y * 0.7f, 40, 40);
        touchSprite* ts = [[touchSprite alloc] init:r];
        ts.delegate = self;
        [self addChild:ts];
        
        cb.name = [NSString stringWithFormat:@"%d", i];
        ts.name = [NSString stringWithFormat:@"%d", i];
        
        [colorBallArray addObject:cb];
        [colorBallBox addObject:ts];
        [colorDst addObject:dstColor];
    }
    
    _colorBallArray = (NSArray*)colorBallArray;
    _colorBallBox = (NSArray*)colorBallBox;
    _colorDstArray = (NSArray*)colorDst;
    
}



- (void)touchColorBall:(touchSprite *)ts {
    
    [_skillPicker removeFromSuperview];
    _skillPicker = nil;
    [_skillActive removeFromParent];
    _skillActive = nil;
    
    if (_attackBtn.hidden) {
        _attackBtn.hidden = !_attackBtn.hidden;
    }
    
    _BBAHPbar.hidden = NO;
    
    _colorBallTouchCount++;
    
    _colorBallTouchTag = [ts.name intValue];
    
    [ts removeFromParent];
    
    if (_colorBallTouchCount == 2) {
        for (touchSprite* TS in _colorBallBox) {
            if (TS) {
                [TS removeFromParent];
            }
        }
        
        if (_attackBtn) {
            
            [_attackBtn removeFromParent];
            _attackBtn = nil;
        }
    }
    colorBall* cb = [_colorBallArray objectAtIndex:_colorBallTouchTag];
    
    SKAction* composePosition = [SKAction moveTo:_frameCenter duration:0.3f];
    SKAction* compose = [SKAction performSelector:@selector(composeBall) onTarget:self];
    SKAction* wait = [SKAction waitForDuration:1.2f];
    SKAction* delete = [SKAction runBlock:^{
        [cb removeFromParent];
        if (_colorBallTouchCount == 2) {
            
            for (colorBall* CB in _colorBallArray) {
                if (CB) {
                    [CB removeFromParent];
                }
            }
            if (_attackBtn) {
                [_attackBtn removeFromParent];
                _attackBtn = nil;
            }
            [self BBAAttack];
        }
    }];
    
    SKAction* gp = [SKAction group:@[composePosition,compose]];
    
    [cb runAction:[SKAction sequence:@[gp,wait,delete]]];
    
}

- (void)skillActiveAction:(skillActiveBtn *)saBtn {
    
    if (!_nowEnemyhp) {
        _nowEnemyhp = _enemyHitPoint;
    }
    
    if (!_nowBBAhp) {
        _nowBBAhp = _bbaHitPoint;
    }
    
    if ([_skillChoiseArray  isEqual: @[]]) {
        
    } else{
        //スキルの名前取得
        skill* skill = [_skillChoiseArray objectAtIndex:(int)[_skillPicker selectedRowInComponent:0]];

        if (_skillPicker) {
            [_skillPicker removeFromSuperview];
            _skillPicker = nil;
            [_skillActive removeFromParent];
            _skillActive = nil;
        }
        
        [skill skillActive:skill.skillId colorBallArray:_colorBallArray colorDstArray:_colorDstArray BBAHitPoint:_nowBBAhp enemyHitPoint:_nowEnemyhp BBAMaxhp:_bbaHitPoint enemyMaxhp:_enemyHitPoint BBAPos:_BBASprite.position enemyPos:_enemy.position];

        _isSkillActive = YES;
        _BBASprite.userInteractionEnabled = NO;

        float progressBBAValue = _nowBBAhp / (float)_bbaHitPoint;
        float progressEnemyValue = _nowEnemyhp / (float)_enemyHitPoint;
        
        [_BBAHPbar setProgress:progressBBAValue animated:YES];
        [_enemyHPbar setProgress:progressEnemyValue animated:YES];
        
        if (_nowEnemyhp <= 0) {
            
            [_attackBtn removeFromParent];
            _attackBtn = nil;
            
            for (colorBall* CB in _colorBallArray) {
                if (CB) {
                    [CB removeFromParent];
                }
            }
            
            for (touchSprite* TS in _colorBallBox) {
                if (TS) {
                    [TS removeFromParent];
                }
            }

            _colorBallTouchCount = 0;
            _colorBallTouchTag = 0;
            
            _isAttackBBA = YES;
            
            [self enemyDestroy];
            
        
        }
    }
}

- (void)touchMainBBA:(mainBBASprite *)BBA {
    
    
    if (!_attackBtn){
        if (!_skillPicker) {
        
            _skillActive = [[skillActiveBtn alloc] init:CGPointMake(_frameCenter.x * 0.3f, _frameCenter.y * 0.2f)];
            _skillActive.delegate = self;
            [self addChild:_skillActive];
        
            _skillChoiseArray = [self skillArray];
            if (_skillChoiseArray) {
                _skillPicker = [[UIPickerView alloc] init];
                // delegate,dataSource設定
                _skillPicker.delegate = self;
                _skillPicker.dataSource = self;
                _skillPicker.backgroundColor = [UIColor blackColor];
                _skillPicker.alpha = 0.7f;
                // 選択状態のインジケーターを表示（デフォルト：NO）
                _skillPicker.showsSelectionIndicator = YES;
                // コンポーネント0の指定行を選択状態にする（初期選択状態の設定）
                [_skillPicker selectRow:7 inComponent:0 animated:NO];
        
                _skillPicker.frame = CGRectMake(_frameCenter.x - 100, _frameCenter.y - 162/2, 200, 162);
                //                  _skillPicker.frame = CGRectMake(_frameCenter.x * 1.2f, _frameCenter.y * 1.5, 120, 162);
                [self.view addSubview:_skillPicker];
            }
        }
    } else if (_attackBtn.hidden) {
        
        _skillActive = [[skillActiveBtn alloc] init:CGPointMake(_frameCenter.x * 0.3f, _frameCenter.y * 0.2f)];
        _skillActive.delegate = self;
        [self addChild:_skillActive];
        
        _skillChoiseArray = [self skillArray];
        if (_skillChoiseArray) {
        
            _skillPicker = [[UIPickerView alloc] init];
            // delegate,dataSource設定
            _skillPicker.delegate = self;
            _skillPicker.dataSource = self;
            _skillPicker.backgroundColor = [UIColor blackColor];
            _skillPicker.alpha = 0.7f;
            
            // 選択状態のインジケーターを表示（デフォルト：NO）
            _skillPicker.showsSelectionIndicator = YES;
            // コンポーネント0の指定行を選択状態にする（初期選択状態の設定）
            [_skillPicker selectRow:7 inComponent:0 animated:NO];
        
            _skillPicker.frame = CGRectMake(_frameCenter.x - 100, _frameCenter.y - 162/2, 200, 162);
            //_skillPicker.frame = CGRectMake(_frameCenter.x * 1.2f, _frameCenter.y * 1.5, 120, 162);
            [self.view addSubview:_skillPicker];
        }
    }
}

- (void)attackTouchBtn:(attackBtn *)atBtn {
    
    [_attackBtn removeFromParent];
    _attackBtn = nil;
    
    for (colorBall* CB in _colorBallArray) {
        if (CB) {
            [CB removeFromParent];
        }
    }
    
    for (touchSprite* TS in _colorBallBox) {
        if (TS) {
            [TS removeFromParent];
        }
    }
    
    [self BBAAttack];
}

- (void)composeBall {
    
    CGFloat dstR, dstG, dstB, dstA;
    CGFloat srcR, srcG, srcB, srcA;
    CGFloat resR, resG, resB, resA;
    
    SKColor* dstColor = [_colorDstArray objectAtIndex:_colorBallTouchTag];
    
    colorGet* cg = [[colorGet alloc] init];
    
    [cg getRGBA:dstColor red:&dstR green:&dstG blue:&dstB alpha:&dstA];
    
    if (dstA == 0.0f) {
        dstB = 1.0f;
        dstA = 0.8f;
    }
    
    if (_composeBall) {
        [_composeBall removeFromParent];
    }
    
    resA = dstA;
    resR = dstR;
    resG = dstG;
    resB = dstB;
    
    if (_colorBallTouchCount > 1) {
        if (_composeColor) {
            
            [cg getRGBA:_composeColor red:&srcR green:&srcG blue:&srcB alpha:&srcA];
            
            srcA = 0.6f;
            dstA = 0.7f;
            
            resA = srcA + (1 - srcA) * dstA;
            resR = ((srcR * srcA) + (dstR * (1 - srcA) * dstA)) / resA;
            resG = ((srcG * srcA) + (dstG * (1 - srcA) * dstA)) / resA;
            resB = ((srcB * srcA) + (dstB * (1 - srcA) * dstA)) / resA;
            
            resA = 0.8f;
        }
    }
    
    _composeColor = [SKColor colorWithRed:resR green:resG blue:resB alpha:resA];
    NSLog(@"合体球の色は%f,%f,%f,%f",resR,resG,resB,resA);
    
    _composeBall = [[colorBall alloc] initComposeBall:_frameCenter setColor:_composeColor];
    _composeBall.targetNode = self;
    
    [self addChild:_composeBall];
    
    colorBall* composeEffect = [[colorBall alloc] initComposeEffect:_frameCenter setColor:_composeColor];
    composeEffect.targetNode = self;
    
    [self addChild:composeEffect];
    
    if (_skillPicker) {
        [_skillPicker removeFromSuperview];
        _skillPicker = nil;
        [_skillActive removeFromParent];
        _skillActive = nil;
    }
    
    if (!_attackBtn) {
        _attackBtn = [[attackBtn alloc] init:CGPointMake(_frameCenter.x * 0.3f, _frameCenter.y * 0.2f)];
        [self addChild:_attackBtn];
        _attackBtn.delegate = self;
    } else {
        _attackBtn.hidden = NO;
        _attackBtn.userInteractionEnabled = YES;
    }
}

- (void)BBAAttack {
    
    _BBASprite.userInteractionEnabled = NO;
    _colorBallTouchCount = 0;
    _colorBallTouchTag = 0;
    
    _BBAHPbar.hidden = YES;
    SKAction* moveTo = [SKAction moveToY:_frameCenter.y * 0.7f duration:0.5f];
    moveTo.timingMode = SKActionTimingEaseOut;
    SKAction* wait = [SKAction waitForDuration:0.1f];
    SKAction* back = [SKAction moveToY:_frameCenter.y * 0.4f duration:0.3f];
    SKAction* attack = [SKAction moveToY:_frameCenter.y * 0.8f duration:0.1f];
    SKAction* backPos = [SKAction moveToY:_frameCenter.y * 0.2f duration:1.0f];
    SKAction* attackEffect = [SKAction performSelector:@selector(attackEffect) onTarget:self];
    
    SKAction* gp = [SKAction group:@[backPos,attackEffect]];
    SKAction* seq = [SKAction sequence:@[moveTo,wait,back,attack,gp]];
    
    [_BBASprite runAction:seq];
}

- (void)attackEffect {
    SKAction* moveTo = [SKAction moveToY:_enemy.position.y duration:0.3f];
    SKAction* run = [SKAction runBlock:^{
        colorBall* attackE = [[colorBall alloc] initComposeEffect:_enemy.position setColor:_composeColor];
        attackE.numParticlesToEmit = 50;
        attackE.targetNode = self.scene;
        [self addChild:attackE];
        [self quake:_enemy];
        [self runAction:_attackEffect03];
        [self enemyDamage];
        _isAttackBBA = YES;
        [_composeBall removeFromParent];
    }];

    [_composeBall runAction:[SKAction sequence:@[moveTo, run]]];
    
    
}

- (void)enemyAttack {
    
    colorBall* enemyCB = [[colorBall alloc] initMaterial:CGPointMake(_frameCenter.x, _frameCenter.y * 1.6f) setColor:_enemyColor];
    enemyCB.targetNode = self.scene;
    
    [self addChild:enemyCB];
    
    SKAction* wait = [SKAction waitForDuration:1.5f];
    SKAction* moveTo = [SKAction moveTo:CGPointMake(_frameCenter.x, _frameCenter.y * 0.2f) duration:1.0f];
    moveTo.timingMode = SKActionTimingEaseIn;
    SKAction* enemyATe = [SKAction runBlock:^{
        _BBAHPbar.hidden = NO;
        colorBall* enemyEffect = [[colorBall alloc] initComposeEffect:CGPointMake(_frameCenter.x, _frameCenter.y * 0.2f) setColor:_enemyColor];
        enemyEffect.numParticlesToEmit = 50;
        enemyEffect.targetNode = self.scene;
        [enemyCB removeFromParent];
        [self quake:_BBASprite];
        [self runAction:_attackEffect01];
        [self BBADamage];
        [self addChild:enemyEffect];
        _isAttackEnemy = YES;
    }];
    
    [enemyCB runAction:[SKAction sequence:@[wait, moveTo, enemyATe]]];
    
}

- (void)BBADamage {
    
    if (!_nowBBAhp) {
        _nowBBAhp = _bbaHitPoint;
    }
    _nowBBAhp = _nowBBAhp - _monster.attackPower;
    if (_nowBBAhp <= 0) {
        _nowBBAhp = 0;
        _BBASprite.userInteractionEnabled = NO;
        _isDead = YES;
    }
    
    float progressValue = _nowBBAhp / _bbaHitPoint;
    
    [_BBAHPbar setProgress:progressValue animated:YES];
}

- (void)enemyDamage {
    float enemyR, enemyG, enemyB, enemyA;
    float bbaR, bbaG, bbaB, bbaA;
    float disR, disG, disB;
    
    int realBBAPower;
    
    colorGet* cg = [[colorGet alloc] init];
    
    [cg getRGBA:_enemyColor red:&enemyR green:&enemyG blue:&enemyB alpha:&enemyA];
    [cg getRGBA:_composeColor red:&bbaR green:&bbaG blue:&bbaB alpha:&bbaA];
    
    disR = enemyR * 255 - bbaR * 255;
    disG = enemyG * 255 - bbaG * 255;
    disB = enemyB * 255 - bbaB * 255;
    
    NSLog(@"敵に攻撃する時の敵の色は%f %f %f %f", enemyR,enemyG,enemyB,enemyA);
    NSLog(@"敵に攻撃する時の合体球の色は%f,%f,%f,%f",bbaR,bbaG,bbaB,bbaA);
    float distance = sqrtf(powf(disR, 2) + powf(disG, 2) + powf(disB, 2));
    NSLog(@"それぞれの遠さは%f %f %f %f",disR,disG,disB,distance);
    
    if (distance <= 80) {
        realBBAPower = _bbaAttackPower * 1.4f;
    } else if (distance > 80 && distance <= 150) {
        realBBAPower = _bbaAttackPower * 1.2f;
    } else if (distance > 150 && distance <= 180) {
        realBBAPower = _bbaAttackPower * 1.0f;
    } else if (distance > 200 && distance <= 230) {
        realBBAPower = _bbaAttackPower * 0.8f;
    } else {
        realBBAPower = _bbaAttackPower * 0.6f;
    }
    
    if (!_nowEnemyhp) {
        _nowEnemyhp = _enemyHitPoint;
    }
    
    _nowEnemyhp = _nowEnemyhp - realBBAPower;
    
    if (_nowEnemyhp <= 0) {
        [self enemyDestroy];
    }
    
    float progressValue = _nowEnemyhp / _enemyHitPoint;
    
    [_enemyHPbar setProgress:progressValue animated:YES];
}
- (void)quake:(SKSpriteNode*)node {
    // 当たった場合は画面を揺らせる
    SKAction* move1 = [SKAction moveByX:-3 y:0 duration:0.1f];
    SKAction* move2 = [SKAction moveByX:6 y:-2 duration:0.1f];
    SKAction* move3 = [SKAction moveByX:-3 y:2 duration:0.1f];
    SKAction* seq = [SKAction sequence:@[move1,move2,move3]];
    [node runAction:seq];
}

- (void)enemyDestroy {
    _nowEnemyhp = 0;
    _experience += _monster.experience;
    _isDestroy = YES;
    NSLog(@"経験値%d", _experience);
    int random = arc4random() % 100 + 1;
    int getTresure = _monster.getTresure * 100;
    
    if (random <= getTresure) {
        
        BOOL isGet = YES;
        [_defaults setBool:isGet forKey:[NSString stringWithFormat:@"is_Tresure_get_id%d",_monster.monsterId]];
        NSLog(@"%d", [_defaults boolForKey:[NSString stringWithFormat:@"is_Tresure_get_id%d",_monster.monsterId]]);
        
        if (!_tresureMutableArray) {
            _tresureMutableArray = @[].mutableCopy;
        }
        [_tresureMutableArray addObject:_monster.imageName];
        
        _tresureGetSprite = [SKSpriteNode spriteNodeWithImageNamed:@"item_main_coin_small"];
        _tresureGetSprite.xScale = 0.1f;
        _tresureGetSprite.yScale = 0.1f;
        SKAction* scaleTo = [SKAction scaleTo:0.5f duration:1.0f];
        scaleTo.timingMode = SKActionTimingEaseOut;
        SKAction* moveBy = [SKAction moveByX:50 y:50 duration:1.0f];
        SKAction* rotate = [SKAction rotateByAngle:360 duration:1.0f];
        SKAction* fadeOut = [SKAction fadeOutWithDuration:1.0f];
        SKAction* run = [SKAction runBlock:^{
            [_tresureGetSprite removeFromParent];
            _tresureGetSprite = nil;
        }];
        _tresureGetSprite.position = _enemy.position;
        SKAction* gp1 = [SKAction group:@[scaleTo,moveBy]];
        SKAction* gp2 = [SKAction group:@[rotate,fadeOut]];
        SKAction* seq = [SKAction sequence:@[gp1,gp2,run]];
        
        [_tresureGetSprite runAction:seq];
        
        [self addChild:_tresureGetSprite];
    }
    //モンスターを倒すアニメーション
    SKAction* rotate = [SKAction rotateToAngle:720 duration:1.0f];
    SKAction* fadeOut = [SKAction fadeOutWithDuration:1.0f];
    fadeOut.timingMode = SKActionTimingEaseOut;
    SKAction* gp = [SKAction group:@[rotate,fadeOut]];
    [_enemy runAction:gp];
    
}

- (NSArray*)skillArray {
    
    NSArray* skillArray = [NSArray array];
    NSMutableArray* mutableSkillArray = @[].mutableCopy;
    for (int i = 0; i < 12; i++) {
        BOOL isSkillMemory = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_memory_id%d",i]];
        if (isSkillMemory) {
            _skill = [[skill alloc] init:i];
            [mutableSkillArray addObject:_skill];
        }
    }
    skillArray = (NSArray*)mutableSkillArray;
    return skillArray;
}


- (void)resultTransition {
    
    
    SKAction* gameOverAction = [SKAction runBlock:^{
        SKTransition *reveal = [SKTransition fadeWithDuration:2.0f];
        SKScene * gameOverScene = [[colorBBAMainResultScene alloc] initWithSize:self.size];
        [_BBAHPbar removeFromSuperview];
        [_enemyHPbar removeFromSuperview];
        [self.view presentScene:gameOverScene transition: reveal];
    }];
    
    [self runAction:gameOverAction];
}

#pragma mark - UIPickerViewDataSource

// コンポーネント数（列数）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [_skillChoiseArray count];
}

#pragma mark - UIPickerViewDelegate


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    skill* skill = [_skillChoiseArray objectAtIndex:row];
    
    UILabel* pickerLabel = [[UILabel alloc] init];
    pickerLabel.text = skill.skillName;
    pickerLabel.textColor = [UIColor whiteColor];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    
    return pickerLabel;
}

// 選択時（くるくる回して止まった時に呼ばれる）
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"selected: %@", [_skillChoiseArray objectAtIndex:row]);
}

@end
