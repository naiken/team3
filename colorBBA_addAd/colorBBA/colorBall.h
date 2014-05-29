//
//  colorBall.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/05.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface colorBall : SKEmitterNode


- (id)initMaterial:(CGPoint)position setColor:(UIColor*)color;

- (id)initComposeBall:(CGPoint)position setColor:(UIColor*)color;

- (id)initComposeEffect:(CGPoint)position setColor:(UIColor *)color;

- (id)initRecoverEffect:(CGPoint)position setColor:(UIColor*)color;

@end
