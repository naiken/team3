//
//  mainGameViewController.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreMemory.h"
#import "PRTween.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "soundMusic.h"

@interface mainGameViewController : UIViewController {
    
    //アニメーションするタイマーの宣言
    NSTimer* animationTimer;
    
    //スコアのフラグメント
    int scorePoint;
    
    //アニメーション回数
    int animationCount;
    
    //アニメーション反復フラグ
    BOOL animationFlag;
    
    UIImageView* _logoImg;
}

//タイミングの隠しパラメータを持ちながらアニメーションをする画像
@property (weak, nonatomic) IBOutlet UIImageView *timingObject;

@property(readwrite)CFURLRef greatSoundURL;
@property(readonly)SystemSoundID greatSoundId;

@property(readwrite)CFURLRef goodSoundURL;
@property(readonly)SystemSoundID goodSoundId;

@property(readwrite)CFURLRef badSoundURL;
@property(readonly)SystemSoundID badSoundId;

////ロゴイメージ
//@property (weak, nonatomic) UIImageView* logoImg;

@end
