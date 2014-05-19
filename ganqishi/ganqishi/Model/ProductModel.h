//
//  ProductModel.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property(nonatomic,strong)NSString *product_id;
@property(nonatomic,strong)NSString *product_class;
@property(nonatomic,strong)NSNumber *product_time;
@property(nonatomic,strong)NSNumber *product_syn;

@property(nonatomic,strong)NSString *product_date;

@property(nonatomic,strong)NSArray *productItems;
@property(nonatomic,strong)NSArray *productRemarks;
@end
