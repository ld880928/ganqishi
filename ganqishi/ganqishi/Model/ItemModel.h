//
//  ItemModel.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-9.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;
@class UnitRegulerModel;

@interface ItemModel : NSObject
@property(nonatomic,strong)NSString *item_id;
@property(nonatomic,strong)NSString *item_type;
@property(nonatomic,strong)NSString *item_class;
@property(nonatomic,strong)NSString *item_unit;
@property(nonatomic,strong)NSString *item_name;
@property(nonatomic,strong)UnitRegulerModel *unitReguler;

- (instancetype)initWithFMResultSet:(FMResultSet *)rs;

@end
