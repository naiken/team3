//
//  tresureNode.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/22.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "tresureNode.h"

@implementation tresureNode

- (id)init:(CGPoint)position imageName:(NSString *)IN {
    self = [super init];
    if (self) {
        self = [tresureNode spriteNodeWithImageNamed:IN];
        self.position = position;
        self.xScale = 0.25f;
        self.yScale = 0.25f;
    }
    
    return self;
}
@end
