//
//  growBBASprite.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class growBBASprite;

@protocol growBBASpriteDelegate

- (void)growBBASpriteTouched:(growBBASprite*)BBA;

@end

@interface growBBASprite : SKSpriteNode

@property (weak) id delegate;

- (id)initPos:(CGPoint)pos;

+ (SKAction*)moveTo:(float)random;

@end
