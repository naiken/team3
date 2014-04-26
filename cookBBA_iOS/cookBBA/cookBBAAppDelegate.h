//
//  cookBBAAppDelegate.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#include <AVFoundation/AVFoundation.h>
#import "soundMusic.h"
#import "scoreSceneViewController.h"
#import <GameFeatKit/GFController.h>

////デリゲートの前置き宣言
//@protocol BGMAndSEDelegate;


@interface cookBBAAppDelegate : UIResponder <UIApplicationDelegate>
//
////デリゲートの宣言
//@property (nonatomic, assign) id<BGMAndSEDelegate> delegate;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AVAudioPlayer* BGMPlayer;

////アプリが起動したらBGMのストップ操作デリゲートメソッド
//- (void)stopBGMOrPlayBGM:(BOOL)yesOrNoBgm;

@end

////デリゲートの定義
//
//@protocol BGMAndSEDelegate <NSObject>
//
//
//@optional

//アプリが起動したらSEのオブジェクトを委譲
//- (void)SEDelegate:(cookBBAAppDelegate*)cBAD;
//
//
////アプリが起動したらBGMの再生操作デリゲートメソッド


