//
//  growBBAViewController.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "growBBAViewController.h"

@interface growBBAViewController () {
    
}
@end

@implementation growBBAViewController

static growBBAViewController* sharedGrowBBAViewController;

+ (growBBAViewController*)sharedManager {
	@synchronized(self) {
		if (sharedGrowBBAViewController == nil) {
			sharedGrowBBAViewController = [[self alloc] init];
		}
	}
	return sharedGrowBBAViewController;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
		if (sharedGrowBBAViewController == nil) {
			sharedGrowBBAViewController = [super allocWithZone:zone];
			return sharedGrowBBAViewController;
		}
	}
	return sharedGrowBBAViewController;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    [skView setMultipleTouchEnabled:NO];
    // Create and configure the scene.
    SKScene * scene = [growBBAMainScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
