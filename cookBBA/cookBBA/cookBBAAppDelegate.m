//
//  cookBBAAppDelegate.m
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "cookBBAAppDelegate.h"


@implementation cookBBAAppDelegate

@synthesize window = _window;
@synthesize BGMPlayer = _BGMPlayer;
//@synthesize delegate = _delegate;

static NSString* const BGM_KEY = @"bgm_boolean_key";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //音楽の再生用意
    soundMusic* sound = [[soundMusic alloc] init];
    _BGMPlayer = [sound backGroundMusicPlay];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:BGM_KEY];
    
//    scoreSceneViewController* sc = [[scoreSceneViewController alloc] init];
    
//    [sc setDelegate:self];
    
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    BOOL bgmPlaying = NO;
//    [defaults setBool:bgmPlaying forKey:BGM_KEY];
    
    return YES;
}

////bgmが動作していたらoffにするデリゲートメソッド
//- (void)stopBgmOrPlayBGM {
//    if (_BGMPlayer.playing) {
//        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//        BOOL bgmPlaying = NO;
//        [defaults setBool:bgmPlaying forKey:BGM_KEY];
//        
//        [_BGMPlayer pause];
//    }else {
//        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//        BOOL bgmPlaying = YES;
//        [defaults setBool:bgmPlaying forKey:BGM_KEY];
//        
//        [_BGMPlayer play];
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)]) {
        backgroundSupported = device.multitaskingSupported;
    }
    if (backgroundSupported) {
        [GFController backgroundTask];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [GFController conversionCheckStop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [GFController activateGF:@"5567" useCustom:NO useIcon:YES usePopup:NO];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
