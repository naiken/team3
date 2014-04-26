//
//  ViewController.h
//  cupBBA
//
//  Created by Hata Rie on 2014/04/18.
//  Copyright (c) 2014年 Rie Hata. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "appc_cloud_ios_v_1.1.6_20140415/include/appCCloud/appCCloud.h"

@interface ViewController : UIViewController

{
    NSTimer *myTimer;  //一定間隔でなにかする為のタイマー
    BOOL isStart;      //タイマーが動いているかのフラグ
    BOOL isFstCalled;  //タイマーがはじめて呼ばれたフラグ
    int secTime;       //秒を表す変数
    int minTime;       //分を表す変数
    
}

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (nonatomic) int labelWidth;
@property (nonatomic) int labelHeight;

- (IBAction)timerStartAction:(id)sender;
- (IBAction)timerResetAction:(id)sender;
- (IBAction)bbaVoice:(id)sender;

@property(readwrite)CFURLRef bgm001VoiceURL;
@property(readonly)SystemSoundID bgm001VoiceID;

@property(readwrite)CFURLRef bgm002VoiceURL;
@property(readonly)SystemSoundID bgm002VoiceID;

@property(readwrite)CFURLRef bgm003VoiceURL;
@property(readonly)SystemSoundID bgm003VoiceID;

@property(readwrite)CFURLRef bgm004VoiceURL;
@property(readonly)SystemSoundID bgm004VoiceID;

@property(readwrite)CFURLRef bgm005VoiceURL;
@property(readonly)SystemSoundID bgm005VoiceID;

@property(readwrite)CFURLRef bgm006VoiceURL;
@property(readonly)SystemSoundID bgm006VoiceID;

@property(readwrite)CFURLRef bgm007VoiceURL;
@property(readonly)SystemSoundID bgm007VoiceID;

@property(readwrite)CFURLRef bgm008VoiceURL;
@property(readonly)SystemSoundID bgm008VoiceID;

@property(readwrite)CFURLRef piiiVoiceURL;
@property(readonly)SystemSoundID piiiVoiceID;

@end
