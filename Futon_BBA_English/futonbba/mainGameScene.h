//
//  HelloWorldMyScene.h
//  FutonBBA
//

//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "dropSomethig.h"
#import "insectDrop.h"
#import "BBADrop.h"
#import "yellowInsect.h"
#import "purpleInsect.h"
#import "bombDrop.h"
#import "GameOverScene.h"

@interface mainGameScene : SKScene<dropSomethingDelegate, insectDropDelegate, BBADropDelegate, yellowInsectDelegate, purpleInsectDelegate, bombDropDelegate>

+ (mainGameScene*)sharedManager;

- (void)setDsArray:(NSArray*)dsarray;

@property NSMutableArray *itemTextures;

@end
