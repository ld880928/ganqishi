//
//  ProductRemarkModel.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "ProductRemarkModel.h"
#import "FMResultSet.h"

@implementation ProductRemarkModel

- (instancetype)initWithFMResultSet:(FMResultSet *)rs
{
    if ([super init]) {
        self.product_id = [rs stringForColumn:@"product_id"];
        self.product_remark_content = [rs stringForColumn:@"product_remark_content"];
        self.product_remark_id = [rs stringForColumn:@"product_remark_id"];
        self.product_remark_time = [rs objectForColumnName:@"product_remark_time"];
    }
    
    return self;
}
@end
