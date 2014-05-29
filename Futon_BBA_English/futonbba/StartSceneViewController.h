//
//  StartSceneViewController.h
//  FutonBBA
//
//  Created by 池田　春菜 on 2014/04/29.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface StartSceneViewController : UIViewController <ADBannerViewDelegate>
{
    int tCount;
    ADBannerView* _adView;
    BOOL _bannerIsVisible;
}
- (IBAction)ScoreButton:(UIButton *)sender;
- (IBAction)TutorialButton:(UIButton *)sender;
- (IBAction)NextButton:(UIButton *)sender;
- (IBAction)CloseButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *PopUpTutorialView;
@property (weak, nonatomic) IBOutlet UIImageView *tutorialView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;
@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;


////説明文のテキストを前もって作成。
//extern NSString* const listTutorialView[3];
//
@end


