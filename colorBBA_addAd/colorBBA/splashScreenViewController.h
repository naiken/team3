//
//  splashScreenViewController.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/22.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tutorialViewController.h"
#import "appCCloud.h"
#import <GameFeatKit/GFController.h>
#import <GameFeatKit/GFIconController.h>
#import <GameFeatKit/GFView.h>

@interface splashScreenViewController : UIViewController {
    
    GFIconController* _gfIconController;
}

- (IBAction)touchAdBtn:(UIButton *)sender;

@end
