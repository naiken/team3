//
//  skillManager.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "skill.h"

@interface skillManager : NSObject

+ (int)getMemoryFrag:(int)skillId;

+ (NSString*)getSkillName:(int)skillId;

+ (NSString*)getSkillDescription:(int)skillId;

@end
