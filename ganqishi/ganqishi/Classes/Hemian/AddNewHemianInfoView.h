//
//  AddNewHemianInfoView.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-6.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewHemianInfoView : UIView

@property(copy,nonatomic)void (^saveCallBackBlock)(id info);

- (void)showInView:(UIView *)view_;
- (void)hide;

+ (AddNewHemianInfoView *)AddNewHemianInfoViewWithItems:(NSArray *)items_;

@end
