//
//  monsterManager.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/17.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "monsterManager.h"

static struct {
    int monsterId;                                  //モンスターのID
    int stamina;                                    //スタミナ
    int attackPower;                                //攻撃力
    int experience;                                 //経験値
    float getTresure;
    __unsafe_unretained NSString* monsterName;      //モンスターの名前
    __unsafe_unretained NSString* imageName;        //画像の名前
    __unsafe_unretained NSString* description;
} Monster[] = {
    { 0, 100, 50, 5, 0.25f, @"にんじん", @"carrot.bmp", @"にんじん。"},
    { 1, 120, 40, 10, 0.25f, @"きゅうり", @"cucumber.bmp", @"きゅうり。"},
    { 2, 80, 80, 10, 0.25f, @"ピーマン", @"greenpepper.bmp", @"ピーマン。"},
    { 3, 200, 60, 15, 0.15f, @"はくさい", @"hakusai.bmp", @"はくさい。"},
    { 4, 300, 200, 30, 0.25f, @"タマネギ", @"onion.bmp", @"たまねぎ。"},
    { 5, 600, 150, 40, 0.25f, @"ジャガイモ", @"potato.bmp", @"じゃがいも。"},
    { 6, 500, 180, 40, 0.25f, @"さつまいも", @"sweetpotato.bmp", @"さつまいも。"},
    { 7, 1000, 170, 60, 0.15f, @"レンコン", @"lotusroot.bmp", @"レンコン。"},
    { 8, 700, 250, 150, 0.25f, @"なす", @"eggplant.bmp",@"なすび。"},
    { 9, 600, 400, 100, 0.25f, @"しいたけ", @"mushroom.bmp", @"しいたけ。"},
    { 10, 200, 1500, 1000, 0.25f, @"カボチャ", @"pumpkin.bmp", @"かぼちゃ。"},
    { 11, 1500, 350, 300, 0.15f, @"だいこん", @"radish.bmp", @"だいこん。"},
    { 12, 1400, 500, 530, 0.25f, @"トマト", @"tomato.bmp", @"トマト。"},
    { 13, 1800, 300, 400, 0.25f, @"リンゴ", @"apple.bmp", @"リンゴ。"},
    { 14, 1000, 800, 550, 0.25f, @"レモン", @"lemon.bmp", @"れもん。"},
    { 15, 2000, 600, 700, 0.15f, @"ぶどう", @"grape.bmp", @"ぶどう。"},
    { 16, 1750, 400, 1000, 0.25f, @"バナナ", @"banana.bmp", @"バナナ。"},
    { 17, 1200, 650, 1200, 0.25f, @"いちご", @"strawberry.bmp", @"いちご。"},
    { 18, 4000, 100, 1500, 0.25f, @"ピーチ", @"peach.bmp", @"もも。"},
    { 19, 2500, 800, 2000, 0.15f, @"すいか", @"watermelon.bmp", @"すいか。"},
    { 20, 2500, 700, 2000, 0.15f, @"緑・人参", @"d_carrot.bmp", @"黄緑色の人参。"},
    { 21, 3500, 600, 2200, 0.15f, @"青・胡瓜", @"d_cucumber.bmp", @"水色の胡瓜。"},
    { 22, 3000, 750, 2100, 0.15f, @"桃・茄子", @"d_eggplant.bmp", @"ピンク色の茄子。"},
    { 23, 3000, 800, 2500, 0.15f, @"黄・パプリカ", @"d_greenpepper.bmp", @"シトロンイエローのパプリカ。"},
    { 24, 1500, 1300, 2750, 0.10f, @"レンコンダ", @"lotusroot2.bmp", @"極度の寂しがりや。人が近づくと穴から出てきて人を石にしてしまう。「これでずっと一緒だね…♡」"},
    { 25, 4000, 900, 3000, 0.12f, @"ムッチョリン", @"mushroom2.bmp", @"人に近づきキノコ胞子をばらまいて人を眠らせ、ちゅーで襲う。襲われた人は3日間目が覚めない。"},
    { 26, 2500, 1200, 4000, 0.15f, @"桃・白菜", @"d_hakusai.bmp", @"桃色の白菜。"},
    { 27, 3500, 1000, 3750, 0.15f, @"紫・蓮根", @"d_lotusroot.bmp", @"紫色の蓮根。"},
    { 28, 1000, 5000, 10000, 0.15f, @"緑・椎茸", @"d_mushroom.bmp", @"グリーンの椎茸。"},
    { 29, 4500, 900, 4000, 0.15f, @"朱・玉葱", @"d_onion.bmp", @"朱色の玉葱。"},
    { 30, 6500, 1100, 5000, 0.12f, @"ヘタカボチャ", @"pumpkin2.bmp", @"見た目はハンサムだが、中身はどスケベ。カボチャの馬車のフリをしてキレイなお姉さんを乗せてはイタズラしている。"},
    { 31, 5000, 1200, 5500, 0.10f, @"あおみみず", @"apple2.bmp", @"人にまとわりつくのが生き甲斐。まとわりつかれた人は快楽に溺れる。"},
    { 32, 3000, 1500, 8000, 0.15f, @"紫・馬鈴薯", @"d_potato.bmp", @"ダマシーン色の馬鈴薯。"},
    { 33, 2300, 2000, 7500, 0.15f, @"桃・南瓜", @"d_pumpkin.bmp", @"チェリー色の南瓜。"},
    { 34, 5000, 1350, 6600, 0.15f, @"青・大根", @"d_radish.bmp", @"アルパインブルーの大根。"},
    { 35, 4000, 1400, 7700, 0.15f, @"碧・薩摩芋", @"d_sweetpotato.bmp", @"碧色の薩摩芋。"},
    { 36, 4500, 1550, 8500, 0.12f, @"あごプラント", @"eggplant2.bmp", @"大きな顎を撫でると面白くないことを言う。"},
    { 37, 7000, 1400, 7777, 0.10f, @"ピーマッチョマン", @"greenpepper2.bmp", @"モテるためにマッチョになったが、アタマの大きさゆえにモテない。その腹いせに気に食わないことがあると種を飛ばしてくる。"},
    { 38, 3000, 1700, 9000, 0.15f, @"青・トマト", @"d_tomato.bmp", @"藍色のトマト。"},
    { 39, 5000, 1400, 8500, 0.15f, @"緑・林檎", @"d_apple.bmp", @"グリーンアース色の林檎。"},
    { 40, 6500, 1200, 8000, 0.15f, @"青・バナナ", @"d_banana.bmp", @"青いバナナ。"},
    { 41, 10000, 1200, 10000, 0.15f, @"蒼・葡萄", @"d_grape.bmp", @"アクアブルーの葡萄。"},
    { 42, 12000, 1000, 11500, 0.12f, @"オニオン小僧", @"onion2.bmp", @"別名:ネガティブ小僧。ネガティブで常に「俺なんて俺なんて…」と呟いている。つぶやきを聞いてしまうと涙が止まらなくなる。"},
    { 43, 1000, 5000, 15000, 0.10f, @"ももつむり", @"peach2.bmp", @"人見知りで人が来るとともに隠れる。言葉の代わりに桃から強烈なガスを出す。"},
    { 44, 4000, 2500, 14000, 0.15f, @"緑・檸檬", @"d_lemon.bmp", @"ラッキーグリーンの檸檬。"},
    { 45, 7000, 2400, 12000, 0.15f, @"紫・桃", @"d_peach.bmp", @"アイリスの桃。"},
    { 46, 9000, 2300, 13000, 0.15f, @"紫・苺", @"d_strawberry.bmp", @"バイオレットの苺。"},
    { 47, 10000, 1500, 12500, 0.15f, @"黄・西瓜", @"d_watermelon.bmp", @"黄色の西瓜"},
    { 48, 2500, 10000, 15000, 0.12f, @"へのトマト", @"tomato2.bmp", @"いつも口をへの字に結び、顔を真っ赤にしている。同じ体系の雪だるまの人気っぷりに、嫉妬を隠し切れない。"},
    { 49, 15000, 2000, 20000, 0.10f, @"どろりんちょ", @"watermelon2.bmp", @"スイカ割り用のスイカに化け、人が近づいたところで姿を現し驚かす。本当は人間と友達になりたい。"},
};

@implementation monsterManager

+ (int)getStamina:(int)monsterId {
    return Monster[monsterId].stamina;
}

+ (int)getAttackPower:(int)monsterId {
    return Monster[monsterId].attackPower;
}

+ (int)getExperience:(int)monsterId {
    return Monster[monsterId].experience;
}

+ (float)getGetTresure:(int)monsterId {
    return Monster[monsterId].getTresure;
}

+ (NSString*)getMonsterName:(int)monsterId {
    return Monster[monsterId].monsterName;
}

+ (NSString*)getImageName:(int)monsterId {
    return Monster[monsterId].imageName;
}

+ (NSString*)getDescription:(int)monsterId {
    return Monster[monsterId].description;
}


@end
