//
//  UserGroup.m
//  TableViewDemo
//
//  Created by zanglitao on 14/12/5.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import "UserGroup.h"

@implementation UserGroup

-(id)initWithEntities:(NSMutableArray *)entities GroupIdentifier:(NSString *)groupIdentifier GroupIntro:(NSString *)groupIntro {
    self = [super init];
    if (self) {
        self.userEntities = entities;
        self.groupIdentifier = groupIdentifier;
        self.groupIntro = groupIntro;
    
    }
    return self;
}
@end
