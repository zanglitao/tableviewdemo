//
//  CustomSearchBarTableViewController.m
//  TableViewDemo
//
//  Created by zanglitao on 14/12/8.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import "CustomSearchBarTableViewController.h"

@interface CustomSearchBarTableViewController ()<UISearchDisplayDelegate,UISearchBarDelegate> {
    //数据源
    NSArray *_datasource;
    
    //存放符合筛选条件的数据源
    NSMutableArray *_filterdatasource;
    
    UISearchDisplayController *_searchController;
    UISearchBar *_searchBar;
}

@end

@implementation CustomSearchBarTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _datasource = @[@[@"zanglitao",@"zang",@"li",@"tao"],@[@"male"]];
    _filterdatasource = [NSMutableArray array];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    _searchBar.placeholder = @"输入关键字";
    self.tableView.tableHeaderView = _searchBar;
    
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchController.delegate = self;
    //设置内部tableView的delegate
    _searchController.searchResultsDelegate = self;
    //设置内部tableview的datasource
    _searchController.searchResultsDataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _searchController.searchResultsTableView) {
        return 1;
    }
    return [_datasource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _searchController.searchResultsTableView) {
        return [_filterdatasource count];
    }
    return [_datasource[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (tableView == _searchController.searchResultsTableView) {
        cell.textLabel.text = _filterdatasource[indexPath.row];
    } else {
        cell.textLabel.text = _datasource[indexPath.section][indexPath.row];
    }
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == _searchController.searchResultsTableView) {
        return @"搜索结果";
    }
    return [NSString stringWithFormat:@"%d",section];
}

#pragma mark - Search bar controller delegate
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    
    [_filterdatasource removeAllObjects];
    [_datasource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *str = [(NSString *)obj uppercaseString];
            if ([str rangeOfString:[searchString uppercaseString]].location != NSNotFound) {
                [_filterdatasource addObject:obj];
            }
        }];
    }];
    
    return YES;
}

@end
