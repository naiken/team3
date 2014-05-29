//
//  vegitableEnemy.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/08.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class vegitableEnemy;

@protocol vegitableEnemyDelegate <NSObject>

- (void)vegitableEnemyTouch:(vegitableEnemy*)ve;

@end

@interface vegitableEnemy : SKSpriteNode

@property (weak) id delegate;

//宝箱のキー
@property (nonatomic, assign) NSString* keyTreasure;

//他からゲット持っているか
@property (nonatomic) BOOL isTeasure;

//体力
@property (nonatomic) int stamina;

//経験値
@property (nonatomic) int experience;

//敵のタグ番号
@property (nonatomic) int enemyTag;

//初期化
- (id)init:(CGPoint)position enemyImageName:(NSString*)str;

- (void)setStamina:(int)stamina;

- (int)stamina;

@end
