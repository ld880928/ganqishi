//
//  ChulongViewController.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-6.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "ChulongViewController.h"
#import "DataBaseManager.h"
#import "DateManager.h"
#import "Models.h"
#import "UIButton+Block.h"
#import "AddNewChulongInfoView.h"

#define BACKGROUND_GRAY [UIColor colorWithRed:.95f green:.95f blue:.95f alpha:1.0f]

#define PRODUCT_CLASS @"出笼"

typedef enum
{
    ProductColumnType_Today = 0,
    ProductColumnType_History
}ProductColumnType;

@interface ChulongViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *infoHearderView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (strong, nonatomic)AddNewChulongInfoView *addNewView;

@property (assign,nonatomic)ProductColumnType productColumnType;
@property (strong,nonatomic)NSArray *items;

@property (strong,nonatomic)NSMutableArray *dataToday;
@property (strong,nonatomic)NSMutableArray *dataHistory;

@property (strong,nonatomic)NSMutableDictionary *unfoldMap;
@end

@implementation ChulongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BACKGROUND_GRAY;
    self.infoTableView.backgroundColor = BACKGROUND_GRAY;
    self.productColumnType = ProductColumnType_Today;
    self.unfoldMap = [NSMutableDictionary dictionary];
    
    //获取和面所有的品项
    self.items = [[DataBaseManager sharedManager] getItemsByClassAndType:PRODUCT_CLASS type:@"c"];
    
    [self refreshData];
}

#pragma mark refresh data
- (void)refreshData
{
    if (self.productColumnType == ProductColumnType_Today) {
        self.dataToday = [[DataBaseManager sharedManager] getProductInfoListByClassAndItems:PRODUCT_CLASS
                                                                                      items:self.items
                                                                                 dateString:[[DateManager sharedManager] todayDateString]];
    }
    else
    {
        self.dataHistory = [[DataBaseManager sharedManager] getProductInfoHistoryListByClassAndItems:PRODUCT_CLASS items:self.items];
        
        for (NSString *key in [self.unfoldMap allKeys]) {
            [self.unfoldMap setValue:[[DataBaseManager sharedManager] getProductInfoListByClassAndItems:PRODUCT_CLASS items:self.items dateString:key] forKey:key];
        }
        
    }
    
    [self refreshInfoHeader];
    [self.infoTableView reloadData];
}

- (void)refreshInfoHeader
{
    for (id v in [self.infoHearderView subviews]) {
        [v removeFromSuperview];
    }
    
    CGFloat item_width = 80.0f;
    
    if (self.productColumnType == ProductColumnType_Today) {
        
        
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, item_width, 44.0f)];
        itemLabel.text = @"时间";
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoHearderView addSubview:itemLabel];
        
        for (int i=0; i<self.items.count; i++) {
            ItemModel *itemModel = [self.items objectAtIndex:i];
            
            itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(item_width + item_width * i, 0, item_width, 44.0f)];
            itemLabel.text = itemModel.item_name;
            itemLabel.textAlignment = NSTextAlignmentCenter;
            [self.infoHearderView addSubview:itemLabel];
        }
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(item_width * (self.items.count + 1), 0, item_width, 44.0f)];
        itemLabel.text = @"操作";
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoHearderView addSubview:itemLabel];
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(item_width * (self.items.count + 2), 0, item_width, 44.0f)];
        itemLabel.text = @"备注";
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoHearderView addSubview:itemLabel];
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(item_width * (self.items.count + 3), 0, item_width, 44.0f)];
        itemLabel.text = @"状态";
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoHearderView addSubview:itemLabel];
    }
    else
    {
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130.0f, 44.0f)];
        itemLabel.text = @"日期";
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoHearderView addSubview:itemLabel];
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(130.0f, 0, item_width, 44.0f)];
        itemLabel.text = @"时间";
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoHearderView addSubview:itemLabel];
        
        for (int i=0; i<self.items.count; i++) {
            ItemModel *itemModel = [self.items objectAtIndex:i];
            
            itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(item_width + item_width * i + 130.0f, 0, item_width, 44.0f)];
            itemLabel.text = itemModel.item_name;
            itemLabel.textAlignment = NSTextAlignmentCenter;
            [self.infoHearderView addSubview:itemLabel];
        }
    }
}

#pragma mark selgmentControl value changed
- (IBAction)segmentControlSelected:(id)sender
{
    UISegmentedControl *control = sender;
    switch (control.selectedSegmentIndex) {
        case 0:   //当天出笼   默认
            self.productColumnType = ProductColumnType_Today;
            break;
        case 1:   //历史出笼
            self.productColumnType = ProductColumnType_History;
            break;
        default:
            break;
    }
    
    [self refreshData];
}

#pragma mark add new 增加出笼信息
- (IBAction)addNew:(id)sender
{
    self.addNewView = [AddNewChulongInfoView AddNewChulongInfoViewWithItems:self.items];
    
    __unsafe_unretained ChulongViewController *safe_self = self;

    [self.addNewView setSaveCallBackBlock:^(id info){
        
    }];
    
    [self.addNewView showInView:self.view];
}

#pragma mark tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.productColumnType == ProductColumnType_Today) {
        return 1;
    }
    else
    {
        return self.dataHistory.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.productColumnType == ProductColumnType_Today) {
        return self.dataToday.count;
    }
    else
    {
        NSString *dateString = [[self.dataHistory objectAtIndex:section] objectForKey:@"date"];
        NSArray *productModels = [self.unfoldMap objectForKey:dateString];
        return productModels.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.productColumnType == ProductColumnType_Today) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024.0f, 60.0f)];
        
        headerView.backgroundColor = [UIColor whiteColor];
        
        NSArray *headers = [self.infoHearderView subviews];
        
        for (int i=0; i<self.items.count; i++) {
            
            int sum = 0;
            for (int j=0; j<self.dataToday.count; j++) {
                
                ProductModel *productModel = [self.dataToday objectAtIndex:j];
                ProductItemRelationModel *productItemRelationModel = [productModel.productItems objectAtIndex:i];
                sum += [productItemRelationModel.product_item_relation_produce intValue];
                
            }
            
            UIView *v = [headers objectAtIndex:i+1];
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
            countLabel.text = [NSString stringWithFormat:@"%d",sum];
            countLabel.textAlignment = NSTextAlignmentCenter;
            [headerView addSubview:countLabel];
        }
        
        return headerView;
    }
    else
    {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024.0f, 60.0f)];
        
        if (section % 2 == 0) {
            headerView.backgroundColor = [UIColor whiteColor];
        }
        else headerView.backgroundColor = BACKGROUND_GRAY;
        
        NSArray *headers = [self.infoHearderView subviews];
        
        NSDictionary *item = [self.dataHistory objectAtIndex:section];
        UIView *v = [headers objectAtIndex:0];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
        timeLabel.text = [item objectForKey:@"date"];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:timeLabel];
        
        NSArray *items_ = [item objectForKey:@"items"];
        
        for (int i=0; i<items_.count; i++) {
            v = [headers objectAtIndex:i+2];
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
            countLabel.text = [NSString stringWithFormat:@"%d",[[items_ objectAtIndex:i] intValue]];
            countLabel.textAlignment = NSTextAlignmentCenter;
            [headerView addSubview:countLabel];
            
        }
        
        UIButton *unfoldBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        unfoldBtn.frame = CGRectMake(130.0f + 80.0f * (items_.count + 1), 10.0f, 60.0f , 40.0f);
        
        NSArray *productModels = [self.unfoldMap objectForKey:[item objectForKey:@"date"]];
        if (productModels && productModels.count)
        {
            [unfoldBtn setTitle:@"收起" forState:UIControlStateNormal];
        }
        else
        {
            [unfoldBtn setTitle:@"展开" forState:UIControlStateNormal];
        }
        [unfoldBtn setTintColor:[UIColor blueColor]];
        
        __unsafe_unretained ChulongViewController *safe_self = self;
        [unfoldBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            NSArray *productModels = [safe_self.unfoldMap objectForKey:[item objectForKey:@"date"]];
            if (productModels && productModels.count) {
                
                [safe_self.unfoldMap removeObjectForKey:[item objectForKey:@"date"]];
            }
            else
            {
                productModels = [[DataBaseManager sharedManager] getProductInfoListByClassAndItems:PRODUCT_CLASS items:safe_self.items dateString:[item objectForKey:@"date"]];
                [safe_self.unfoldMap setValue:productModels forKey:[item objectForKey:@"date"]];
            }
            [safe_self.infoTableView reloadData];
        }];
        
        [headerView addSubview:unfoldBtn];
        
        return headerView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_ID = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    for (UIView * view_ in [cell.contentView subviews]) {
        [view_ removeFromSuperview];
    }
    
    NSArray *headers = [self.infoHearderView subviews];
    
    if (self.productColumnType == ProductColumnType_Today) {
        
        ProductModel *productModel = [self.dataToday objectAtIndex:indexPath.row];
        UIView *v = [headers objectAtIndex:0];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
        timeLabel.text = [[DateManager sharedManager] timeStringFrom:[productModel.product_time doubleValue]];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:timeLabel];
        
        NSArray *items_ = productModel.productItems;
        
        for (int i=0; i<items_.count; i++) {
            v = [headers objectAtIndex:i+1];
            ProductItemRelationModel *productItemRelationModel = [items_ objectAtIndex:i];
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
            countLabel.text = [NSString stringWithFormat:@"%d",[productItemRelationModel.product_item_relation_produce intValue]];
            countLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:countLabel];
            
        }
        
        //操作
        
        
        //备注
        
        
        
        //状态
        
        BOOL isSyn = [productModel.product_syn boolValue];
        
        if (indexPath.row % 2 == 0) {
            cell.contentView.backgroundColor = BACKGROUND_GRAY;
        }else cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    else
    {
        NSString *dateString = [[self.dataHistory objectAtIndex:indexPath.section] objectForKey:@"date"];
        NSArray *productModels = [self.unfoldMap objectForKey:dateString];
        if (productModels) {
            ProductModel *productModel = [productModels objectAtIndex:indexPath.row];
            
            UIView *v = [headers objectAtIndex:1];
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
            timeLabel.text = [[DateManager sharedManager] timeStringFrom:[productModel.product_time doubleValue]];
            timeLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:timeLabel];
            
            NSArray *items_ = productModel.productItems;
            
            for (int i=0; i<items_.count; i++) {
                v = [headers objectAtIndex:i+2];
                ProductItemRelationModel *productItemRelationModel = [items_ objectAtIndex:i];
                UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
                countLabel.text = [NSString stringWithFormat:@"%d",[productItemRelationModel.product_item_relation_produce intValue]];
                countLabel.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:countLabel];
                
            }
            
            //操作
            
            
            //备注
            
            
            
            //状态
            
            BOOL isSyn = [productModel.product_syn boolValue];
            
            
        }
        
        if (indexPath.section % 2 == 0) {
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
        }else cell.contentView.backgroundColor = BACKGROUND_GRAY;
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

@end
