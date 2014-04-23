//
//  scoreMemory.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "scoreMemory.h"

#define HAVING_SCORE 1000

@implementation scoreMemory

static NSString* const HAMBURG_SCORE_KEY = @"score_Array_hamburg";
static NSString* const HAVING_SCORE_KEY = @"reccent_score";

//直近スコアとベスト5を取得して合わしてソートをかけて再記憶。
- (void)scoreMemorise:(int)score {
    
    //ユーザーデフォルトを取得する。
    NSUserDefaults* defaluts = [NSUserDefaults standardUserDefaults];
    
    //スコアキーの取得
    NSString* scoreStr = [NSString stringWithFormat:HAMBURG_SCORE_KEY];
    
    //記憶してあるスコアの取得。
    NSArray* scoreArray = [defaluts arrayForKey:scoreStr];
    
    if (scoreArray) {
        
        //ソートするため可変出来る配列の用意。加えて直近スコア以外を格納。
        NSMutableArray* changeScore = [scoreArray mutableCopy];
        
        //直近スコアを最後尾に追加。
        [changeScore addObject:[NSNumber numberWithInt:score]];
        
        //可変配列にソート(降順)を掛け、固定配列に格納。
        NSArray* sortedArray = [changeScore sortedArrayUsingComparator:^NSComparisonResult(NSNumber* a, NSNumber* b){
            return b.intValue - a.intValue;
        }];
        
        //もう一度、可変配列に格納し6位のスコアを削除。
        changeScore = [sortedArray mutableCopy];
        [changeScore removeLastObject];
        
        //可変配列を固定配列にキャストする。
        NSArray* memorizeScore = (NSArray*)changeScore;
        
        //ユーザーデフォルトを用いて記憶。
        [defaluts setObject:memorizeScore forKey:scoreStr];
        
        //下記の行動を行うと即時？に記憶を行う。
        BOOL success = [defaluts synchronize];
        if (success) {
            NSLog(@"%@",@"データの保存に成功しました");
        }
        
    } else {//初回記憶時だけこちらのコードを行うが、スタート画面で初期記憶を行うため意味が無い。
        
        NSArray* defaultDic = @[@0,@0,@0,@0,@0];
        [defaluts setObject:defaultDic forKey:scoreStr];
        
        NSMutableArray* changeScore = (NSMutableArray*)defaultDic;
        [changeScore addObject:[NSNumber numberWithInt:score]];
        
        NSArray* sortedArray = [changeScore sortedArrayUsingComparator:^NSComparisonResult(NSNumber* a, NSNumber* b){
            return b.intValue - a.intValue;
        }];
        
        changeScore = [sortedArray mutableCopy];
        [changeScore removeLastObject];
        NSArray* memorizeScore = (NSArray*)changeScore;
        
        [defaluts setObject:memorizeScore forKey:scoreStr];
        
        BOOL success = [defaluts synchronize];
        if (success) {
            NSLog(@"%@",@"初回のデータの保存に成功しました");
        }
    }
    
}

//各順位のスコアを取得。
+ (NSNumber*)getScore:(int)number {
    
    //ユーザーデフォルト取得。
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //キー名格納
    NSString* scoreStr = [NSString stringWithFormat:HAMBURG_SCORE_KEY];
    
    //スコアが存在するか取得、無い場合0、ある場合スコアの配列を取得
    NSArray* scoreArray = [defaults arrayForKey:scoreStr];
    
    //戻り値であるNSNumber型の変数を用意。
    NSNumber* getScore;
    if (scoreArray) {
        
        //配列から引数のindexのスコアをgetScoreに格納。
        getScore = [scoreArray objectAtIndex:number];
        NSLog(@"%d位のスコアを取得しました",number+1);
        return getScore;
    } else {
        
        //無い場合初期設定として0を格納する。
        NSArray* defaultDic = @[@0,@0,@0,@0,@0];
        [defaults setObject:defaultDic forKey:scoreStr];
        
        NSLog(@"初回データの記憶が成功しました。");
        
        //再度取得し、配列から引数のindexのスコアをgetScoreに格納。
        scoreArray = [defaults objectForKey:scoreStr];
        getScore = [scoreArray objectAtIndex:number];
        NSLog(@"%d位のスコアを取得しました",number+1);
        return getScore;
    }
    
}

//初回起動時にスタート画面で初回記憶を行う。（スコアは0点）
- (void)memoryScore {
    
    //ユーザーデフォルトの取得
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //初期設定スコアの配列
    NSArray* defaultDic = @[@0,@0,@0,@0,@0];
    
    //ユーザーデフォルトのキーを取得。
    NSString* scoreStr = [NSString stringWithFormat:HAMBURG_SCORE_KEY];
    
    //スコアが存在するか取得。無い場合、戻り値0。
    NSArray* scoreArray = [defaults arrayForKey:scoreStr];
    
    if (scoreArray) {
        return;
    } else{
        
        //初期設定0点を記憶。
        [defaults setObject:defaultDic forKey:scoreStr];
        NSLog(@"初回データの記憶が成功しました。");
    }
        
    
}

//メインゲーム画面での初期持ち点
- (void)initHavingScore {
    
    //ユーザーデフォルトの取得
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //初期持ち点
    int havingScore = HAVING_SCORE;
    
    //初期持ち点の記憶
    [defaults setInteger:havingScore forKey:HAVING_SCORE_KEY];
    NSLog(@"初期持ち点1000点の記憶が成功しました。");
        
        
    
}

//メインゲーム画面での持ち点への反映。
- (void)nextGameReflection:(int)scorePoint {
    
    //ユーザーデフォルトの取得
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //記憶してあるスコアを取得
    int havingScore = [defaults integerForKey:HAVING_SCORE_KEY];
    
    //スコアを反映
    int reflectionScore = havingScore - (scorePoint * 10);
    
    [defaults setInteger:reflectionScore forKey:HAVING_SCORE_KEY];
    NSLog(@"スコアの反映に成功しました。");
    
    
}

//直近ゲームでのスコアを取得
+ (int)recentlyScore {
    
    //ユーザーデフォルトの取得
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //記憶してあるスコアを取得
    int score = [defaults integerForKey:HAVING_SCORE_KEY];
    
    NSLog(@"直近ゲームのスコアを取得しました");
    return score;
}


@end
