//
//  scoreMemory.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface scoreMemory : NSObject

//スコアを記憶する
- (void)scoreMemorise:(int)score;

//スコアを取得する
+ (NSNumber*)getScore:(int)number;

//スコアを初期記憶
- (void)memoryScore;

//メインゲーム画面でのスコアの初期持ち点。
- (void)initHavingScore;

//メインゲーム画面でのスコアの反映
- (void)nextGameReflection:(int)scorePoint;

//直近ゲームでのスコアを取得
+ (int)recentlyScore;

@end



