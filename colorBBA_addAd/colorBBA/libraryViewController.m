//
//  libraryViewController.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

//
//  libraryViewController.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "libraryViewController.h"

@interface libraryViewController () {
    
    CGRect _libraryViewRect;
    
    NSArray* _libraryViewArray;
    
    UIView* _pageWholeView;
    
    UIButton* _bt;
    
    NSArray* _buttonBox;
    
    NSString* _monsterName;
    NSString* _monsterDescription;
    
    NSArray* _monsterNameArray;
    NSArray* _monsterDescriptionArray;
}

@end

@implementation libraryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialization code
    _libraryViewRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    
    _pageWholeView = [[UIView alloc] initWithFrame:CGRectMake(_libraryViewRect.origin.x, _libraryViewRect.origin.y, kPageViewWidth * 10, kPagingScrollViewHeight)];
    
    // ページングスクロールビューを生成
    _pagingScrollView = [[UIScrollView alloc] init];
    _pagingScrollView.frame = _libraryViewRect;
    _pagingScrollView.contentSize = CGSizeMake(kPageViewWidth * kNumberOfPages, kPagingScrollViewHeight);
    _pagingScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // ページごとのスクロールにする
    _pagingScrollView.pagingEnabled = YES;
    // スクロールバーを非表示にする
    _pagingScrollView.showsHorizontalScrollIndicator = YES;
    _pagingScrollView.showsVerticalScrollIndicator = YES;
    // ステータスバータップでトップにスクロールする機能をOFFにする
    _pagingScrollView.scrollsToTop = NO;
    
    // ページングスクロールビューのdelegateメソッドを使えるように設定
    _pagingScrollView.delegate = self;
    
    for (int i = 0; i < kNumberOfPages; i++) {
        UILabel* pageName = [[UILabel alloc] initWithFrame:CGRectMake((kPageViewWidth * i) + 100, kPagingScrollViewHeight - 30, 120, 20)];
        pageName.backgroundColor = [UIColor blackColor];
        pageName.alpha = 0.8f;
        pageName.text = [NSString stringWithFormat:@"%d / 10", i + 1];
        pageName.textAlignment = NSTextAlignmentCenter;
        pageName.font = [UIFont fontWithName:@"Papyrus" size:17];
        pageName.textColor = [UIColor whiteColor];
        [_pageWholeView addSubview:pageName];
    }
    [_pagingScrollView addSubview:_pageWholeView];
    
    // ページングスクロールビューをaddSubview
    [self.view addSubview:_pagingScrollView];
    
    int n = 0; //ページ数
    NSMutableArray* mutableBtnBox = @[].mutableCopy;
    NSMutableArray* mutableMonsterNameBox = @[].mutableCopy;
    NSMutableArray* mutableMonsterDescriptionBox = @[].mutableCopy;
    
    for (int i = 0; i < 50; i++) {
        
        //取ったか取ってないかを判断。
        BOOL isTresure = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"is_Tresure_get_id%d",i]];
        
        //        int position;
        int x = 0, y = 0;
        
        //ダンジョン1~5のモンスター 4体ずつ
        if (0 <= i && i < 20) {
            
            if (i == 0 || i%4 == 0 ) {
                n++;
                x = 40 + 320*(n-1);
                y = 85;
            }
            else if ( i == 1 || i%4 == 1 ) {
                x = 160 + 320*(n-1);
                y = 85;
            }
            else if ( i == 2 || i%4 == 2 ) {
                x = 40 + 320*(n-1);
                y = 265;
            }
            else if ( i == 3 || i%4 == 3 ) {
                x = 160 + 320*(n-1);
                y = 265;
            }
        }
        
        //ダンジョン6~10のモンスター 6体ずつ
        else {
            
            if ( i-20 == 0 || (i-20)%6 == 0 ) {
                n++;
                x = 40 + 320*(n-1);
                y = 50;
            }
            else if ( i-20 == 1 || (i-20)%6 == 1 ) {
                x = 160 + 320*(n-1);
                y = 50;
            }
            else if ( i-20 == 2 || (i-20)%6 == 2 ) {
                x = 40 + 320*(n-1);
                y = 175;
            }
            else if ( i-20 == 3 || (i-20)%6 == 3 ) {
                x = 160 + 320*(n-1);
                y = 175;
            }
            else if ( i-20 == 4 || (i-20)%6 == 4 ) {
                x = 40 + 320*(n-1);
                y = 300;
            }
            else if ( i-20 == 5 || (i-20)%6 == 5 ) {
                x = 160 + 320*(n-1);
                y = 300;
            }
            
        }
        
        if (isTresure) {
            UIButton *bt =[UIButton buttonWithType:UIButtonTypeRoundedRect];
            NSString *imageName = [monsterManager getImageName:i];
            UIImage *img = [UIImage imageNamed:imageName];
            
            
            NSString* monsterName = [monsterManager getMonsterName:i];
            NSString* monsterDescription = [monsterManager getDescription:i];
            
            bt.frame = CGRectMake(x, y, 100, 100);
            [bt setBackgroundImage:img forState:UIControlStateNormal];
            bt.tag = i;
            [bt addTarget:self action:@selector(popUpDetail:) forControlEvents:UIControlEventTouchUpInside];
            [mutableBtnBox addObject:bt];
            [mutableMonsterNameBox addObject:monsterName];
            [mutableMonsterDescriptionBox addObject:monsterDescription];
            [_pageWholeView addSubview:bt];
            
        } else {
            UIButton *bt =[UIButton buttonWithType:UIButtonTypeRoundedRect];
            bt.frame = CGRectMake(x, y, 100, 100);
            UIImage* img = [UIImage imageNamed:@"library_hatena.png"];
            
            NSString* monsterName = [monsterManager getMonsterName:i];
            NSString* monsterDescription = [monsterManager getDescription:i];
            
            [bt setBackgroundImage:img forState:UIControlStateNormal];
            bt.userInteractionEnabled = NO;
            bt.tag = i;
            [bt addTarget:self action:@selector(popUpDetail:) forControlEvents:UIControlEventTouchUpInside];
            [mutableBtnBox addObject:bt];
            [mutableMonsterNameBox addObject:monsterName];
            [mutableMonsterDescriptionBox addObject:monsterDescription];
            [_pageWholeView addSubview:bt];
        }
    }
    
    _buttonBox = (NSArray*)mutableBtnBox;
    _monsterNameArray = (NSArray*)mutableMonsterNameBox;
    _monsterDescriptionArray = (NSArray*)mutableMonsterDescriptionBox;
    
    // ページコントロール
    // ページングスクロールビューの下にページコントロールを配置
    _pager = [[UIPageControl alloc] initWithFrame:CGRectMake(20, kPagingScrollViewHeight, 280, kPagerHeight)];
    // 現在ページを示す点は白なので、見えやすいように背景を黒に設定
    _pager.backgroundColor = [UIColor blackColor];
    // ページ数を指定
    _pager.numberOfPages = kNumberOfPages;
    // ページ番号は0ページを指定(1にするとこの場合真ん中のページが指定される)
    _pager.currentPage = 0;
    // ページが1ページのみの場合は現在ページを示す点を表示しない
    _pager.hidesForSinglePage = NO;
    [self.view addSubview:_pager];
    
    // ページコントロールの値が変わったときのアクションを登録
    [_pager addTarget:self action:@selector(changePageControl:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)popUpDetail:(UIButton*)bt {
    popUpDetail* detailView = [[popUpDetail alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height/2 - 255 , 300, 400)];
    detailView.backgroundColor = [UIColor blackColor];
    detailView.delegate = self;
    detailView.userInteractionEnabled = YES;
    detailView.alpha = 0.95f;
    
    //図鑑詳細ポップアップ画像とラベル
    NSString *detailImage = [monsterManager getImageName:(int)bt.tag];
    UIImageView *monsterImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:detailImage]];
    CGRect rect = CGRectMake(self.view.frame.size.width/2 - 110, self.view.frame.size.height/2 - 250, DETAIL_WIDTH, DETAIL_HEIGHT);
    monsterImage.frame = rect;
    
    NSString* monsterName = [_monsterNameArray objectAtIndex:bt.tag];
    NSString* monsterDescription = [_monsterDescriptionArray objectAtIndex:bt.tag];
    NSMutableString* monsterMutableName = monsterName.mutableCopy;
    NSMutableString* monsterMutableDescription = monsterDescription.mutableCopy;
    [monsterMutableName appendString:@"\n"];
    [monsterMutableName insertString:@"名前:" atIndex:0];
    [monsterMutableName appendString:monsterMutableDescription];
    monsterName = (NSString*)monsterMutableName;
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 135, self.view.frame.size.height/2 -20 , 250, 100)];
    detailLabel.text = monsterName;
    detailLabel.textColor = [UIColor redColor];
    detailLabel.backgroundColor = [UIColor whiteColor];
    detailLabel.numberOfLines = 6;
    detailLabel.adjustsFontSizeToFitWidth = YES;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:17];
    
    //スクロールビューのタッチを有効にする
    self.view.userInteractionEnabled = YES;
    
    [self popupView:detailView];
    [self.view addSubview:detailView];
    [detailView addSubview:monsterImage];
    [detailView addSubview:detailLabel];
    
}

- (void)touchToPopUpDetail:(popUpDetail *)popUp {
    [popUp removeFromSuperview];
}

//ポップアップの動き
- (void)popupView:(UIView *)view
{
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5f,0.5f);
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2f,1.2f);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9f,0.9f);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.2
                                                                    delay:0.0
                                                                  options:UIViewAnimationOptionCurveEaseOut
                                                               animations:^{
                                                                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0f,1.0f);
                                                               }
                                                               completion:nil
                                               ];
                                          }
                          ];
                     }
     ];
}

/**
 * ページコントロール変更時処理
 */
- (void)changePageControl:(id)sender {
    
    // ページコントロールが変更された場合、それに合わせてページングスクロールビューを該当ページまでスクロールさせる
    CGRect frame = _pagingScrollView.frame;
    frame.origin.x = frame.size.width * _pager.currentPage;
    frame.origin.y = 0;
    // 可視領域まで移動
    [_pagingScrollView scrollRectToVisible:frame animated:YES];
}

/**
 * ページングスクロールビュー変更時処理(UIScrollViewのdelegateメソッド)
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // UIScrollViewのページ切替時イベント:UIPageControlの現在ページを切り替える処理
    _pager.currentPage = _pagingScrollView.contentOffset.x / kPageViewWidth;
}




@end
