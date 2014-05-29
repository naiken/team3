//
//  danjonManager.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/17.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "danjonManager.h"

static struct {
    int danjonId;                               //ダンジョンのID
    int monsterNumber;                          //モンスター数
    int stamina;                                //消費スタミナ
    __unsafe_unretained NSString* danjonName;   //ダンジョンの名前
} Danjon[] = {
    { 0, 4, 100, @"旅立ちの店"},
    { 1, 4, 200, @"立ちふさがる食材"},
    { 2, 4, 300, @"食材の誘惑"},
    { 3, 4, 400, @"八百屋からの召使い"},
    { 4, 4, 500, @"食材のささやき"},
    { 5, 6, 600, @"八百屋に潜む陰"},
    { 6, 6, 700, @"野菜はおいしい"},
    { 7, 6, 800, @"八百屋を守るもの"},
    { 8, 6, 900, @"八百屋の守護神"},
    { 9, 6, 1000, @"爆ぜろ！野菜！弾けろ！野菜！"},
};

@implementation danjonManager

+ (NSString*)getDanjonName:(int)danjonId {
    return Danjon[danjonId].danjonName;
}

+ (int)getMonsterCount:(int)danjonId {
    return Danjon[danjonId].monsterNumber;
}

+ (int)getStamina:(int)danjonId {
    return Danjon[danjonId].stamina;
}



@end
