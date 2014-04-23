//
//  ResultViewController.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/13.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController {
    
    scoreMemory* se;
    
    NSArray* scoreNumberArray;
    
    int recentScore;
}

@synthesize recentlyScoreLabel = _recentlyScoreLabel;
@synthesize rankInLabel = _rankInLabel;
@synthesize bgImg = _bgImg;
@synthesize manaitaImg = _manaitaImg;

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
    
    //スコアメモリークラスのオブジェクト生成
    se = [[scoreMemory alloc] init];
    
    _bgImg.userInteractionEnabled = NO;
    
    _manaitaImg.userInteractionEnabled = NO;
    
    //直近ゲームのスコアを取得
    recentScore = [scoreMemory recentlyScore];
    
    _recentlyScoreLabel.text = [NSString stringWithFormat:@"今回の出来   %d",recentScore];
    
    //直近スコアとベスト5のスコアをソート記憶
    [se scoreMemorise:recentScore];
    
    //scoreMemoryにオブジェクト生成
    NSMutableArray* getScoreArray = [NSMutableArray array];
    
    //各順位のスコアを取得。
    for (int i = 0; i < 5; i++) {
        [getScoreArray addObject:[scoreMemory getScore:i]];
    }
    
    //インスタンス変数に格納
    scoreNumberArray = (NSArray*)getScoreArray;
    
    for (int i = 0; i < 5; i++) {
        CGRect rect = CGRectMake(190, 220+(i*30), 50, 20);
        UILabel* scoreLabel = [self makeLabel:rect score:[[scoreNumberArray objectAtIndex:i] intValue]];
        [self.view addSubview:scoreLabel];
    }
    
    for (int i = 1; i <= 5; i++) {
        CGRect rect = CGRectMake(120, 220+(i-1)*30, 50, 20);
        UILabel* rankLabel = [self makeLabel:rect score:i];
        rankLabel.text = [NSString stringWithFormat:@"%d位",i];
        [self.view addSubview:rankLabel];
    }
    
    for (int i = 0; i < 5; i++) {
        if (recentScore == [[scoreNumberArray objectAtIndex:i] integerValue]) {
            _rankInLabel.transform = CGAffineTransformMakeTranslation(0, i*60);
            break;
        } else {
            if (i == 4) {
                _rankInLabel.hidden = YES;
            }
        }
    }
    
    [appCCloud setupAppCWithMediaKey:@"1e94190e732417a7be2e64bb185b2443390db072" option:APPC_CLOUD_AD];
    
    appCSimpleView* view = [[appCSimpleView alloc] initWithViewController:self vertical:appCVerticalBottom];
    
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)backToTitle:(id)sender {
    [self performSegueWithIdentifier:@"titleFromResult" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"titleFromResult"]) {
        
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

//ツイッター投稿

- (IBAction)twitterBtn:(id)sender {
    
        SLComposeViewController *twitter = [[SLComposeViewController alloc]init];
        twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:[NSString stringWithFormat:@"ハンバーグ料理ゲーム【cookBBA(くっくばばあ)】の今回のスコアは%dやで！\nもっとうまく作れる人おるんちゃう？\nみんなもやってみぃや！\n#cookBBA",recentScore]];
        [self presentViewController:twitter animated:YES completion:NULL];
    
}
@end
