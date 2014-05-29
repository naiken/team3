//
//  splashScreenViewController.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/22.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "splashScreenViewController.h"


@interface splashScreenViewController ()

@end

@implementation splashScreenViewController

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
    
    [appCCloud setupAppCWithMediaKey:@"1f647e09d853d170a8e6aa9128efe8bd6067de24" option:APPC_CLOUD_AD];
    
    _gfIconController = [[GFIconController alloc] init];
    
    //アイコンの自動更新感覚を指定(デフォルトで30秒/10秒)
    [_gfIconController setRefreshTiming:20];
    
    GFIconView* iconView1 = [[GFIconView alloc] initWithFrame:CGRectMake(20, 510, 40, 40)];
    [_gfIconController addIconView:iconView1];
    [self.view addSubview:iconView1];
    
    GFIconView* iconView3 = [[GFIconView alloc] initWithFrame:CGRectMake(80, 510, 40, 40)];
    [_gfIconController addIconView:iconView3];
    [self.view addSubview:iconView3];
    
    GFIconView* iconView5 = [[GFIconView alloc] initWithFrame:CGRectMake(140, 510, 40, 40)];
    [_gfIconController addIconView:iconView5];
    [self.view addSubview:iconView5];
    
    GFIconView* iconView6 = [[GFIconView alloc] initWithFrame:CGRectMake(200, 510, 40, 40)];
    [_gfIconController addIconView:iconView6];
    [self.view addSubview:iconView6];
    
    GFIconView* iconView8 = [[GFIconView alloc] initWithFrame:CGRectMake(260, 510, 40, 40)];
    [_gfIconController addIconView:iconView8];
    [self.view addSubview:iconView8];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // アイコン広告の表示
    [_gfIconController loadAd:@"6299"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // アイコン広告の自動更新を停止
    [_gfIconController stopAd];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL init = [defaults boolForKey:@"init_launch"];
    
    if (!init) {
        init = YES;
        [defaults setBool:init forKey:@"init_launch"];
        
        tutorialViewController *tutorialVC = [[tutorialViewController alloc] init];
        tutorialVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tutorialVC animated:YES completion:NULL];
    }
    
    [self performSegueWithIdentifier:@"toStart" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toStart"]) {
    }
}

- (IBAction)touchAdBtn:(UIButton *)sender {
    
    
    NSLog(@"unko");
    //メディアキーを指定します。管理画面内にて確認できるメディアキーを指定しないと成果が取得できません。
    [appCCloud setupAppCWithMediaKey:@"1f647e09d853d170a8e6aa9128efe8bd6067de24" option:APPC_CLOUD_AD];
    
    /*
     *closeBlock:メソッドで初期化を行うと、
     *カットイン型ビューのクローズボタンタップ時の処理を記述できます。
     *上記例では、ビューを破棄しています。
     */
    __block appCCutinView* cutin = [[appCCutinView alloc]
                                    initWithViewController:self  closeBlock:^(id sender_){
                                        [cutin removeFromSuperview];
                                    }];
    
    [self.view addSubview:cutin];
}
@end
