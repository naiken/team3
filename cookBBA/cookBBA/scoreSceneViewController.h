//
//  scoreSceneViewController.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreMemory.h"
#import <AVFoundation/AVFoundation.h>
#import "cookBBAAppDelegate.h"
#import "soundMusic.h"
#import <Social/Social.h>
#import "appCCloud.h"
#import <GameFeatKit/GFView.h>
#import <GameFeatKit/GFController.h>



////デリゲートの前置き宣言
//@protocol BGMAndSEDelegate;

@interface scoreSceneViewController : UIViewController <GFViewDelegate>{
    
    //スコアの情報を持っている配列
    NSArray* scoreNumberArray;
     AVAudioPlayer* _bgm;
}


////デリゲートの宣言
//@property (nonatomic, assign) id<BGMAndSEDelegate> delegate;


//@property(nonatomic)cookBBAAppDelegate* cookBBADelegate;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *manaitaImg;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

@property (weak, nonatomic) IBOutlet UISwitch *bgmSwitchOnOff;
//@property(nonatomic,retain)AVAudioPlayer* bgm;


@end

////デリゲートの定義
//
//@protocol BGMAndSEDelegate <NSObject>
//
//
//@optional
//
//- (void)stopBgmOrPlayBGM;
//
//
//
//@end
