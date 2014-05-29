//
//  attackBtn.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/08.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class attackBtn;

@protocol attackBtnDelegate

- (void)attackTouchBtn:(attackBtn*)atBtn;

@end

@interface attackBtn : SKSpriteNode

@property (weak) id delegate;

- (id)init:(CGPoint)position;

@end
