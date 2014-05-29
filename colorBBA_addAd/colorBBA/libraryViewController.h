//
//  libraryViewController.h
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "monsterManager.h"
#import "popUpDetail.h"


#define kPagingScrollViewHeight  490  // スクロールビューのheight(ページコントロールは除外)
#define kPageViewWidth           320  // 各ページビューのwidth
#define kPagerHeight             20   // UIPageControlのheight
#define kNumberOfPages           10    // ページ数
#define BUTTON_HEIGHT            100  //図鑑ボタン高さ
#define BUTTON_WIDTH             100  //図鑑ボタン横幅
#define DETAIL_HEIGHT            200  //図鑑詳細ポップアップの高さ
#define DETAIL_WIDTH             200  //図鑑詳細ポップアップの横幅

@interface libraryViewController : UIViewController <UIScrollViewDelegate, popUpDetailDelegate>  {
    
    UIScrollView* _pagingScrollView;   // ページング用スクロールビュー((320*10) * 490)
    UIPageControl* _pager;             // ページコントロール
}

@end