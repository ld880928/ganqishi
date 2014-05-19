//
//  AddNewChulongInfoView.m
//  ganqishi
//
//  Created by jijeMac2 on 14-5-15.
//  Copyright (c) 2014年 colin. All rights reserved.
//

#import "AddNewChulongInfoView.h"
#import "Models.h"
#import "StepInputView.h"
#import "DataBaseManager.h"
#import "DateManager.h"

#define BACKGROUND_GRAY [UIColor colorWithRed:.95f green:.95f blue:.95f alpha:1.0f]

@interface AddNewChulongInfoView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *items;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (strong,nonatomic)NSArray *infoDataArray;

@end

@implementation AddNewChulongInfoView

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

+ (AddNewChulongInfoView *)AddNewChulongInfoViewWithItems:(NSArray *)items_
{
    AddNewChulongInfoView *addNewChulongInfoView = [[[NSBundle mainBundle] loadNibNamed:@"AddNewChulongInfoView" owner:self options:nil] lastObject];
    addNewChulongInfoView.items = items_;
    
    
    
    
    return addNewChulongInfoView;
}


- (IBAction)cancel:(id)sender
{
    [self hide];
}

- (IBAction)save:(id)sender
{
    NSMutableArray *itemsDataArray = [NSMutableArray array];
    
    self.saveCallBackBlock(itemsDataArray);
    
    [self hide];
}

- (void)dealloc
{
    self.saveCallBackBlock = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_ID = @"AddNewChulongInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    
    
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }else cell.contentView.backgroundColor = BACKGROUND_GRAY;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
