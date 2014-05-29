//
//  colorBBAMainViewController.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/05.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "colorBBAMainViewController.h"
#import "colorBBAMainMyScene.h"

@implementation colorBBAMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    [skView setMultipleTouchEnabled:NO];
    // Create and configure the scene.
    SKScene * scene = [colorBBAMainMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
