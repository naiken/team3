//
//  skillDetailBtn.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class skillDetailBtn;

@protocol skillDetailBtnDelegate

- (void)skillDetailBtn:(skillDetailBtn*)sdBtn;

@end

@interface skillDetailBtn : SKSpriteNode

@property (weak) id delegate;

- (id)initPos:(CGPoint)position;

@end
