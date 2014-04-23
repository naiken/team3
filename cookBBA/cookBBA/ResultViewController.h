//
//  ResultViewController.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreMemory.h"
#import <Social/Social.h>
#import "appCCloud.h"

@interface ResultViewController : UIViewController

//直近スコア描画のラベル
@property (weak, nonatomic) IBOutlet UILabel *recentlyScoreLabel;

//ランクインラベル
@property (weak, nonatomic) IBOutlet UILabel *rankInLabel;
@property (weak, nonatomic) IBOutlet UIImageView *manaitaImg;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

- (IBAction)twitterBtn:(id)sender;

@end
