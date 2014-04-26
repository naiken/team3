//
//  tutorialSceneViewController.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "tutorialSceneViewController.h"

@interface tutorialSceneViewController ()

@end

@implementation tutorialSceneViewController

@synthesize explanationLabel = _explanationLabel;


NSString* const kExplanationText[] = {@"タップせんかい♡♥︎",
                                        @"あんた、ハンバーグくらいつくれなあかんで！\n今から作り方説明するさかい\nよー聞いときやー。",
                                        @"ハンバーグの材料を順番に準備・計量して\nベストな焼き加減で美味しいハンバーグを\n作ってや！",
                                        @"ハンバーグに必要な材料が\n順番に出てくるさかい\nタイミングよくタップして計算してや！",
                                        @"全て一発勝負や！！\n気張ってかなあかんで！",
                                        @"よー正確に計ることで\nおいしいハンバーグが\n出来んねん！",
                                        @"最後に焼き加減も\n一発勝負やで！"
                                        @"ベストタイミングで\n高得点狙ってこーや！"};


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
    
    //タッチ回数の初期化
    tCount = 0;
    
    //説明文ラベルの設定
    _explanationLabel.text = kExplanationText[tCount];
    _explanationLabel.numberOfLines = 3;
    _explanationLabel.adjustsFontSizeToFitWidth = YES;
    
    

    // Do any additional setup after loading the view.
}
- (IBAction)backMainBtn:(id)sender {
    [self performSegueWithIdentifier:@"titleFromTutorial" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"titleFromTutorial"]) {
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    tCount++;
    
    if (tCount == 7) {
        tCount = 1;
    }
    
    _explanationLabel.text = kExplanationText[tCount];
    
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
