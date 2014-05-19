//
//  StepInputView.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-13.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "StepInputView.h"
#import "CustomKeyBoardView.h"

@interface StepInputView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextFiled;

@end
@implementation StepInputView

- (void)setPosition:(CGPoint)position_
{
    self.frame = CGRectMake(position_.x, position_.y, self.frame.size.width, self.frame.size.height);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (void)setInputValue:(NSNumber *)inputValue_
{
    self.inputTextFiled.text = [NSString stringWithFormat:@"%d",[inputValue_ intValue]];
}

- (id)getInputValue
{
    return [NSNumber numberWithInt:[self.inputTextFiled.text intValue]];
}

- (void)awakeFromNib
{    
    self.layer.cornerRadius = 5.0f;
    self.backgroundColor = [UIColor colorWithRed:.95f green:.95f blue:.95f alpha:1.0f];
    self.inputTextFiled.inputView = [CustomKeyBoardView sharedCustomKeyBoardView];
    
    self.inputTextFiled.delegate = self;
    //隐藏光标  ios 7
    self.inputTextFiled.tintColor = [UIColor clearColor];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    self.inputTextFiled.font = [UIFont boldSystemFontOfSize:15.0f];
    [[CustomKeyBoardView sharedCustomKeyBoardView] setInputTextFiled:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.inputTextFiled.font = [UIFont systemFontOfSize:15.0f];
}

@end
