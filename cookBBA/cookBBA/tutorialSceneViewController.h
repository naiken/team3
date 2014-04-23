//
//  tutorialSceneViewController.h
//  cookBBA
//
//  Created by Doi Daihei on 2014/04/07.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tutorialSceneViewController : UIViewController  {
    
    int tCount;
}
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;


//説明文のテキストを前もって作成。
extern NSString* const kExplanationText[7];


@end
