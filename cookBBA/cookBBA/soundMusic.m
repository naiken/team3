//
//  soundMusic.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "soundMusic.h"


@implementation soundMusic

@synthesize bgmPlayer = _bgmPlayer;

@synthesize greatSoundURL;
@synthesize greatSoundId;
@synthesize goodSoundId;
@synthesize goodSoundURL;
@synthesize badSoundId;
@synthesize badSoundURL;


static NSString* const BGM_KEY = @"bgm_boolean_key";


//バックグラウンドミュージックの再生
- (AVAudioPlayer*)backGroundMusicPlay {
    NSString* bgmPath = [[NSBundle mainBundle] pathForResource:@"sougen-d" ofType:@"mp3"];

    NSURL* bgmURL = [NSURL fileURLWithPath:bgmPath];
    
    _bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmURL error:nil];
    _bgmPlayer.numberOfLoops = -1;
    
    [_bgmPlayer prepareToPlay];
    [_bgmPlayer play];
    return _bgmPlayer;
}

//bgmが動作していたらoffにするデリゲートメソッド
- (void)stopBgmOrPlayBGM {
    
//    _bgmPlayer = [AVAudioPlayer]
    
    if (_bgmPlayer.playing) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        BOOL bgmPlaying = NO;
        [defaults setBool:bgmPlaying forKey:BGM_KEY];
        
        [_bgmPlayer pause];
    }else {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        BOOL bgmPlaying = YES;
        [defaults setBool:bgmPlaying forKey:BGM_KEY];
        
        [_bgmPlayer play];
    }
}

//BGMの停止
- (void)bgmStop:(AVAudioPlayer*)source {
    
}

- (SystemSoundID*)greatSound {
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    
    greatSoundURL = CFBundleCopyResourceURL(mainBundle, CFSTR("great"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(greatSoundURL, &greatSoundId);
    CFRelease(greatSoundURL);
    return &(greatSoundId);
}

- (SystemSoundID*)goodSound {
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    
    goodSoundURL = CFBundleCopyResourceURL(mainBundle, CFSTR("good"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(goodSoundURL, &goodSoundId);
    CFRelease(goodSoundURL);
    return &(goodSoundId);
}

- (SystemSoundID*)badSound {
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    
    badSoundURL = CFBundleCopyResourceURL(mainBundle, CFSTR("great"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(badSoundURL, &badSoundId);
    CFRelease(badSoundURL);
    return &(badSoundId);
}


@end
