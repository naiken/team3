//
//  cookBBAViewController.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreMemory.h"
#include <AVFoundation/AVFoundation.h>
#import "cookBBAAppDelegate.h"
#import <GameFeatKit/GFIconController.h>
#import <GameFeatKit/GFIconView.h>

@interface cookBBAViewController : UIViewController {
    GFIconController* gfIController;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

@property (nonatomic) AVAudioPlayer* bgm;
@end
