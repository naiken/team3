//
//  pancoGameViewController.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/09.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "pancoGameViewController.h"

@interface pancoGameViewController ()

@end

@implementation pancoGameViewController {
    
    
    //アニメーションタイマー
    NSTimer* animationTimer;
    
    //スコアの受け渡し
    int scorePoint;
    
    //スコアの反復フラグ
    BOOL scoreFlag;
    
    //スコア記憶のクラスのオブジェクト生成
    scoreMemory* sm;
    
    //バウンド回数
    BOOL bounceCount;
    
    int SCREEN_WIDTH;
    int SCREEN_HEIGHT;
    
    //画面遷移タイマー
    NSTimer* segueTimer;
    
    //ロゴにパーティクル表示するレイヤー追加
    CAEmitterLayer* logoPS;
    
    //パーティクル発生フラグ
    int pFlag;
    int pFlag1;
    
    UIImageView* _logoImg;

    int limitCount;
}

@synthesize cupPanco = _cupPanco;

@synthesize greatSoundURL;
@synthesize greatSoundId;
@synthesize goodSoundId;
@synthesize goodSoundURL;
@synthesize badSoundId;
@synthesize badSoundURL;

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
    
    //タイマーの初期設定
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(pancoAnimation:) userInfo:nil repeats:YES];
    sm = [[scoreMemory alloc] init];
    bounceCount = NO;
    pFlag = 0;
    pFlag1 = 1;
    
    SCREEN_WIDTH = [[UIScreen mainScreen] bounds].size.width;
    SCREEN_HEIGHT = [[UIScreen mainScreen] bounds].size.height;
    
    limitCount = 0;
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    
    greatSoundURL = CFBundleCopyResourceURL(mainBundle, CFSTR("great"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(greatSoundURL, &greatSoundId);
    CFRelease(greatSoundURL);
    
    goodSoundURL = CFBundleCopyResourceURL(mainBundle, CFSTR("good"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(goodSoundURL, &goodSoundId);
    CFRelease(goodSoundURL);
    
    badSoundURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bad"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(badSoundURL, &badSoundId);
    CFRelease(badSoundURL);
    
    //パーティクルシステムを動作するためのレイヤーとセルの初期化
    logoPS = [CAEmitterLayer layer];
    logoPS.renderMode = kCAEmitterLayerAdditive;
    logoPS.emitterPosition = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    
    //スコア受け渡しのpoint初期化
    scorePoint = 25;
    
    //スコア反復フラグ初期化
    scoreFlag = NO;
    
    
    [animationTimer fire];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pancoAnimation:(NSTimer*)timer {
    
    //制限時間の実装
    limitCount++;
    
    NSLog(@"時間表示:%d",limitCount);
    
    //スコアポイント
    if (scorePoint == 25) {
        scoreFlag = NO;
    } else if (scorePoint == 0) {
        scoreFlag = YES;
    }
    
    if (scoreFlag) {
        scorePoint++;
    } else {
        scorePoint--;
    }
    
    //画像の入れ替え
    switch (scorePoint) {
        case 2:
        {
            UIImage* pancoImg = [UIImage imageNamed:@"panko05.png"];
            _cupPanco.image = pancoImg;
        }
            break;
            
        case 7:
        {
            UIImage* pancoImg = [UIImage imageNamed:@"panko04.png"];
            _cupPanco.image = pancoImg;
        }
            break;
            
        case 12:
        {
            UIImage* pancoImg = [UIImage imageNamed:@"panko03.png"];
            _cupPanco.image = pancoImg;
        }
            break;
            
        case 17:
        {
            UIImage* pancoImg = [UIImage imageNamed:@"panko02.png"];
            _cupPanco.image = pancoImg;
        }
            break;
            
        case 22:
        {
            UIImage* pancoImg = [UIImage imageNamed:@"panko01.png"];
            _cupPanco.image = pancoImg;
        }
            
        default:
            break;
    }
    
    
    if (limitCount == 250) {
        //時間切れによ最悪点の反映
        scorePoint = 25;
        
        //アニメーションタイマーの停止
        [animationTimer invalidate];
        
        self.view.userInteractionEnabled = NO;
        
        _cupPanco.tag = 1;
        
        [self badResult:_cupPanco.tag];
    }

    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //アニメーションタイマーの停止
    [animationTimer invalidate];
    
    self.view.userInteractionEnabled = NO;
    
    //    CGPoint eggCPos = _timingObject.center;
    
    if (0 <= scorePoint && scorePoint <= 5) {
        [self greatResult];
    } else if (6 <= scorePoint && scorePoint<=15) {
        [self goodResult];
    } else if (16 <= scorePoint && scorePoint <= 25) {
        [self badResult:0];
    }
    
}

//結果のリザルトのロゴイメージの作成
- (UIImageView*)makeLogoImageView:(CGRect)rect logo:(UIImage*)img {
    UIImageView* makeImg = [[UIImageView alloc] initWithImage:img];
    [makeImg setFrame:rect];
    
    return makeImg;
}

//バッドリザルトの際、呼び出されるメソッド
- (void)badResult:(int)tag {
    
    if (tag == 1) {
        UIImage* badPanco = [UIImage imageNamed:@"panko01.png"];
        _cupPanco.image = badPanco;
    }
    
    //badロゴイメージの描画
    UIImage* badLogo = [UIImage imageNamed:@"bad.png"];
    CGFloat logoHeight = badLogo.size.width;
    CGFloat logoWidth = badLogo.size.height;
    CGRect rect = CGRectMake(SCREEN_WIDTH - (logoWidth), 0 - (logoHeight/2), logoWidth*2, logoHeight/2);
    _logoImg = [self makeLogoImageView:rect logo:badLogo];
    _logoImg.tag = 2;
    [self.view addSubview:_logoImg];
    
    //ロゴのアニメーション
    PRTweenPeriod* period = [PRTweenPeriod periodWithStartValue:-(logoHeight/2) endValue:(SCREEN_HEIGHT/2) duration:3.0f];
    PRTweenOperation* tweenOp = [[PRTween sharedInstance] addTweenPeriod:period target:self selector:@selector(badLogoMove:) timingFunction:&PRTweenTimingFunctionBounceOut];
}

//グッドリザルトの際、呼び出されるメソッド
- (void)goodResult {
    
    //goodロゴイメージ描画
    UIImage* goodLogo = [UIImage imageNamed:@"good.png"];
    CGFloat logoHeight = goodLogo.size.height;
    CGFloat logoWidth = goodLogo.size.width;
    CGRect rect = CGRectMake((-logoWidth*2/3), SCREEN_HEIGHT/2 - logoHeight*2/3, logoWidth*2/3, logoHeight*2/3);
    _logoImg = [self makeLogoImageView:rect logo:goodLogo];
    _logoImg.tag = 1;
    [self.view addSubview:_logoImg];
    
    //ロゴのアニメーション
    PRTweenPeriod* period = [PRTweenPeriod periodWithStartValue:-(logoWidth*2/3)/2 endValue:SCREEN_WIDTH + (logoWidth*2/3)/2 duration:4.0f];
    PRTweenOperation* tweenOp = [[PRTween sharedInstance] addTweenPeriod:period target:self selector:@selector(goodLogoAnimation:) timingFunction:&PRTweenTimingFunctionBounceInOut];
    
    

}
//グレートリザルトの際、呼び出されるメソッド
- (void)greatResult {
    
    //リザルトgreatの描画
    
    //greatロゴイメージ描画
    UIImage* greatLogo = [UIImage imageNamed:@"great.png"];
    CGFloat logoHeight = greatLogo.size.height;
    CGFloat logoWidth = greatLogo.size.width;
    CGRect rect = CGRectMake(SCREEN_WIDTH/2 - (logoWidth/3), SCREEN_HEIGHT/2 - (logoHeight/3)-100, logoWidth*2/3, logoHeight*2/3);
    _logoImg = [self makeLogoImageView:rect logo:greatLogo];
    [self.view addSubview:_logoImg];
    _logoImg.alpha = 0;
    _logoImg.tag = 0;
    
    //ロゴのアニメーション
    PRTweenPeriod* period = [PRTweenPeriod periodWithStartValue:0 endValue:1.0 duration:1.0f];
    PRTweenOperation* tweenOp = [[PRTween sharedInstance] addTweenPeriod:period target:self selector:@selector(greatLogoAnimation:) timingFunction:&PRTweenTimingFunctionBounceOut];
    
}

//バッドロゴのアニメーション
- (void)badLogoMove:(PRTweenPeriod*)period {
    
    if (period.tweenedValue == SCREEN_HEIGHT/2) {
        bounceCount = YES;
    }
    
    if (bounceCount) {
        //2秒遅延した後にsegueToPancoGameのメソッドを実行
        AudioServicesPlaySystemSound(badSoundId);
        [self performSelector:@selector(segueToPancoGame) withObject:nil afterDelay:2.0f];
    }
    [_logoImg setCenter:CGPointMake(SCREEN_WIDTH / 2, period.tweenedValue)];
}

//グッドロゴのアニメーション
- (void)goodLogoAnimation:(PRTweenPeriod*)period {
    
    if (period.tweenedValue >= SCREEN_WIDTH/2 - 100 && period.tweenedValue <= SCREEN_WIDTH/2){
        if (pFlag1 == 1) {
            pFlag = 1;
        }
    }
    
    if (pFlag) {
        [self.view.layer addSublayer:logoPS];
        CAEmitterCell* cell = [self LogoParticle:_logoImg.tag];
        logoPS.emitterCells = @[cell];
        NSLog(@"パーティクル");
        pFlag1 = 0;
        pFlag = 0;
    }
    if (period.tweenedValue == SCREEN_WIDTH + _logoImg.frame.size.width/2) {
        //2秒遅延した後にsegueToPancoGameのメソッドを実行
        AudioServicesPlaySystemSound(goodSoundId);
        [self performSelector:@selector(segueToPancoGame) withObject:nil afterDelay:2.0f];
    }
    
    [_logoImg setCenter:CGPointMake(period.tweenedValue, SCREEN_HEIGHT/2)];
}

//グレートロゴのアニメーション
- (void)greatLogoAnimation:(PRTweenPeriod*)period {
    
    if (period.tweenedValue == 1) {
        
        //パーティクル取得・描画
        [self.view.layer addSublayer:logoPS];
        CAEmitterCell* cell = [self LogoParticle:_logoImg.tag];
        logoPS.emitterCells = @[cell];
        
        //拡大アニメーション
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        _logoImg.transform = CGAffineTransformMakeScale(1.4, 1.4);
        
        [UIView commitAnimations];
        
        //3秒遅延した後にsegueToPancoGameのメソッドを実行
        AudioServicesPlaySystemSound(greatSoundId);
        [self performSelector:@selector(segueToPancoGame) withObject:nil afterDelay:3.5f];
    }
    [_logoImg setAlpha:period.tweenedValue];
}

//ロゴの後のパーティクル
- (CAEmitterCell*)LogoParticle:(NSInteger)tag {
    CAEmitterCell* Basecell = [CAEmitterCell emitterCell];
    
    // 破裂後に飛散するパーティクルの発生源
    CAEmitterCell *sparkCell = [CAEmitterCell emitterCell];
    UIImage* pimg = [UIImage imageNamed:@"maru_toumei.png"];
    if (tag == 0) {
        sparkCell.color = CGColorCreateCopy([UIColor colorWithRed:0.68 green:0.41 blue:0.51 alpha:0.5].CGColor);
        sparkCell.redRange = 1.0;
        sparkCell.greenRange = 1.0;
        sparkCell.blueRange = 1.0;
        sparkCell.alphaRange = 1.0;
        Basecell.birthRate = 1.7;
    }else if (tag == 1){
        Basecell.color = CGColorCreateCopy([UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.75].CGColor);
        Basecell.redRange = 1.0;
        Basecell.greenRange = 1.0;
        Basecell.blueRange = 1.0;
        Basecell.alphaRange = 0.5;
        Basecell.birthRate = 0.8;
    }
    
    Basecell.emissionLongitude = -M_PI / 2;
    Basecell.emissionLatitude = M_PI / 5;
    Basecell.emissionRange = M_PI / 10;
    Basecell.lifetime = 2.0;
    Basecell.velocity = 400;
    Basecell.velocityRange = 50;
    Basecell.yAcceleration = 300;
    Basecell.name = @"firework";
    
    sparkCell.contents = (__bridge id)pimg.CGImage;
    sparkCell.emissionRange = 2 * M_PI;
    sparkCell.birthRate = 1000;
    sparkCell.scale = 0.2;
    sparkCell.velocity = 130;
    sparkCell.lifetime = 3.0;
    sparkCell.yAcceleration = 80;
    sparkCell.beginTime = 1.5;
    sparkCell.duration = 0.1;
    sparkCell.alphaSpeed = -0.1;
    sparkCell.scaleSpeed = -0.1;
    
    Basecell.emitterCells = [NSArray arrayWithObjects:sparkCell, nil];
    
    return Basecell;
}


//ロゴのアニメーションの後に遷移
- (void)segueToPancoGame {
    [self performSegueWithIdentifier:@"onionGameSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"onionGameSegue"]) {
        

        //画面遷移時の処理
        [sm nextGameReflection:scorePoint];
        
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
