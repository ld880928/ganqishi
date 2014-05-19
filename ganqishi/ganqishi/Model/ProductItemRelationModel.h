//
//  ProductItemRelationModel.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductItemRelationModel : NSObject

@property(nonatomic,strong)NSString *product_item_relation_id;
@property(nonatomic,strong)NSString *item_id;
@property(nonatomic,strong)NSString *product_id;
@property(nonatomic,strong)NSNumber *product_item_relation_produce;

@end
