//
//  UserEntity.h
//  TableViewDemo
//
//  Created by zanglitao on 14/12/5.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;

-(id)initWithName:(NSString *)name Phone:(NSString *)phone;
@end
