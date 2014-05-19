//
//  ProductRemarkModel.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;

@interface ProductRemarkModel : NSObject

@property(nonatomic,strong)NSString *product_remark_id;
@property(nonatomic,strong)NSNumber *product_remark_time;
@property(nonatomic,strong)NSString *product_remark_content;
@property(nonatomic,strong)NSString *product_id;

- (instancetype)initWithFMResultSet:(FMResultSet *)rs;
@end
