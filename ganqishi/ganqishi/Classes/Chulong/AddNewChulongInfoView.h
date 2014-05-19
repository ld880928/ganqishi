//
//  AddNewChulongInfoView.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-15.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewChulongInfoView : UIView
@property(copy,nonatomic)void (^saveCallBackBlock)(id info);

- (void)showInView:(UIView *)view_;
- (void)hide;

+ (AddNewChulongInfoView *)AddNewChulongInfoViewWithItems:(NSArray *)items_;

@end
