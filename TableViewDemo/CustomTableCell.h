//
//  CustomTableCell.h
//  TableViewDemo
//
//  Created by zanglitao on 14/12/7.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

-(void)setContent:(NSDictionary *)dic;
@end
