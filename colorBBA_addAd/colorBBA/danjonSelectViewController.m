//
//  danjonSelectViewController.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "danjonSelectViewController.h"

@interface danjonSelectViewController () {
    
    UIScrollView* _sv;
    UIView* _uv;
    
    CGRect _danjonViewRect;
    
    NSArray* _danjonBtnArray;
    NSUserDefaults* _defaults;
    
    int _danjonTag;
}

@end

@implementation danjonSelectViewController

@synthesize monsterArray = _monsterArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray*)monsterArray {
    return _monsterArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _danjonViewRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    
    _defaults = [NSUserDefaults standardUserDefaults];
    
    _sv = [[UIScrollView alloc] initWithFrame:_danjonViewRect];
    
    _uv = [[UIView alloc] initWithFrame:CGRectMake(_danjonViewRect.origin.x, _danjonViewRect.origin.y, _danjonViewRect.size.width, _danjonViewRect.size.height * 2)];
    [_sv addSubview:_uv];
    _sv.contentSize = _uv.bounds.size;
    [self.view addSubview:_sv];
    
    
    UIButton* tutorial = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tutorial.frame = CGRectMake(_uv.bounds.size.width * 0.05f,
                                _uv.bounds.size.height * 0.04f, 130, 50);
    
    [tutorial setTitle:@"" forState:UIControlStateNormal];
    [tutorial setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tutorial setBackgroundImage:[UIImage imageNamed:@"tutorial.png"] forState:UIControlStateNormal];
    [tutorial addTarget:self action:@selector(tutorialAct:) forControlEvents:UIControlEventTouchUpInside];
    [_uv addSubview:tutorial];
    
    NSMutableArray* danjonArray = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        
        BOOL isClear = [_defaults boolForKey:[NSString stringWithFormat:@"is_danjon_clear_id%d",i]];
        UIButton* danjon = [self makeDanjonBtn:i isClear:isClear];
        [danjonArray addObject:danjon];
        [_uv addSubview:danjon];
    }
    _danjonBtnArray = (NSArray*)danjonArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton*)makeDanjonBtn:(int)tag isClear:(BOOL)clear {
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(30, _uv.bounds.size.height * (0.09f * tag) + 125, 260, 50);
    if (clear) {
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_btn.png",tag + 1]] forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:YES];
    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"hatena.png"] forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:NO];
    }
    [btn setTag:tag];
    [btn addTarget:self action:@selector(danjonSelect:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)danjonSelect:(UIButton*)danjonBtn {
    int btnTag = (int)danjonBtn.tag;
    _danjonTag = btnTag;
//    [_defaults setInteger:btnTag forKey:@"danjon_go_id"];
//    [self performSegueWithIdentifier:@"mainGameSegue" sender:self];
    
    int BBAStamina = (int)[_defaults integerForKey:@"BBA_stamina"];
    int useStamina = (int)[danjonManager getStamina:btnTag];
    int monsterNumber = (int)[danjonManager getMonsterCount:btnTag];
    
    if (BBAStamina < useStamina) {
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"スタミナが足りません。" message:@"入れへんで" delegate:self cancelButtonTitle:@"回復するまで待つで！" otherButtonTitles: nil];
        av.tag = 1;
        [av show];
    }else {
        NSString* msg = [NSString stringWithFormat:@"体力を%d〜%d消費します。", useStamina / monsterNumber, useStamina];
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"入りますか？" message:msg delegate:self cancelButtonTitle:@"やめとくで！" otherButtonTitles:@"入るで！", nil];
        av.tag = 0;
        [av show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (!alertView.tag) {
        switch (buttonIndex) {
            case 0:{
                [alertView removeFromSuperview];
            }break;
                
            default:{
                [alertView removeFromSuperview];
                [_defaults setInteger:_danjonTag forKey:@"danjon_go_id"];
                [self performSegueWithIdentifier:@"mainGameSegue" sender:self];
            }break;
        }
    } else {
        [alertView removeFromSuperview];
    }
}

- (void)tutorialAct:(UIButton*)tutorialBtn {
    NSLog(@"チュートリアル画面が押されたでー");
    tutorialViewController *tutorialVC = [[tutorialViewController alloc] init];
    tutorialVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:tutorialVC animated:YES completion:NULL];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"mainGameSegue"]) {
    }
}


@end
