//
//  tutorialViewController.m
//  colorBBA
//
//  Created by Hata Rie on 2014/05/24.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "tutorialViewController.h"

@interface tutorialViewController ()
{
    UIImage *tutorialImage;
    UIImageView *tutorialImageView;
    splashScreenViewController *splashVC;
    int _count;
}
@end

@implementation tutorialViewController

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

    CGRect rect = CGRectMake(0, 0, 320, 568);
    
    tutorialImageView = [[UIImageView alloc] initWithFrame:rect];
    tutorialImageView.image = [UIImage imageNamed:@"tutorial_00.png"];
    [self.view addSubview:tutorialImageView];
    
    tutorialImageView.userInteractionEnabled = YES;

    _count = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _count++;
    NSLog(@"%d",_count);
    NSString* str = [NSString stringWithFormat:@"tutorial_0%d.png", _count];
        tutorialImageView.image = [UIImage imageNamed:str];
    
    if (_count == 11) {
        splashVC = [self.storyboard instantiateViewControllerWithIdentifier:@"splashView"];
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"スプラッシュ画面に戻るよ");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
