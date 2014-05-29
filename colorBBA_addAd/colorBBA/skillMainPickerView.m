//
//  skillMainPickerView.m
//  colorBBA
//
//  Created by Doi Daihei on 2014/05/11.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "skillMainPickerView.h"

@interface skillMainPickerView ()
@property (strong, nonatomic) NSArray *choices_;
@end

@implementation skillMainPickerView

- (id)initWithFrame:(CGRect)frame
{
    /*
     選択されたコンポーネントの取得
     [pickerView selectedRowInComponent:0]
     */
    self = [super initWithFrame:frame];
    if (self) {
        // UIPickerViewに表示する内容
        self.choices_ = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July",
                          @"August", @"September", @"October", @"November", @"December"];
        
        self = [[skillMainPickerView alloc] init];
        
        // delegate,dataSource設定
        self.delegate = self;
        self.dataSource = self;
        // 選択状態のインジケーターを表示（デフォルト：NO）
        self.showsSelectionIndicator = YES;
        // コンポーネント0の指定行を選択状態にする（初期選択状態の設定）
        [self selectRow:7 inComponent:0 animated:NO];
        
//        self.center = self.view.center;
//        [self.view addSubview:pickerView];
        
    }
    return self;
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
    return [self.choices_ count];
}

#pragma mark - UIPickerViewDelegate

// 表示内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.choices_ objectAtIndex:row];
}

// 選択時（くるくる回して止まった時に呼ばれる）
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"selected: %@", [self.choices_ objectAtIndex:row]);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
