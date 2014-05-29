//
//  growBBAViewController.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "growBBAMainScene.h"


@interface growBBAViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITabBarItem *growTabItem;

+ (growBBAViewController*)sharedManager;

@end
