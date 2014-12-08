//
//  ZLTViewController.m
//  TableViewDemo
//
//  Created by zanglitao on 14/12/5.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import "ZLTViewController.h"
#import "UserEntity.h"
#import "UserGroup.h"
@interface ZLTViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    NSIndexPath *_indexPath;
    UIToolbar *_toolbar;
    
    //判断当前处于的状态
    BOOL *_isAdd;
}

@end

@implementation ZLTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //配置列表需要展示的数据，真实项目中这部分数据往往来自文件或者网络
    [self initdata];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    //设置列表数据源
    _tableView.dataSource = self;
    //设置列表代理
    _tableView.delegate = self;
    //为了不遮挡toolbar，tableview的内容显示区域向下移动44个像素
    _tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.tag = 1;
    label.text = @"暂时没有数据";
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor:[UIColor lightGrayColor]];
    [view addSubview:label];
    _tableView.backgroundView = view;
    label.center = view.center;
    
    if ([_dataSource count] != 0) {
        [[_tableView.backgroundView viewWithTag:1] setHidden:YES];
    }
    
    [self.view addSubview:_tableView];
    [self setToolbar];
}

- (void)setToolbar {
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:_toolbar];
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    _toolbar.items = @[deleteItem,flexibleItem,addItem];
}


- (void)initdata {
    UserEntity *entity1 = [[UserEntity alloc] initWithName:@"user1" Phone:@"11111111111"];
    UserEntity *entity2 = [[UserEntity alloc] initWithName:@"user2" Phone:@"11111111112"];
    UserGroup *group1 = [[UserGroup alloc] initWithEntities:[NSMutableArray arrayWithObjects:entity1,entity2, nil] GroupIdentifier:@"1" GroupIntro:@"this is group1"];
    
    
    UserEntity *entity3 = [[UserEntity alloc] initWithName:@"user3" Phone:@"11111111113"];
    UserEntity *entity4 = [[UserEntity alloc] initWithName:@"user4" Phone:@"11111111114"];
    UserEntity *entity5 = [[UserEntity alloc] initWithName:@"user5" Phone:@"11111111115"];
    UserGroup *group2 = [[UserGroup alloc] initWithEntities:[NSMutableArray arrayWithObjects:entity3,entity4,entity5, nil] GroupIdentifier:@"2" GroupIntro:@"this is group2"];
    
    UserEntity *entity6 = [[UserEntity alloc] initWithName:@"user6" Phone:@"11111111116"];
    UserEntity *entity7 = [[UserEntity alloc] initWithName:@"user7" Phone:@"11111111117"];
    UserGroup *group3 = [[UserGroup alloc] initWithEntities:[NSMutableArray arrayWithObjects:entity6,entity7, nil] GroupIdentifier:@"3" GroupIntro:@"this is group3"];
    
    UserEntity *entity8 = [[UserEntity alloc] initWithName:@"user8" Phone:@"11111111118"];
    UserGroup *group4 = [[UserGroup alloc] initWithEntities:[NSMutableArray arrayWithObjects:entity8,nil] GroupIdentifier:@"4" GroupIntro:@"this is group4"];
    
    UserEntity *entity9 = [[UserEntity alloc] initWithName:@"user9" Phone:@"11111111119"];
    UserEntity *entity10 = [[UserEntity alloc] initWithName:@"user10" Phone:@"111111111110"];
    UserEntity *entity11 = [[UserEntity alloc] initWithName:@"user11" Phone:@"111111111111"];
    UserGroup *group5 = [[UserGroup alloc] initWithEntities:[NSMutableArray arrayWithObjects:entity9,entity10,entity11, nil] GroupIdentifier:@"5" GroupIntro:@"this is group5"];
    
    _dataSource = [NSMutableArray arrayWithObjects:group1,group2,group3,group4,group5, nil];
}

//返回列表分组数，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSource count];
}

//返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [((UserGroup *)_dataSource[section]).userEntities count];
}

//配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    UserGroup *group = _dataSource[indexPath.section];
    UserEntity *entity = group.userEntities[indexPath.row];
    cell.detailTextLabel.text = entity.phone;
    cell.textLabel.text = entity.name;
    
    //给cell设置accessoryType或者accessoryView
    //也可以不设置，这里纯粹为了展示cell的常用可设置选项
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        cell.accessoryType = UITableViewCellAccessoryDetailButton;
//    }else if (indexPath.section == 0 && indexPath.row == 1) {
//        cell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//返回列表每个分组头部说明
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_dataSource[section] groupIdentifier];
}

//返回列表每个分组尾部说明
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [_dataSource[section] groupIntro];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray array];
    [_dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [array addObject:[obj groupIdentifier]];
    }];
    
    return array;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

//设置sectionheader的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 60;
    }
    return 40;
}

//设置sectionfooter的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

//设置cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *text = [alertView textFieldAtIndex:0];
    
    UserGroup *group = _dataSource[indexPath.section];
    NSString *phone = [group.userEntities[indexPath.row] phone];
    [text setText:phone];

    [alertView show];
}

//自定义sectionheader显示的view
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//    [view setBackgroundColor:[UIColor greenColor]];
//    return view;
//}

//自定义sectionfooter显示的view
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//    [view setBackgroundColor:[UIColor yellowColor]];
//    return view;
//}

//设置编辑风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isAdd) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

//处理添加和删除的代码
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UserGroup *group = _dataSource[indexPath.section];
        [group.userEntities removeObjectAtIndex:indexPath.row];
        
        
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        if ([group.userEntities count] == 0) {
            [_dataSource removeObjectAtIndex:indexPath.section];
            [_tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationBottom];
        }
    } else if(editingStyle == UITableViewCellEditingStyleInsert) {
        UserGroup *group = _dataSource[indexPath.section];
        [group.userEntities insertObject:[[UserEntity alloc] initWithName:@"new user" Phone:@"137xxxxxxxx"] atIndex:indexPath.row];
        
        [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
    if ([_dataSource count] == 0) {
        [[_tableView.backgroundView viewWithTag:1] setHidden:NO];
    } else {
        [[_tableView.backgroundView viewWithTag:1] setHidden:YES];
    }
}


//删除
- (void)delete {
    _isAdd = NO;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
}


//添加
- (void)add {
    _isAdd = YES;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
}

//排序
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

}


//修改
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *field = [alertView textFieldAtIndex:0];
        NSString *phone = [field text];
        
        UserGroup *group = _dataSource[_indexPath.section];
        UserEntity *entity = group.userEntities[_indexPath.row];
        [entity setPhone:phone];
        
        //[_tableView reloadData];
        [_tableView reloadRowsAtIndexPaths:@[_indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end