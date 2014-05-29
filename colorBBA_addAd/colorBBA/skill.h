//
//  skill.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "skillManager.h"
#import "colorBall.h"
#import "colorBBAMainMyScene.h"
#import "mainBBASprite.h"
#import "Monster.h"

@interface skill : NSObject {
}

@property (nonatomic) int skillId;

@property (nonatomic, assign) NSString* skillName;

@property (nonatomic, assign) NSString* skillDescription;

- (void)skillActive:(int)skillId colorBallArray:(NSArray*)colorBallArray colorDstArray:(NSArray*)colorDstArray BBAHitPoint:(int)bbaHP enemyHitPoint:(int)enemyHitPoint BBAMaxhp:(int)MaxBBAhp enemyMaxhp:(int)enemyMaxhp BBAPos:(CGPoint)BBaPos enemyPos:(CGPoint)enemyPos;

- (id)init:(int)skillId;

@end
