//
//  ViewController.m
//  cupBBA
//
//  Created by Hata Rie on 2014/04/18.
//  Copyright (c) 2014年 Rie Hata. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize bgm001VoiceURL;
@synthesize bgm001VoiceID;
@synthesize bgm002VoiceURL;
@synthesize bgm002VoiceID;
@synthesize bgm003VoiceURL;
@synthesize bgm003VoiceID;
@synthesize bgm004VoiceURL;
@synthesize bgm004VoiceID;
@synthesize bgm005VoiceURL;
@synthesize bgm005VoiceID;
@synthesize bgm006VoiceURL;
@synthesize bgm006VoiceID;
@synthesize bgm007VoiceURL;
@synthesize bgm007VoiceID;
@synthesize bgm008VoiceURL;
@synthesize bgm008VoiceID;
@synthesize piiiVoiceURL;
@synthesize piiiVoiceID;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(update)
                                             userInfo:nil
                                              repeats:YES];
    isStart = NO;
    isFstCalled = NO;
    
    [self initLabel];
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    
    bgm001VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm001"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm001VoiceURL, &bgm001VoiceID);
    CFRelease(bgm001VoiceURL);
    
    bgm002VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm002"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm002VoiceURL, &bgm002VoiceID);
    CFRelease(bgm002VoiceURL);
    
    bgm003VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm003"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm003VoiceURL, &bgm003VoiceID);
    CFRelease(bgm003VoiceURL);
    
    bgm004VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm004"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm004VoiceURL, &bgm004VoiceID);
    CFRelease(bgm004VoiceURL);
    
    bgm005VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm005"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm005VoiceURL, &bgm005VoiceID);
    CFRelease(bgm005VoiceURL);
    
    bgm006VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm006"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm006VoiceURL, &bgm006VoiceID);
    CFRelease(bgm006VoiceURL);
    
    bgm007VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm007"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm007VoiceURL, &bgm007VoiceID);
    CFRelease(bgm007VoiceURL);
    
    bgm008VoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("bgm008"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(bgm008VoiceURL, &bgm008VoiceID);
    CFRelease(bgm008VoiceURL);
    
    piiiVoiceURL = CFBundleCopyResourceURL(mainBundle, CFSTR("piii"), CFSTR("mp3"), NULL);
    AudioServicesCreateSystemSoundID(piiiVoiceURL, &piiiVoiceID);
    CFRelease(piiiVoiceURL);
    
    [appCCloud setupAppCWithMediaKey:@"69798bbfdd434b25535c2a7d59dda0ed0205cc77" option:APPC_CLOUD_AD];
    
    appCSimpleView* apcSimpleView = [[appCSimpleView alloc] initWithViewController:self vertical:appCVerticalBottom];
    
    [self.view addSubview:apcSimpleView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)getRandInt:(int)min max:(int)max {
	static int randInitFlag;
	if (randInitFlag == 0) {
		srand(time(NULL));
		randInitFlag = 1;
	}
	return min + (int)(rand()*(max-min+1.0)/(1.0+RAND_MAX));
}

- (void)initLabel
{
    self.labelWidth = 130;
    self.labelHeight = 50;
    // self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.labelWidth, self.labelHeight)];
    self.timeLabel.text = @"00:00";
    // [self.view addSubview:self.timeLabel];
}

- (IBAction)timerStartAction:(id)sender {
    if (isStart) { // 画像がSTOPの時に押下
        [myTimer fire];
        
        UIImage *image = [UIImage imageNamed:@"startbtn.png"];
        [self.startBtn setImage:image forState:UIControlStateNormal];
        
    } else {           // 画像がSTARTの時に押下
        UIImage *image = [UIImage imageNamed:@"stopbtn.png"];
        [self.startBtn setImage:image forState:UIControlStateNormal];
        
    }
    isStart = !isStart;
}


- (IBAction)timerResetAction:(id)sender {
    
    if (!isStart) {
    [self initLabel];
    [myTimer invalidate];
    myTimer = [[NSTimer alloc] init];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(update)
                                             userInfo:nil
                                              repeats:YES];
    }else if (isStart) {
        isStart = !isStart;
        UIImage *image = [UIImage imageNamed:@"startbtn.png"];
        [self.startBtn setImage:image forState:UIControlStateNormal];
    }
    minTime = 0;
    secTime = 0;
}

- (IBAction)bbaVoice:(id)sender {
    if (minTime == 0) {
        NSInteger bba_a = arc4random() % 2;
        if (bba_a==0){
            AudioServicesPlaySystemSound(bgm001VoiceID);
        }
        else if (bba_a==1){
            AudioServicesPlaySystemSound(bgm002VoiceID);
        }
    } else if (minTime == 1) {
        NSInteger bba_b = arc4random() % 2;
        if (bba_b==0){
            AudioServicesPlaySystemSound(bgm003VoiceID);
        }
        else if (bba_b==1){
            AudioServicesPlaySystemSound(bgm004VoiceID);
        }
    } else if (minTime == 2) {
        NSInteger bba_c = arc4random() % 2;
        if (bba_c==0){
            AudioServicesPlaySystemSound(bgm005VoiceID);
        }
        else if (bba_c==1){
            AudioServicesPlaySystemSound(bgm006VoiceID);
        }
    } else {
        NSInteger bba_d = arc4random() % 2;
        if (bba_d==0){
            AudioServicesPlaySystemSound(bgm007VoiceID);
        }
        else if (bba_d==1){
            AudioServicesPlaySystemSound(bgm008VoiceID);
        }
        
    }
}

- (void)update{
    if (isStart) {
        secTime++;
        if (secTime == 60) {
            if (minTime == 2) {
                isStart = NO;
                minTime = 3;
                [myTimer invalidate];
                myTimer = nil;
                AudioServicesPlaySystemSound(piiiVoiceID);
            }
            else{
                minTime++;
            }
            secTime = 0;
        }
        self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",minTime,secTime];
    }
    else{
        self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",minTime,secTime];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
