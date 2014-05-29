//
//  skillActiveBtn.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class skillActiveBtn;

@protocol skillActiveBtnDelegate

- (void)skillActiveAction:(skillActiveBtn*)saBtn;

@end


@interface skillActiveBtn : SKSpriteNode

@property (weak) id delegate;

- (id)init:(CGPoint)position;

@end
