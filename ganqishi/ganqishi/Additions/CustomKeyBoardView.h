//
//  CustomKeyBoardView.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-6.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomKeyBoardView : UIView
+ (CustomKeyBoardView *)sharedCustomKeyBoardView;

- (void)setInputTextFiled:(UITextField *)inputTextFiled;

@end
