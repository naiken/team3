//
//  danjonManager.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/17.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface danjonManager : NSObject

+ (NSString*)getDanjonName:(int)danjonId;

+ (int)getStamina:(int)danjonId;

+ (int)getMonsterCount:(int)danjonId;

@end
