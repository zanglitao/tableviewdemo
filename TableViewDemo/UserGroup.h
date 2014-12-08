//
//  UserGroup.h
//  TableViewDemo
//
//  Created by zanglitao on 14/12/5.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGroup : NSObject

@property(nonatomic,strong)NSMutableArray *userEntities;
@property(nonatomic,strong)NSString *groupIdentifier;
@property(nonatomic,strong)NSString *groupIntro;

-(id)initWithEntities:(NSArray *)entities GroupIdentifier:(NSString *)groupIdentifier GroupIntro:(NSString *)groupIntro;

@end
