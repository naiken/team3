//
//  monsterManager.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/17.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface monsterManager : NSObject

+ (int)getStamina:(int)monsterId;

+ (int)getAttackPower:(int)monsterId;

+ (int)getExperience:(int)monsterId;

+ (float)getGetTresure:(int)monsterId;

+ (NSString*)getMonsterName:(int)monsterId;

+ (NSString*)getImageName:(int)monsterId;

+ (NSString*)getDescription:(int)monsterId;
@end
