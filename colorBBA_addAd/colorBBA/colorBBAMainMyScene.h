//
//  colorBBAMainMyScene.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/09.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "attackBtn.h"
#import "vegitableEnemy.h"
#import "colorBall.h"
#import "touchSprite.h"
#import "colorGet.h"
#import "mainBBASprite.h"
#import "skillActiveBtn.h"
#import "danjonSelectViewController.h"
#import "Monster.h"
#import "colorBBAMainResultScene.h"
#import "skillManager.h"

@interface colorBBAMainMyScene : SKScene <attackBtnDelegate, vegitableEnemyDelegate, touchSpriteDelegate,mainBBASpriteDelegate,UIPickerViewDelegate,UIPickerViewDataSource, skillActiveBtnDelegate>

@property (nonatomic, strong)NSArray* colorBallArray;
@property (nonatomic, strong)NSArray* colorDstArray;
@property (nonatomic, strong)UIProgressView* BBAHPBar;
@property (nonatomic, strong)UIProgressView* enemyHPBar;
@property (nonatomic) float nowBBAhp;
@property (nonatomic) float nowEnemyhp;
@property (nonatomic, strong)SKAction* attackEffect01;
@property (nonatomic, strong)SKAction* attackEffect02;
@property (nonatomic, strong)SKAction* attackEffect03;

+ (colorBBAMainMyScene*)sharedManager;

+ (id)allocWithZone:(struct _NSZone *)zone;

- (id)copyWithZone:(NSZone *)zone;

- (void)setColorBallArray:(NSArray *)colorBallArray;

- (void)setColorDstArray:(NSArray *)colorDstArray;

- (NSArray*)colorBallArray;

- (NSArray*)colorDstArray;

- (float)nowBBAhp;

- (float)nowEnemyhp;

- (void)setNowBBAhp:(float)nowBBAhp;

- (void)setNowEnemyhp:(float)nowEnemyhp;


@end
