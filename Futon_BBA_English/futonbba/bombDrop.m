//
//  bombDrop.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/15/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import "bombDrop.h"

@implementation bombDrop

@synthesize  delegate = _delegate;

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([_delegate respondsToSelector:@selector(bombDropTouched:)]) {
        [_delegate bombDropTouched:self];
    }
}

@end
