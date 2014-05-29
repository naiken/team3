//
//  resultBtn.h
//  FutonBBA
//
//  Created by Doi Daihei on 2014/05/16.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class resultBtn;

@protocol resultBtnDelegate

- (void)resultBtn:(resultBtn*)rb;

@end

@interface resultBtn : SKSpriteNode

@property (weak) id delegate;

@end
