//
//  mainBBASprite.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/08.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class mainBBASprite;

@protocol mainBBASpriteDelegate 

//タッチした際のデリゲートメソッド
- (void)touchMainBBA:(mainBBASprite*)BBA;

@end

@interface mainBBASprite : SKSpriteNode

//デリゲート
@property (weak) id delegate;

//体力
@property (nonatomic) int stamina;

//レベル
@property (nonatomic) int level;

//経験値
@property (nonatomic) int experience;

//BBAの種類タグ
@property (nonatomic) int BBATag;

- (id)init:(CGPoint)position;

- (void)setStamina:(int)stamina;

- (int)stamina;

@end
