//
//  AddNewHemianInfoView.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-6.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "AddNewHemianInfoView.h"
#import "Models.h"
#import "StepInputView.h"
#import "DataBaseManager.h"
#import "DateManager.h"

#define BACKGROUND_GRAY [UIColor colorWithRed:.95f green:.95f blue:.95f alpha:1.0f]

@interface AddNewHemianInfoView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *items;
@property (weak, nonatomic) IBOutlet UIView *infoHearderView;

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (strong,nonatomic)NSArray *infoDataArray;

@property(strong,nonatomic) NSMutableArray *inputsArray;

- (IBAction)standardFormula:(id)sender;
@end

@implementation AddNewHemianInfoView

- (void)showInView:(UIView *)view_
{
    self.frame = CGRectMake(0, 768.0f, self.bounds.size.width, self.bounds.size.height);
    [view_ addSubview:self];
    
    [UIView animateWithDuration:.5f animations:^{
        self.frame = CGRectMake(0, 64.0f, self.bounds.size.width, self.bounds.size.height);
    }];
}

- (void)hide
{
    [UIView animateWithDuration:.5f animations:^{
        self.frame = CGRectMake(0, 768.0f, self.bounds.size.width, self.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (AddNewHemianInfoView *)AddNewHemianInfoViewWithItems:(NSArray *)items_
{
    AddNewHemianInfoView *addNewHemianInfoView = [[[NSBundle mainBundle] loadNibNamed:@"AddNewHemianInfoView" owner:self options:nil] lastObject];
    
    addNewHemianInfoView.inputsArray = [NSMutableArray array];
    
    addNewHemianInfoView.items = items_;
    
    UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 44.0f)];
    itemLabel.text = @"时间";
    itemLabel.textAlignment = NSTextAlignmentCenter;
    [addNewHemianInfoView.infoHearderView addSubview:itemLabel];
    
    for (int i=0; i<addNewHemianInfoView.items.count; i++) {
        ItemModel *itemModel = [addNewHemianInfoView.items objectAtIndex:i];
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(150.0f + 150.0f * i, 0, 150.0f, 44.0f)];
        itemLabel.text = itemModel.item_name;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [addNewHemianInfoView.infoHearderView addSubview:itemLabel];
    }
    
    for (int i=0; i<addNewHemianInfoView.items.count; i++) {
        UIView *v = [[addNewHemianInfoView.infoHearderView subviews] objectAtIndex:i+1];
        
        StepInputView *stepInputView = [[[NSBundle mainBundle] loadNibNamed:@"StepInputView" owner:self options:nil] lastObject];
        
        [stepInputView setPosition:CGPointMake(v.frame.origin.x + 20.0f, 142.0f)];
        
        [addNewHemianInfoView addSubview:stepInputView];
        
        [addNewHemianInfoView.inputsArray addObject:stepInputView];
    }
    
    [addNewHemianInfoView standardFormula:nil];
    
    addNewHemianInfoView.infoDataArray = [[DataBaseManager sharedManager] getFormulaProductInfoListByClassAndItems:@"和面" items:addNewHemianInfoView.items date:[NSDate date]];
    [addNewHemianInfoView.infoTableView reloadData];
    
    return addNewHemianInfoView;
}


- (IBAction)cancel:(id)sender
{
    [self hide];
}

- (IBAction)save:(id)sender
{
    NSMutableArray *itemsDataArray = [NSMutableArray array];
    for (int i=0; i<self.inputsArray.count; i++) {
        StepInputView *stepInputView = [self.inputsArray objectAtIndex:i];
        
        ItemModel *itemModel = [self.items objectAtIndex:i];
        int inputCount = [[stepInputView getInputValue] intValue] * [itemModel.unitReguler.unit_reguler_ratio intValue];
        
        [itemsDataArray addObject:[NSNumber numberWithInt:inputCount]];
    }
    
    self.saveCallBackBlock(itemsDataArray);
    
    [self hide];
}

- (void)dealloc
{
    self.saveCallBackBlock = nil;
}

//标准配方
- (IBAction)standardFormula:(id)sender
{
    //获取标准配方
    NSArray *standardFormulaArray = @[@"50000",@"50",@"50",@"50"];
    
    [self resetFormula:standardFormulaArray];
}

- (void)resetFormula:(NSArray *)formulas_
{
    for (int i=0; i<self.inputsArray.count; i++) {
        StepInputView *stepInputView = [self.inputsArray objectAtIndex:i];
        
        NSString *formula = [formulas_ objectAtIndex:i];
        
        ItemModel *itemModel = [self.items objectAtIndex:i];
        int count = [formula intValue] / [itemModel.unitReguler.unit_reguler_ratio intValue];
        
        [stepInputView setInputValue:[NSNumber numberWithInt:count]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoDataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel *productModel = [self.infoDataArray objectAtIndex:indexPath.row];
    NSMutableArray *formula = [NSMutableArray array];
    for (int i=0; i<productModel.productItems.count; i++) {
        ProductItemRelationModel *productItemRelationModel = [productModel.productItems objectAtIndex:i];
        [formula addObject:productItemRelationModel.product_item_relation_produce];
    }
    
    [self resetFormula:formula];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_ID = @"AddNewHemianInfoView_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    for (UIView * view_ in [cell.contentView subviews]) {
        [view_ removeFromSuperview];
    }
    
    NSArray *headers = [self.infoHearderView subviews];
    ProductModel *productModel = [self.infoDataArray objectAtIndex:indexPath.row];
    UIView *v = [headers objectAtIndex:0];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
    
    NSString *dateTodayString = [[DateManager sharedManager] dateStringFrom:[NSDate date]];
    if ([productModel.product_date isEqualToString:dateTodayString]) {
        //今天的数据
        timeLabel.text = [[DateManager sharedManager] timeStringFrom:[productModel.product_time doubleValue]];
    }
    else
    {
        timeLabel.text = [NSString stringWithFormat:@"%@ %@", productModel.product_date,
                          [[DateManager sharedManager] timeStringFrom:[productModel.product_time doubleValue]]];
    }
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:timeLabel];
    
    NSArray *items_ = productModel.productItems;
    
    for (int i=0; i<items_.count; i++) {
        v = [headers objectAtIndex:i+1];
        ProductItemRelationModel *productItemRelationModel = [items_ objectAtIndex:i];
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(v.frame.origin.x, 0, v.frame.size.width, 60)];
        
        ItemModel *itemModel = [self.items objectAtIndex:i];
        int count = [productItemRelationModel.product_item_relation_produce intValue] / [itemModel.unitReguler.unit_reguler_ratio intValue];
        
        countLabel.text = [NSString stringWithFormat:@"%d",count];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:countLabel];
        
    }
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }else cell.contentView.backgroundColor = BACKGROUND_GRAY;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
