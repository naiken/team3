//
//  mainGameViewController.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "mainGameViewController.h"

@interface mainGameViewController ()


@end

@implementation mainGameViewController{
    
    //timingObjectのx座標
    int tOX;
    
    //timingObjectのy座標
    int tOY;
    
    //スコア記憶のクラスのオブジェクト生成
    scoreMemory* sm;
    
    //卵の位置記憶
    CGPoint eggPos;
    
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
    
    int limitCount;
}

@synthesize timingObject = _timingObject;
//@synthesize logoImg = _logoImg;

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
//        //初期化
//        tOX = _timingObject.center.x;
//        tOY = _timingObject.center.y;
//        sm = [[scoreMemory alloc] init];
//        [sm initHavingScore];
//        animationCount = 0;
//        animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(animationEgg:) userInfo:nil repeats:YES];
//        animationFlag = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初期化
    tOX = _timingObject.center.x;
    tOY = _timingObject.center.y;
    sm = [[scoreMemory alloc] init];
    [sm initHavingScore];
    animationCount = 0;
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(animationEgg:) userInfo:nil repeats:YES];
    animationFlag = YES;
    bounceCount = NO;
    pFlag = 0;
    pFlag1 = 1;
    
    limitCount = 0;
    
    SCREEN_WIDTH = [[UIScreen mainScreen] bounds].size.width;
    SCREEN_HEIGHT = [[UIScreen mainScreen] bounds].size.height;
    
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
    
    [animationTimer fire];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationEgg:(NSTimer*)tm {
    
    limitCount++;
    
    NSLog(@"時間表示:%d",limitCount);
    
    //scorePointの数値によりanimationFrag変更
    if (scorePoint == 25) {
        animationFlag = NO;
    } else if (scorePoint == 0){
        animationFlag = YES;
    }
    
    
    if (animationFlag) {
        //スコアのフラグ変数をインクリメント加えてy座標プラス
        scorePoint++;
        tOY += 10;
    } else {
        //スコアのフラグ変数をデクリメント加えてy座標マイナス
        scorePoint--;
        tOY -= 10;
    }
    
    //再描画
    _timingObject.center = CGPointMake(tOX, tOY);
    
    //アニメーション後の卵の位置を保存
    eggPos = _timingObject.center;
    
    if (limitCount == 250) {
        
        //時間切れによる最悪の得点
        scorePoint = 25;
        //アニメーションタイマーの停止
        [animationTimer invalidate];
        
        self.view.userInteractionEnabled = NO;
        [self badResult];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //アニメーションタイマーの停止
    [animationTimer invalidate];
    
    self.view.userInteractionEnabled = NO;
    
//    CGPoint eggCPos = _timingObject.center;
    
    if (0 <= scorePoint && scorePoint <= 5) {
        [self greatResult];
    } else if (6 <= scorePoint && scorePoint<=16) {
        [self goodResult];
    } else if (17 <= scorePoint && scorePoint <= 25) {
        [self badResult];
    }
    
}

//結果のリザルトのロゴイメージの作成
- (UIImageView*)makeLogoImageView:(CGRect)rect logo:(UIImage*)img {
    UIImageView* makeImg = [[UIImageView alloc] initWithImage:img];
    [makeImg setFrame:rect];
    
    return makeImg;
}

//バッドリザルトの際、呼び出されるメソッド
- (void)badResult {
    //リザルトbadの描画
    UIImage* badEgg = [UIImage imageNamed:@"egg02.png"];
    _timingObject.image = badEgg;
    [_timingObject setCenter:eggPos];
    
    //badロゴイメージの描画
    UIImage* badLogo = [UIImage imageNamed:@"bad.png"];
    CGFloat logoHeight = badLogo.size.width;
    CGFloat logoWidth = badLogo.size.height;
    CGRect rect = CGRectMake(160 - (logoWidth/2), 0 - (logoHeight/2), logoWidth*2, logoHeight/2);
    _logoImg = [self makeLogoImageView:rect logo:badLogo];
    _logoImg.tag = 2;
    [self.view addSubview:_logoImg];
    
    //ロゴのアニメーション
    PRTweenPeriod* period = [PRTweenPeriod periodWithStartValue:-(logoHeight/2) endValue:(SCREEN_HEIGHT/2) duration:3.0f];
    PRTweenOperation* tweenOp = [[PRTween sharedInstance] addTweenPeriod:period target:self selector:@selector(badLogoMove:) timingFunction:&PRTweenTimingFunctionBounceOut];
}

//グッドリザルトの際呼び出されるメソッド
- (void)goodResult {
    //リザルトgoodの描画
    UIImage* goodEgg = [UIImage imageNamed:@"egg03.png"];
    _timingObject.image = goodEgg;
    [_timingObject setCenter:eggPos];
    
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
    UIImage* greatEgg = [UIImage imageNamed:@"tamago.png"];
    _timingObject.image = greatEgg;
    [_timingObject setCenter:eggPos];
    
    //greatロゴイメージ描画
    UIImage* greatLogo = [UIImage imageNamed:@"great.png"];
    CGFloat logoHeight = greatLogo.size.height;
    CGFloat logoWidth = greatLogo.size.width;
    CGRect rect = CGRectMake(SCREEN_WIDTH/2 - (logoWidth/3), SCREEN_HEIGHT/2 - (logoHeight/3), logoWidth*2/3, logoHeight*2/3);
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

//グッドロゴの後のパーティクル
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
    [self performSegueWithIdentifier:@"gamePancoFromGameEgg" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gamePancoFromGameEgg"]) {

        //画面遷移時の処理
//        [segueTimer invalidate];
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
