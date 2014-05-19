//
//  CustomKeyBoardView.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-6.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "CustomKeyBoardView.h"

@interface CustomKeyBoardView()
@property(nonatomic,weak)UITextField *inputTextFiled;
@end

@interface CustomKeyBoardView()
- (IBAction)deletePressed:(id)sender;
- (IBAction)prePressed:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)closePressed:(id)sender;
- (IBAction)pointPressed:(id)sender;
- (IBAction)numPressed:(id)sender;

@end

@implementation CustomKeyBoardView

+ (CustomKeyBoardView *)sharedCustomKeyBoardView
{
    static CustomKeyBoardView *sharedCustomKeyBoardViewInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedCustomKeyBoardViewInstance = [[[NSBundle mainBundle] loadNibNamed:@"CustomKeyBoardView" owner:self options:nil] lastObject];
    });
    return sharedCustomKeyBoardViewInstance;
}

- (void)setInputTextFiled:(UITextField *)inputTextFiled
{
    _inputTextFiled = inputTextFiled;
}

- (IBAction)deletePressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
	[self.inputTextFiled deleteBackward];
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.inputTextFiled];
}

- (IBAction)prePressed:(id)sender
{
    
}

- (IBAction)nextPressed:(id)sender
{
    
}

- (IBAction)closePressed:(id)sender
{
    [self.inputTextFiled resignFirstResponder];
}

- (IBAction)pointPressed:(id)sender
{
    [[UIDevice currentDevice] playInputClick];
    [self.inputTextFiled insertText:@"."];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.inputTextFiled];
}

- (IBAction)numPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
    [self.inputTextFiled insertText:[NSString stringWithFormat:@"%d",[sender tag]]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.inputTextFiled];
}
@end