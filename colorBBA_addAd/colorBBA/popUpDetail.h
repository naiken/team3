//
//  popUpDetail.h
//  colorBBA
//
//  Created by 池田　春菜 on 2014/05/26.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class popUpDetail;
@protocol popUpDetailDelegate 


-(void)touchToPopUpDetail:(popUpDetail*)popUp;

@end



@interface popUpDetail : UIView

@property (weak) id delegate;

@end
