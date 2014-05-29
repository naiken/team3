//
//  touchSprite.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/06.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class touchSprite;

@protocol touchSpriteDelegate

- (void)touchColorBall:(touchSprite*)ts;

@end

@interface touchSprite : SKSpriteNode

@property (weak) id delegate;

- (id)init:(CGRect)setFrame;


@end
