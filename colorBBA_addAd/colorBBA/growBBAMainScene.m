//
//  growBBAMainScene.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "growBBAMainScene.h"

#define ARC4RANDOM_MAX 0x100000000



@interface growBBAMainScene () {
    CGPoint _frameCenter;
    
    growBBASprite* _BBASprite;
    
    skillDetailBtn* _skillDetail;
    
    NSArray* choices_;
    
    UIPickerView* _skillPicker;
    
    dispatch_once_t lastUpdatedAtInitToken;
    
    CFTimeInterval lastUpdatedAt;
    
    float _update;
    
    SKAction* _randomAct;
    
    CGRect _viewFrame;
    
    NSUserDefaults* _defaults;
    
    NSDate* _now;
    
    SKSpriteNode* _skillDiscriptionField;
    
    SKLabelNode* _explainLabel;
    SKLabelNode* _label_1;
    SKLabelNode* _label_2;
    
}

@end

@implementation growBBAMainScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //ここにシーン表示時したいことを書く。
        _frameCenter = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        _update = 0;
        lastUpdatedAt = 0;
        lastUpdatedAtInitToken = 0;
        
        _defaults = [NSUserDefaults standardUserDefaults];
        
        _skillDiscriptionField = [[SKSpriteNode alloc] initWithImageNamed:@"fukidashi"];
        _skillDiscriptionField.position = CGPointMake(90, _frameCenter.y * 1.34f);
        _skillDiscriptionField.xScale = 0.27f;
        _skillDiscriptionField.yScale = 0.2f;
        
        _explainLabel = [[SKLabelNode alloc] initWithFontNamed:@"STHeitiSC-Medium"];
        _explainLabel.text = @"=特技の説明=";
        _explainLabel.fontColor = [UIColor whiteColor];
        _explainLabel.position = CGPointMake(85, _frameCenter.y * 1.45f);
        _explainLabel.fontSize = 15;
        
        _label_1 = [[SKLabelNode alloc] initWithFontNamed:@"STHeitiSC-Medium"];
        _label_1.text = @"";
        _label_1.fontColor = [UIColor whiteColor];
        _label_1.position = CGPointMake(85, _frameCenter.y * 1.45f - 30);
        _label_1.fontSize = 12;
        
        _label_2 = [[SKLabelNode alloc] initWithFontNamed:@"STHeitiSC-Medium"];
        _label_2.text = @"";
        _label_2.fontColor = [UIColor whiteColor];
        _label_2.position = CGPointMake(85, _frameCenter.y * 1.45f - 60);
        _label_2.fontSize = 12;
        
        //背景
        SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"start_4inch"];
        bg.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        bg.position = _frameCenter;
        [self addChild:bg];

        int getCount = 0;
        
        for (int i = 0; i < 50; i++) {
            BOOL isTresure = [_defaults boolForKey:[NSString stringWithFormat:@"is_Tresure_get_id%d",i]];
            if (isTresure) {
                getCount++;
            }
        }
        
        float getPerWhole = getCount / 50.0;
        int getPer = getPerWhole * 100;
    
        int level = [_defaults integerForKey:@"BBA_level"];
        int bbaStamina = [_defaults integerForKey:@"BBA_stamina"];
        
        SKLabelNode* experience = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        experience.text = [NSString stringWithFormat:@"LV: %d",level];
        experience.fontSize = 18;
        experience.position = CGPointMake(_frameCenter.x * 0.5f, _frameCenter.y * 1.84f);
        [self addChild:experience];
        
        SKLabelNode* stamina = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        stamina.text = [NSString stringWithFormat:@"Stamina: %d", bbaStamina];
        stamina.fontSize = 18;
        stamina.position = CGPointMake(_frameCenter.x * 0.55f, _frameCenter.y * 1.74f);
        [self addChild:stamina];
        
        SKLabelNode* library = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
        library.text = [NSString stringWithFormat:@"Library: %d%%", getPer];
        library.fontSize = 18;
        library.position = CGPointMake(_frameCenter.x * 0.55f, _frameCenter.y * 1.64f);
        [self addChild:library];
        
        _BBASprite = [[growBBASprite alloc] initPos:_frameCenter];
        _BBASprite.delegate = self;
        [self addChild:_BBASprite];

        
        _skillDetail = [[skillDetailBtn alloc] initPos:CGPointMake(_frameCenter.x * 1.5f, _frameCenter.y * 1.8f)];
        _skillDetail.delegate = self;
        [self addChild:_skillDetail];
        
        switch (level) {
            case 5:{
                BOOL isSkill = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_learn_id%d",0]];
                if (!isSkill) {
                    isSkill = YES;
                    [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_learn_id%d",0]];
                    UIAlertView* skillAlert = [self makeAlertView:0 skillId_2:1];
                    skillAlert.tag = 0;
                    [skillAlert show];
                }
            }break;
            
            case 10:{
                BOOL isSkill = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_learn_id%d",1]];
                if (!isSkill) {
                    isSkill = YES;
                    [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_learn_id%d",1]];
                    UIAlertView* skillAlert = [self makeAlertView:2 skillId_2:3];
                    skillAlert.tag = 1;
                    [skillAlert show];
                }
            }break;
                
            case 15:{
                BOOL isSkill = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_learn_id%d",2]];
                if (!isSkill) {
                    isSkill = YES;
                    [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_learn_id%d",2]];
                    UIAlertView* skillAlert = [self makeAlertView:4 skillId_2:5];
                    skillAlert.tag = 2;
                    [skillAlert show];
                }
            }break;
                
            case 20:{
                BOOL isSkill = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_learn_id%d",3]];
                if (!isSkill) {
                    isSkill = YES;
                    [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_learn_id%d",3]];
                    UIAlertView* skillAlert = [self makeAlertView:6 skillId_2:7];
                    skillAlert.tag = 3;
                    [skillAlert show];
                }
            }break;
                
            case 25:{
                BOOL isSkill = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_learn_id%d",4]];
                if (!isSkill) {
                    isSkill = YES;
                    [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_learn_id%d",4]];
                    UIAlertView* skillAlert = [self makeAlertView:8 skillId_2:9];
                    skillAlert.tag = 4;
                    [skillAlert show];
                }
            }break;
                
            case 30:{
                BOOL isSkill = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_learn_id%d",5]];
                if (!isSkill) {
                    isSkill = YES;
                    [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_learn_id%d",5]];
                    UIAlertView* skillAlert = [self makeAlertView:10 skillId_2:11];
                    skillAlert.tag = 5;
                    [skillAlert show];
                }
            }
            default:
                break;
        }
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //タッチされた際、呼ばれます。
    if (_skillPicker) {
        [_skillPicker removeFromSuperview];
        _skillPicker = nil;
        [_skillDiscriptionField removeFromParent];
        [_explainLabel removeFromParent];
        [_label_1 removeFromParent];
        [_label_2 removeFromParent];
    }

}

-(void)update:(CFTimeInterval)currentTime {
    //FPS/1000s毎に呼ばれます。
    // 前回のフレームの更新時刻を記憶しておく
    dispatch_once(&lastUpdatedAtInitToken, ^{
        lastUpdatedAt = currentTime;
    });
    
    // 前回フレーム更新からの経過時刻を計算する
    float timeUpdate = currentTime - lastUpdatedAt;
    lastUpdatedAt = currentTime;
    
    //    NSLog(@"%f", timeUpdate);
    _update += timeUpdate;
    
    if ((int)CGRectGetMaxX(self.frame) <= (int)_BBASprite.position.x) {
        _randomAct = [SKAction moveTo:_frameCenter duration:2.0f];
        _randomAct.timingMode = SKActionTimingLinear;
        _update = 0.0f;
        [_BBASprite runAction:_randomAct];
    }
    if ((int)CGRectGetMaxY(self.frame) <= (int)_BBASprite.position.y) {
        _randomAct = [SKAction moveTo:_frameCenter duration:2.0f];
        _randomAct.timingMode = SKActionTimingEaseIn;
        _update = 0.0f;
        [_BBASprite runAction:_randomAct];
    }
    if ((int)CGRectGetMinX(self.frame) >= (int)_BBASprite.position.x) {
        _randomAct = [SKAction moveTo:_frameCenter duration:2.0f];
        _randomAct.timingMode = SKActionTimingEaseOut;
        _update = 0.0f;
        [_BBASprite runAction:_randomAct];
    }
    if ((int)CGRectGetMinY(self.frame) >= (int)_BBASprite.position.y) {
        _randomAct = [SKAction moveTo:_frameCenter duration:2.0f];
        _randomAct.timingMode = SKActionTimingEaseInEaseOut;
        _update = 0.0f;
        [_BBASprite runAction:_randomAct];
    }
    
    switch ((int)_update % 4) {
        case 3:
            _update = 0.0f;
            if (_randomAct) {
                _randomAct = nil;
            }
            if ((int)(arc4random() % 2)) {
                _randomAct = [growBBASprite moveTo:((float)arc4random() / ARC4RANDOM_MAX)];
                [_BBASprite runAction:_randomAct];
            } else {
                _randomAct = [SKAction waitForDuration:2.0f];
                [_BBASprite runAction:_randomAct];
            }
            break;
            
        default:
            break;
    }
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    int skillId_1 = 0;
    int skillId_2 = 0;
    
    switch (alertView.tag){
        case 0:{
            skillId_1 = 0;
            skillId_2 = 1;
        }break;
            
        case 1:{
            skillId_1 = 2;
            skillId_2 = 3;
        }break;
            
        case 2:{
            skillId_1 = 4;
            skillId_2 = 5;
        }break;
            
        case 3:{
            skillId_1 = 6;
            skillId_2 = 7;
        }break;
            
        case 4:{
            skillId_1 = 8;
            skillId_2 = 9;
        }break;
            
        case 5:{
            skillId_1 = 10;
            skillId_2 = 11;
        }break;
    }
    
    switch (buttonIndex) {
        case 0:{
            BOOL isSkill = YES;
            [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_memory_id%d",skillId_1]];
        }
            break;
            
        default:{
            BOOL isSkill = YES;
            [_defaults setBool:isSkill forKey:[NSString stringWithFormat:@"is_skill_memory_id%d",skillId_2]];
        }
            break;
    }
}

- (void)skillDetailBtn:(skillDetailBtn *)sdBtn {
    
    if (!_skillPicker) {
        
        
        choices_ = [self skillArray];
        if (choices_) {
            _skillPicker = [[UIPickerView alloc] init];
            // delegate,dataSource設定
            _skillPicker.delegate = self;
            _skillPicker.dataSource = self;
            _skillPicker.backgroundColor = [UIColor blackColor];
            _skillPicker.alpha = 0.7f;
            // 選択状態のインジケーターを表示（デフォルト：NO）
            _skillPicker.showsSelectionIndicator = YES;
            // コンポーネント0の指定行を選択状態にする（初期選択状態の設定）
            [_skillPicker selectRow:7 inComponent:0 animated:NO];
        
            _skillPicker.frame = CGRectMake(_frameCenter.x, _frameCenter.y * 0.3f , 150, 100);
            [self.view addSubview:_skillPicker];
            [self addChild:_skillDiscriptionField];
            [self addChild:_explainLabel];
            [self addChild:_label_1];
            [self addChild:_label_2];
        }
    }
}

- (NSArray*)skillArray {
    NSArray* skillArray = [NSArray array];
    NSMutableArray* mutableArray = @[].mutableCopy;
    for (int i = 0; i < 12; i++) {
        BOOL isSkillMemory = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_memory_id%d",i]];
        if (isSkillMemory) {
            NSString* skillStr = [skillManager getSkillName:i];
            [mutableArray addObject:skillStr];
        }
    }
    
    skillArray = (NSArray*)mutableArray;
    return skillArray;
}

- (NSArray*)skillDescriptionArray {
    NSArray* skillArray = [NSArray array];
    NSMutableArray* mutableArray = @[].mutableCopy;
    for (int i = 0; i < 12; i++) {
        BOOL isSkillMemory = [_defaults boolForKey:[NSString stringWithFormat:@"is_skill_memory_id%d",i]];
        if (isSkillMemory) {
            NSString* skillStr = [skillManager getSkillDescription:i];
            [mutableArray addObject:skillStr];
        }
    }
    
    skillArray = (NSArray*)mutableArray;
    return skillArray;
}

- (UIAlertView*)makeAlertView:(int)skillId_1 skillId_2:(int)skillId_2 {
    
    NSString* skillStr_1 = [skillManager getSkillName:skillId_1];
    NSString* skillStr_2 = [skillManager getSkillName:skillId_2];
    
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"特技覚えるで！" message:@"どっちか選びやー！" delegate:self cancelButtonTitle:skillStr_1 otherButtonTitles:skillStr_2, nil];
    return av;
}

- (void)growBBASpriteTouched:(growBBASprite *)BBA {
    //タッチされた際、呼ばれます。
    if (_skillPicker) {
        [_skillPicker removeFromSuperview];
        _skillPicker = nil;
        [_skillDiscriptionField removeFromParent];
        [_explainLabel removeFromParent];
        [_label_1 removeFromParent];
        [_label_2 removeFromParent];
    }

}


#pragma mark - UIPickerViewDataSource

// コンポーネント数（列数）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [choices_ count];
}

#pragma mark - UIPickerViewDelegate

// 表示内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSString* skillName = [choices_ objectAtIndex:row];
    
    UILabel* pickerLabel = [[UILabel alloc] init];
    pickerLabel.text = skillName;
    pickerLabel.textColor = [UIColor whiteColor];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    
    return pickerLabel;
}


// 選択時（くるくる回して止まった時に呼ばれる）
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray* skillDescriptionArray = [[NSArray alloc] initWithArray:[self skillDescriptionArray]];
    if ([skillDescriptionArray isEqual:@[]]) {
        return;
    } else {
        
        NSMutableString* skillDescription = [skillDescriptionArray objectAtIndex:row];
        
        NSString* str_1;
        NSString* str_2;
        
        if ([skillDescription isEqualToString:@"相手のHPの1/4のダメージを与える。"] || [skillDescription isEqualToString:@"相手のHPの1/2のダメージを与える。"]) {
            str_1 = [NSString stringWithString:[skillDescription substringToIndex:10]];
            str_2 = [NSString stringWithString:[skillDescription substringFromIndex:10]];
        } else {
            str_1 = [NSString stringWithString:[skillDescription substringToIndex:6]];
            str_2 = [NSString stringWithString:[skillDescription substringFromIndex:6]];
        }
        _label_1.text = str_1;
        
        _label_2.text = str_2;
    }
}




@end
