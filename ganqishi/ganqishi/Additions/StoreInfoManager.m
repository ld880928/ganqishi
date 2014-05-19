//
//  StoreInfoManager.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "StoreInfoManager.h"
#import "GanqishiStoreInfoKey.h"

@implementation StoreInfoManager
+ (StoreInfoManager *)sharedManager
{
    static StoreInfoManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (NSString *)getStoreID
{
    return @"test";
}
@end
