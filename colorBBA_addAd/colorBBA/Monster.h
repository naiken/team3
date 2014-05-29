//
//  Monster.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/18.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "monsterManager.h"

@interface Monster : NSObject

@property (nonatomic) int monsterId;

@property (nonatomic) int stamina;

@property (nonatomic) int attackPower;

@property (nonatomic) int experience;

@property (nonatomic) float getTresure;

@property (nonatomic) BOOL isTresure;

@property (nonatomic,assign) NSString* monsterName;

@property (nonatomic,assign) NSString* imageName;

-(id)init:(int)monsterId;

@end
