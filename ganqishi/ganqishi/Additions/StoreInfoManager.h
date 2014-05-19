//
//  StoreInfoManager.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreInfoManager : NSObject

+ (StoreInfoManager *)sharedManager;

- (NSString *)getStoreID;
@end
