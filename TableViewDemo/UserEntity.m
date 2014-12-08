//
//  UserEntity.m
//  TableViewDemo
//
//  Created by zanglitao on 14/12/5.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

-(id)initWithName:(NSString *)name Phone:(NSString *)phone {
    self = [super init];
    if (self) {
        self.name = name;
        self.phone = phone;
    }
    
    return self;
}

@end
