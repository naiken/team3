//
//  scoreSceneViewController.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "scoreSceneViewController.h"

@interface scoreSceneViewController ()


@end

@implementation scoreSceneViewController {
    BOOL soundFlag;
    
    cookBBAAppDelegate* ad;
    
    soundMusic* sm;
    
    NSUserDefaults* defaults;
    
}

@synthesize bgImg = _bgImg;
@synthesize manaitaImg = _manaitaImg;

//@synthesize cookBBADelegate = _cookBBADelegate;

//@synthesize bgm = _bgm;

@synthesize bgmSwitchOnOff = _bgmSwitchOnOff;

static NSString* const BGM_KEY = @"bgm_boolean_key";


//@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //scoreMemoryにオブジェクト生成
    NSMutableArray* getScoreArray = [NSMutableArray array];
    
    _bgImg.userInteractionEnabled = NO;
    _manaitaImg = NO;
    
//    NSString* bgmPath = [[NSBundle mainBundle] pathForResource:@"sougen-d" ofType:@"mp3"];
//    
//    NSURL* bgmURL = [NSURL fileURLWithPath:bgmPath];
//    
//    _bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmURL error:nil];
//    _bgm.numberOfLoops = -1;
//    
//    [_bgm prepareToPlay];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    [_bgmSwitchOnOff setOn:[defaults boolForKey:BGM_KEY]];
    
    
    
//    _cookBBADelegate = [[cookBBAAppDelegate alloc] init];
    
//    [_cookBBADelegate setDelegate:self];
    
    //各順位のスコアを取得。
    for (int i = 0; i < 5; i++) {
        [getScoreArray addObject:[scoreMemory getScore:i]];
    }
    
    //インスタンス変数に格納
    scoreNumberArray = (NSArray*)getScoreArray;
    
    for (int i = 0; i < 5; i++) {
        CGRect rect = CGRectMake(150, 190+(i*30), 70, 20);
        UILabel* scoreLabel = [self makeLabel:rect score:[[scoreNumberArray objectAtIndex:i] intValue]];
        [self.view addSubview:scoreLabel];
    }
    
    for (int i = 1; i <= 5; i++) {
        CGRect rect = CGRectMake(50, 190+(i-1)*30, 70,20);
        UILabel* rankLabel = [self makeLabel:rect score:i];
        rankLabel.text = [NSString stringWithFormat:@"%d位",i];
        [self.view addSubview:rankLabel];
    }
    
    [appCCloud setupAppCWithMediaKey:@"1e94190e732417a7be2e64bb185b2443390db072" option:APPC_CLOUD_AD];
    
    appCSimpleView* view = [[appCSimpleView alloc] initWithViewController:self vertical:appCVerticalBottom];
    
    [self.view addSubview:view];
    
}

//- (void)viewDidLayoutSubviews {
//    
//    _bgm = (AVAudioPlayer*)[defaults objectForKey:@"BGM"];
//    if (!_bgm.playing) {
//        if (!_bgm) {
//            NSString* bgmPath = [[NSBundle mainBundle] pathForResource:@"sougen-d" ofType:@"mp3"];
//        
//            NSURL* bgmURL = [NSURL fileURLWithPath:bgmPath];
//        
//            _bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmURL error:nil];
//            _bgm.numberOfLoops = -1;
//        
//            [_bgm prepareToPlay];
//            
////            [defaults setObject:_bgm forKey:@"BGM"];
//            
//        }
//    }
//
//}

- (IBAction)backStartSegue:(id)sender {
    [self performSegueWithIdentifier:@"titleFromScore" sender:self];
}

- (UILabel*)makeLabel:(CGRect)rect score:(int)score {
    UILabel* sLabel = [[UILabel alloc] init];
    [sLabel setFrame:rect];
    [sLabel setText:[NSString stringWithFormat:@"%d", score]];
    UIFont* font = [UIFont fontWithName:@"Noteworthy" size:20.0];
    [sLabel setTextColor:[UIColor colorWithRed:0.365 green:0.078 blue:0.078 alpha:1.0]];
    [sLabel setFont:font];
    [sLabel setTextAlignment:NSTextAlignmentRight];
    return sLabel;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"titleFromScore"]) {
        
    }
}
//- (IBAction)bgmSwitch:(id)sender {
////    [sm stopBgmOrPlayBGM];
//        if (_bgmSwitchOnOff.on) {
//            BOOL bgmPlaying = YES;
//            [defaults setBool:bgmPlaying forKey:BGM_KEY];
//        
//            [_bgm play];
//            
////            id insertBgm = (id)_bgm;
//
//            [defaults setObject:_bgm forKey:@"BGM"];
//        
//        } else {
//            BOOL bgmPlaying = NO;
//            [defaults setBool:bgmPlaying forKey:BGM_KEY];
//        
//            [_bgm stop];
//            [_bgm prepareToPlay];
//            
////            id insertBgm = (id)_bgm;
////            UIDevice
//
//            
//
//        }
//}

- (IBAction)twitBtn:(id)sender {
    
    [GFController showGF:self site_id:@"5567" delegate:self];
}




////appDelegateから委譲されたメソッド
//- (void)BGMDelegate:(cookBBAAppDelegate *)cBAD BGMOBject:(AVAudioPlayer *)bgm {
//    _bgm = bgm;
//}

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
