//
//  onionGameViewController.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreMemory.h"
#import "PRTween.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "soundMusic.h"

@interface onionGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *onionCup;

@property(readwrite)CFURLRef greatSoundURL;
@property(readonly)SystemSoundID greatSoundId;

@property(readwrite)CFURLRef goodSoundURL;
@property(readonly)SystemSoundID goodSoundId;

@property(readwrite)CFURLRef badSoundURL;
@property(readonly)SystemSoundID badSoundId;


@end
