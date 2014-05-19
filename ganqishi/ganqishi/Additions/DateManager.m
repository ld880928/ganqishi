//
//  DateManager.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-13.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "DateManager.h"

@interface DateManager()
@property(nonatomic,strong)NSDateFormatter *dateFormater;
@property(nonatomic,strong)NSDateComponents *dateComponets;
@end

@implementation DateManager

+ (DateManager *)sharedManager
{
    static DateManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        sharedAccountManagerInstance.dateFormater = [[NSDateFormatter alloc] init];
        sharedAccountManagerInstance.dateComponets = [[NSDateComponents alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [sharedAccountManagerInstance.dateFormater setTimeZone:timeZone];

    });
    return sharedAccountManagerInstance;
}

- (NSDate *)now
{
    return [NSDate date];
}

- (NSString *)todayDateString
{
    NSDate *now = [self now];
    return [self dateStringFrom:now];
}

- (NSString *)dateStringFrom:(NSDate *)date_
{
    [self.dateFormater setDateFormat:@"yyyy-MM-dd"];//这里去掉 具体时间 保留日期
    return [self.dateFormater stringFromDate:date_];
}

- (NSString *)timeStringFrom:(NSTimeInterval)timeInterval_
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval_];
    [self.dateFormater setDateFormat:@"HH:mm"];
    return [self.dateFormater stringFromDate:date];
}

@end
