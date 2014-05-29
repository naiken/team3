//
//  skillManager.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "skillManager.h"

static struct {
    int skillId;                //スキルID。
    int memoryFlag;             //覚える際のレベル。
    __unsafe_unretained NSString* skillName;        //スキルの名前。
    __unsafe_unretained NSString* skillDescription; //スキルの説明。
} Skill[] = {
    { 0, 1, @"バラバラやで！", @"色球5つを、\nランダムに変更する。"},
    { 1, 1, @"いちょう切り", @"相手のHPの1/4のダメージを与える。"},
    { 2, 2, @"唐辛子", @"色球を一つ、\n赤に変化させる。"},
    { 3, 2, @"青汁", @"色球を一つ、\n青に変化させる。"},
    { 4, 3, @"よもぎ", @"色球を一つ、\n緑に変化させる。"},
    { 5, 3, @"味見", @"自分のHPを\n中回復する。"},
    { 6, 4, @"早よ寝〜や", @"相手のHPに\n中ダメージ。"},
    { 7, 4, @"茶をしばく", @"自分のHPを\n大回復する。"},
    { 8, 5, @"白菜", @"色球を一つ、\n白色に変化させる。"},
    { 9, 5, @"レモン汁", @"色球を一つ、\n黄色に変化させる。"},
    { 10, 6, @"みかん", @"色球を一つ、\nオレンジに変化させる。"},
    { 11, 6, @"半月切り", @"相手のHPの1/2のダメージを与える。"},
};

@implementation skillManager

+ (NSString*)getSkillName:(int)skillId {
    return Skill[skillId].skillName;
}

+ (NSString*)getSkillDescription:(int)skillId {
    return Skill[skillId].skillDescription;
}

+ (int)getMemoryFrag:(int)skillId {
    return Skill[skillId].memoryFlag;
}


@end
