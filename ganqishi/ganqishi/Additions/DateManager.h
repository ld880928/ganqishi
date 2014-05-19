//
//  DateManager.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-13.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject

+ (DateManager *)sharedManager;

- (NSString *)dateStringFrom:(NSDate *)date_;

- (NSString *)timeStringFrom:(NSTimeInterval)timeInterval_;

- (NSDate *)now;

- (NSString *)todayDateString;

@end
