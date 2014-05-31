//
//  danjonSelectViewController.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Monster.h"
#import "colorBBAMainViewController.h"
#import "colorBBAMainMyScene.h"
#import "danjonManager.h"
#import "tutorialViewController.h"
#import "appCCloud.h"

@interface danjonSelectViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, assign) NSArray* monsterArray;

- (NSArray*)monsterArray;

@end
