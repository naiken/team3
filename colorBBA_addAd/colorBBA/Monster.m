//
//  Monster.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/18.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "Monster.h"

@implementation Monster
@synthesize monsterId = _monsterId;
@synthesize stamina = _stamina;
@synthesize attackPower = _attackPower;
@synthesize experience = _experience;
@synthesize getTresure = _getTresure;
@synthesize isTresure = _isTresure;
@synthesize monsterName = _monsterName;
@synthesize imageName = _imageName;

- (id)init:(int)monsterId {
    self = [super init];
    if (self) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        
        self.monsterId = monsterId;
        self.stamina = [monsterManager getStamina:monsterId];
        self.attackPower = [monsterManager getAttackPower:monsterId];
        self.experience = [monsterManager getExperience:monsterId];
        self.getTresure = [monsterManager getGetTresure:monsterId];
        self.isTresure = [defaults boolForKey:[NSString stringWithFormat:@"is_Tresure_get_id%d",monsterId]];
        self.monsterName = [monsterManager getMonsterName:monsterId];
        self.imageName = [monsterManager getImageName:monsterId];
    }
    
    return self;
}

@end
