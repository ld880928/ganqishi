//
//  UnitRegulerModel.h
//  ganqishi
//
//  Created by jijeMac2 on 14-5-15.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;

@interface UnitRegulerModel : NSObject
@property(nonatomic,strong)NSString *unit_reguler_id;
@property(nonatomic,strong)NSString *unit_reguler_type;
@property(nonatomic,strong)NSString *unit_reguler_name;
@property(nonatomic,strong)NSString *unit_reguler_ratio;
@property(nonatomic,strong)NSString *item_id;

- (instancetype)initWithFMResultSet:(FMResultSet *)rs;
@end
