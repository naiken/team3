//
//  skill.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "skill.h"

#define ARC4RANDOM_MAX 0x100000000

@interface skill () {
    colorBBAMainMyScene* _cms;
    
    NSArray* _cba;
    NSArray* _cda;
    
    int _enemyStamina;
    int _BBAstamina;
    
    mainBBASprite* _mainBBA;
}

@end

@implementation skill

@synthesize skillId = _skillId;
@synthesize skillName = _skillName;
@synthesize skillDescription = _skillDescription;

- (id)init:(int)skillId {
    self = [super init];
    
    if (self) {
        self.skillId = skillId;
        self.skillName = [skillManager getSkillName:skillId];
        self.skillDescription = [skillManager getSkillDescription:skillId];
    }
    
    return self;
}

- (void)skillActive:(int)skillId colorBallArray:(NSArray *)colorBallArray colorDstArray:(NSArray *)colorDstArray BBAHitPoint:(int)bbaHP enemyHitPoint:(int)enemyHP BBAMaxhp:(int)MaxBBAhp enemyMaxhp:(int)enemyMaxhp BBAPos:(CGPoint)BBaPos enemyPos:(CGPoint)enemyPos{
    _cms = [colorBBAMainMyScene sharedManager];
    _cba = colorBallArray;
    _cda = colorDstArray;

    _enemyStamina = enemyHP;
    _BBAstamina = bbaHP;
    
    int random = arc4random() % 5;
    
    switch (skillId) {
        case 0:{
            //バラバラ
            [self colorBallRandom];
            [_cms runAction:_cms.attackEffect02];
        }break;
            
        case 1:{
            //いちょう切り
            _enemyStamina = _enemyStamina * 3/4;
            
            colorBall* enemyDamageEffect = [[colorBall alloc] initComposeEffect:enemyPos setColor:[SKColor redColor]];
            enemyDamageEffect.targetNode = _cms;
            [_cms addChild:enemyDamageEffect];
            [_cms runAction:_cms.attackEffect03];
        }break;
            
        case 2:{
            //唐辛子
            [self colorBallChange:random color:[SKColor redColor]];
            [_cms runAction:_cms.attackEffect02];
        }break;
            
        case 3:{
            //青汁
            [self colorBallChange:random color:[SKColor blueColor]];
            [_cms runAction:_cms.attackEffect02];
        }break;
            
        case 4:{
            //よもぎ
            [self colorBallChange:random color:[SKColor greenColor]];
            [_cms runAction:_cms.attackEffect02];
        }break;
            
        case 5:{
            //味見
            _BBAstamina = _BBAstamina + 1000;
            
            colorBall* recoverCB = [[colorBall alloc] initRecoverEffect:BBaPos setColor:[SKColor greenColor]];
            recoverCB.targetNode = _cms;
            [_cms addChild:recoverCB];
            [_cms runAction:_cms.attackEffect02];
            
            if (MaxBBAhp <= _BBAstamina) {
                _BBAstamina = MaxBBAhp;
            }
            
            
        }break;
            
        case 6:{
            //早よ寝〜や
            _enemyStamina = _enemyStamina - 4000;
            if (_enemyStamina <= 0) {
                _enemyStamina = 0;
            }
            
            
            colorBall* enemyDamageEffect = [[colorBall alloc] initComposeEffect:enemyPos setColor:[SKColor redColor]];
            enemyDamageEffect.numParticlesToEmit = 50;
            enemyDamageEffect.targetNode = _cms;
            [_cms addChild:enemyDamageEffect];
            [_cms runAction:_cms.attackEffect03];
            
        }break;
            
        case 7:{
            //茶をしばく
            _BBAstamina = _BBAstamina + 2000;
            
            colorBall* recoverCB = [[colorBall alloc] initRecoverEffect:BBaPos setColor:[SKColor greenColor]];
            recoverCB.targetNode = _cms;
            [_cms addChild:recoverCB];
            [_cms runAction:_cms.attackEffect02];
            
            if (MaxBBAhp <= _BBAstamina) {
                _BBAstamina = MaxBBAhp;
            }
            
        }break;
            
        case 8:{
            //白菜
            [self colorBallChange:random color:[SKColor whiteColor]];
            [_cms runAction:_cms.attackEffect02];
        }break;
            
        case 9:{
            //レモン汁
            [self colorBallChange:random color:[SKColor yellowColor]];
            [_cms runAction:_cms.attackEffect02];
        }break;
            
        case 10:{
            //みかん
            [self colorBallChange:random color:[SKColor orangeColor]];
            [_cms runAction:_cms.attackEffect02];
        }break;
            
        case 11:{
            //半月切り
            _enemyStamina = _enemyStamina * 1/2;
            
            colorBall* enemyDamageEffect = [[colorBall alloc] initComposeEffect:enemyPos setColor:[SKColor redColor]];
            enemyDamageEffect.numParticlesToEmit = 50;
            enemyDamageEffect.targetNode = _cms;
            [_cms addChild:enemyDamageEffect];
            [_cms runAction:_cms.attackEffect03];
            
        }break;
        default:
            break;
    }
    
    _cms.colorBallArray = _cba;
    _cms.colorDstArray = _cda;
    
    _cms.nowBBAhp = _BBAstamina;
    _cms.nowEnemyhp = _enemyStamina;
}

//バラバラやで
- (void)colorBallRandom {
    
    NSMutableArray* colorBallArray = @[].mutableCopy;
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
        
        colorBall* posCb = [_cba objectAtIndex:i];
        colorBall* cb = [[colorBall alloc] initMaterial:posCb.position setColor:dstColor];
        cb.targetNode = _cms;
        cb.name = [NSString stringWithFormat:@"%d", i];
        [_cms addChild:cb];
        
        colorBall* delCb = (colorBall*)[_cms.colorBallArray objectAtIndex:i];
        [delCb removeFromParent];
        
        colorBall* changeEffect = [[colorBall alloc] initComposeEffect:posCb.position setColor:dstColor];
        changeEffect.targetNode = _cms;
        [_cms addChild:changeEffect];
        
        [colorBallArray addObject:cb];
        [colorDst addObject:dstColor];
    }
    
    _cba = (NSArray*)colorBallArray;
    _cda = (NSArray*)colorDst;
    
}

//色球一個の変化
- (void)colorBallChange:(int)randomSelect color:(SKColor*)changeColor {
    NSMutableArray* mutableCBA = _cba.mutableCopy;
    NSMutableArray* mutableCDA = _cda.mutableCopy;
    colorBall* takeCB = (colorBall*)[_cba objectAtIndex:randomSelect];
    SKColor* colorCD = (SKColor*)[_cda objectAtIndex:randomSelect];
    colorCD = changeColor;
    colorBall* insertCB = [[colorBall alloc] initMaterial:takeCB.position setColor:colorCD];
    insertCB.targetNode = _cms;
    insertCB.name = [NSString stringWithFormat:@"%d", randomSelect];
    
    [mutableCBA removeObjectAtIndex:randomSelect];
    [mutableCDA removeObjectAtIndex:randomSelect];
    
    [mutableCBA insertObject:insertCB atIndex:randomSelect];
    [mutableCDA insertObject:colorCD atIndex:randomSelect];
    [_cms addChild:insertCB];
    
    colorBall* changeEffect = [[colorBall alloc] initComposeEffect:takeCB.position setColor:changeColor];
    changeEffect.targetNode = _cms;
    [_cms addChild:changeEffect];
    
    colorBall* delCb = (colorBall*)[_cms.colorBallArray objectAtIndex:randomSelect];
    [delCb removeFromParent];
    
    _cba = (NSArray*)mutableCBA;
    _cda = (NSArray*)mutableCDA;
}

@end
