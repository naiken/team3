//
//  soundMusic.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface soundMusic : NSObject {
    
//    //グレートの音
//    CFURLRef* greatSoundURL;
//    SystemSoundID* greatSoundId;
//    
//    //グッドの音
//    CFURLRef* goodSoundURL;
//    SystemSoundID* goodSoundId;
//    
//    //バッドの音
//    CFURLRef* badSoundURL;
//    SystemSoundID* badSoundId;
}

@property (nonatomic,readwrite) AVAudioPlayer* bgmPlayer;

@property(readwrite)CFURLRef greatSoundURL;
@property(readonly)SystemSoundID greatSoundId;

@property(readwrite)CFURLRef goodSoundURL;
@property(readonly)SystemSoundID goodSoundId;

@property(readwrite)CFURLRef badSoundURL;
@property(readonly)SystemSoundID badSoundId;



//BGMの再生
- (AVAudioPlayer*)backGroundMusicPlay;

//BGMの停止
- (void)bgmStop:(AVAudioPlayer*)source;

- (void)stopBgmOrPlayBGM;

//SE(グレート)の再生
- (SystemSoundID*)greatSound;

//SE(グッド)の再生
- (SystemSoundID*)goodSound;

//SE(バッド)の再生
- (SystemSoundID*)badSound;
@end
