//
//  CustomTableCellController.m
//  TableViewDemo
//
//  Created by zanglitao on 14/12/7.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import "CustomTableCellController.h"
#import "CustomTableCell.h"

@interface CustomTableCellController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *_array;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CustomTableCellController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _array = @[@{@"label1": @"静夜思",@"label2":@"床前明月光，疑是地上霜。举头望明月，低头思故乡。"},@{@"label1": @"早秋",@"label2":@"遥夜泛清瑟，西风生翠萝。残萤栖玉露，早雁拂金河。高树晓还密，远山晴更多。                             淮南一叶下，自觉洞庭波。"}];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customcell" forIndexPath:indexPath];
    
    [cell setContent:_array[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize textSize=[_array[indexPath.row][@"label2"] boundingRectWithSize:CGSizeMake(226, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil].size;
    
    return textSize.height + 10;
}
@end
