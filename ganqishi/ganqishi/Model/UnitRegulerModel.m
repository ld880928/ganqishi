//
//  UnitRegulerModel.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-15.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "UnitRegulerModel.h"
#import "FMResultSet.h"

@implementation UnitRegulerModel

- (instancetype)initWithFMResultSet:(FMResultSet *)rs
{
    if ([super init]) {
        self.unit_reguler_id = [rs stringForColumn:@"unit_reguler_id"];
        self.unit_reguler_type = [rs stringForColumn:@"unit_reguler_type"];
        self.unit_reguler_name = [rs stringForColumn:@"unit_reguler_name"];
        self.unit_reguler_ratio = [rs stringForColumn:@"unit_reguler_ratio"];
        self.item_id = [rs stringForColumn:@"item_id"];
    }
    
    return self;
}

@end
