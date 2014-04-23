//
//  cookBBAViewController.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "cookBBAViewController.h"

@interface cookBBAViewController ()

@end

@implementation cookBBAViewController
@synthesize bgImg = _bgImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        }
    
    return self;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    //アイコン広告の自動更新を停止
    [gfIController stopAd];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the rview, typically from a nib.
    scoreMemory* sm = [[scoreMemory alloc] init];
    
    [sm memoryScore];
//    NSString* bgmPath = [[NSBundle mainBundle] pathForResource:@"sougen-d" ofType:@"mp3"];
//    
//    NSURL* bgmURL = [NSURL fileURLWithPath:bgmPath];
//    
//    _bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmURL error:nil];
//    _bgm.numberOfLoops = -1;
//    
//    [_bgm prepareToPlay];
    
//    [super viewDidAppear:animated];
    //GFIconControllerの初期化
    gfIController = [[GFIconController alloc] init];
    
    //アイコンの自動更新感覚を指定(デフォルトで30秒/10秒)
    [gfIController setRefreshTiming:20];
    
    GFIconView* iconView1 = [[GFIconView alloc] initWithFrame:CGRectMake(20, 510, 40, 40)];
    [gfIController addIconView:iconView1];
    [self.view addSubview:iconView1];
    
    GFIconView* iconView3 = [[GFIconView alloc] initWithFrame:CGRectMake(80, 510, 40, 40)];
    [gfIController addIconView:iconView3];
    [self.view addSubview:iconView3];
    
    GFIconView* iconView5 = [[GFIconView alloc] initWithFrame:CGRectMake(140, 510, 40, 40)];
    [gfIController addIconView:iconView5];
    [self.view addSubview:iconView5];
    
    GFIconView* iconView6 = [[GFIconView alloc] initWithFrame:CGRectMake(200, 510, 40, 40)];
    [gfIController addIconView:iconView6];
    [self.view addSubview:iconView6];
    
    GFIconView* iconView8 = [[GFIconView alloc] initWithFrame:CGRectMake(260, 510, 40, 40)];
    [gfIController addIconView:iconView8];
    [self.view addSubview:iconView8];
    
    
    
    [gfIController loadAd:@"5567"];

    
    
    _bgImg.userInteractionEnabled = NO;
        
}
- (IBAction)mainSegueBtn:(id)sender {
    [self performSegueWithIdentifier:@"mainSegue" sender:self];
}
- (IBAction)tutorialSegueBtn:(id)sender {
    [self performSegueWithIdentifier:@"tutorialSegue" sender:self];
}
- (IBAction)scoreSegueBtn:(id)sender {
    [self performSegueWithIdentifier:@"scoreSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"mainSegue"]) {
        
    } else if ([segue.identifier isEqualToString:@"tutorialSegue"]){
        
    } else if ([segue.identifier isEqualToString:@"scoreSegue"]){
//        
//        scoreSceneViewController* scoreVC = segue.destinationViewController;
//        
//        scoreVC.bgm = _bgm;
        
    }
    
}

@end
