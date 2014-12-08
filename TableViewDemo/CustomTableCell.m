//
//  CustomTableCell.m
//  TableViewDemo
//
//  Created by zanglitao on 14/12/7.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setContent:(NSDictionary *)dic {
    NSString *label1 = dic[@"label1"];
    NSString *lable2 = dic[@"label2"];
    [_label1 setText:label1];
    
    CGSize textSize=[lable2 boundingRectWithSize:CGSizeMake(226, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil].size;
    
    _label2.frame = CGRectMake(_label2.frame.origin.x, _label2.frame.origin.y, _label2.frame.size.width, textSize.height);
    _label2.text = lable2;
}


@end
