//
//  colorBBAMainAppDelegate.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/05.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "colorBBAMainAppDelegate.h"

@interface colorBBAMainAppDelegate () {

}

@property (nonatomic,strong) AVAudioPlayer* bgmPlayer;


@end

@implementation colorBBAMainAppDelegate

@synthesize bgmPlayer = _bgmPlayer;

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    
    //スキルを取得しているかどうかのフラグ
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL init = [defaults boolForKey:@"init_launch"];
    
    if (!init) {
        for (int i = 0; i < 6; i++) {
            BOOL isSkillLearn = NO;
            [defaults setBool:isSkillLearn forKey:[NSString stringWithFormat:@"is_skill_learn_id%d",i]];
        }
        
        for (int i = 0; i < 12; i++) {
            BOOL isSkillMemory = NO;
            [defaults setBool:isSkillMemory forKey:[NSString stringWithFormat:@"is_skill_memory_id%d",i]];
        }
        
        for (int i = 0; i < 50; i++) {
            BOOL isTresure = NO;
            [defaults setBool:isTresure forKey:[NSString stringWithFormat:@"is_Tresure_get_id%d",i]];
        }
        
        for (int i = 0; i < 10; i++) {
            BOOL isClear = NO;
            if (!i) {
                isClear = !isClear;
            }
            [defaults setBool:isClear forKey:[NSString stringWithFormat:@"is_danjon_clear_id%d",i]];
        }
        
        int BBALevel = 1;
        double BBAExperience = 0;
        int BBATag = 0;
        int BBAStamina = BBALevel * 100;
        
        [defaults setInteger:BBALevel forKey:@"BBA_level"];
        [defaults setDouble:BBAExperience forKey:@"BBA_experience"];
        [defaults setInteger:BBATag forKey:@"BBA_evolution"];
        [defaults setInteger:BBAStamina forKey:@"BBA_stamina"];
        
        [defaults setBool:init forKey:@"init_launch"];
        
    }

    NSDate* now = [NSDate date];
    [defaults setObject:now forKey:@"play_date"];
    
    [self recoverStamina:defaults nowDate:now];
    
    NSString* bgmPath = [[NSBundle mainBundle] pathForResource:@"bgm" ofType:@"wav"];
    
    NSURL* bgmURL = [NSURL fileURLWithPath:bgmPath];
    
    _bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmURL error:nil];
    _bgmPlayer.numberOfLoops = -1;
    [_bgmPlayer prepareToPlay];
    [_bgmPlayer play];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate* date = [NSDate date];
    [defaults setObject:date forKey:@"since_date"];
    
    /* 差分をfloatで取得します */
    NSDate* now = [defaults objectForKey:@"play_date"];
    float tmp = [date timeIntervalSinceDate:now]; // (2)
    NSLog(@"プレイ時間は%d分です。",(int)(tmp / 60) );
    [defaults setFloat:tmp forKey:@"play_time"];
    
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)]) {
        backgroundSupported = device.multitaskingSupported;
    }
    if (backgroundSupported) {
        [GFController backgroundTask];
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate* now = [NSDate date];
    [defaults setObject:now forKey:@"play_date"];
    
    [self recoverStamina:defaults nowDate:now];
    
    [GFController conversionCheckStop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [GFController activateGF:@"6299" useCustom:NO useIcon:YES usePopup:NO];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)recoverStamina:(NSUserDefaults*)defaults nowDate:(NSDate*)now {
    /* 差分をfloatで取得します */
    int restMinute = [defaults integerForKey:@"rest_minutes"];
    NSLog(@"前回の差分は%d分です。", restMinute);
    
    float agoTmp = [defaults floatForKey:@"play_time"];
    float tmp= [now timeIntervalSinceDate:(NSDate*)[defaults objectForKey:@"since_date"]];
    NSLog(@"前回のプレイ時間は%d分です。",(int)(agoTmp / 60));
    NSLog(@"バックグラウンド経過時間は%d分です。",(int)(tmp / 60));
    int realTmp = tmp + agoTmp;
    int mm = (int)(realTmp / 60);
    mm = mm + restMinute;
    NSLog(@"前回のプレイ時間と差分とバックグラウンド経過時間の合計は%d分です。",mm);
    
    int perThirty = mm % 30;
    
    NSLog(@"今回の差分は%d分です。",perThirty);
    
    int halfHourCount = mm / 30;
    
    [defaults setInteger:perThirty forKey:@"rest_minutes"];
    
    int nowStamina = [defaults integerForKey:@"BBA_stamina"];
    int nowLeval = [defaults integerForKey:@"BBA_level"];
    
    int recovery = 100 * halfHourCount;
    
    if (recovery < 0) {
        recovery = 0;
    }
    
    int recoveryStamina = nowStamina + recovery;
    
    NSLog(@"%d回復しました。",recovery);
    if (nowLeval * 100 < recoveryStamina) {
        recoveryStamina = nowLeval * 100;
    }
    
    [defaults setInteger:recoveryStamina forKey:@"BBA_stamina"];

}

@end
