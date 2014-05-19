//
//  ItemModel.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "ItemModel.h"
#import "FMResultSet.h"

@implementation ItemModel

- (instancetype)initWithFMResultSet:(FMResultSet *)rs
{
    if ([super init]) {
        self.item_id = [rs stringForColumn:@"item_id"];
        self.item_class = [rs stringForColumn:@"item_class"];
        self.item_type = [rs stringForColumn:@"item_type"];
        self.item_unit = [rs stringForColumn:@"item_unit"];
        self.item_name = [rs stringForColumn:@"item_name"];
    }
    
    return self;
}
@end
