//
//  colorBall.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/05.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "colorBall.h"

@implementation colorBall

//@synthesize touchColorBallBox;

- (id)initMaterial:(CGPoint)position setColor:(UIColor*)color {
    self = [super init];
    if (self) {
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"colorBall" ofType:@"sks"]];
        self.particleColorSequence = nil;
        self.particleColorBlendFactor = 1.0;
        self.particleColor = color;
        self.position = position;
    }
    
    return self;
}

- (id)initComposeBall:(CGPoint)position setColor:(UIColor *)color {
    self = [super init];
    if (self) {
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"composeBall" ofType:@"sks"]];
        self.particleColorSequence = nil;
        self.particleColorBlendFactor = 1.0;
        self.particleColor = color;
        self.position = position;
    }
    
    return self;
}

- (id)initComposeEffect:(CGPoint)position setColor:(UIColor *)color {
    self = [super init];
    if (self) {
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"composeEffect" ofType:@"sks"]];
        self.particleColorSequence = nil;
        self.particleColorBlendFactor = 1.0;
        self.particleColor = color;
        self.position = position;
    }
    
    return self;
}

- (id)initRecoverEffect:(CGPoint)position setColor:(UIColor*)color {
    self = [super init];
    if (self) {
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"recover" ofType:@"sks"]];
        self.particleColorSequence = nil;
        self.particleColorBlendFactor = 1.0;
        self.particleColor = color;
        self.position = position;
    }
    
    return self;
}



@end
