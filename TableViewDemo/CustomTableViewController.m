//
//  CustomTableViewController.m
//  TableViewDemo
//
//  Created by zanglitao on 14/12/7.
//  Copyright (c) 2014年 臧立涛. All rights reserved.
//

#import "CustomTableViewController.h"

@interface CustomTableViewController ()<UISearchBarDelegate> {
    UISearchBar *_searchBar;
    //数据源
    NSArray *_datasource;
    
    //存放符合筛选条件的数据源
    NSMutableArray *_filterdatasource;
    
    //searcbar是否处于搜索状态，这个布尔值决定使用_datasource还是_filterdatasource
    BOOL _isSearching;
}

@end

@implementation CustomTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _datasource = @[@[@"zanglitao",@"zang",@"li",@"tao"],@[@"male"]];
    _filterdatasource = [NSMutableArray array];
    
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    _searchBar.placeholder = @"输入关键字";
    //_searchBar.keyboardType = UIKeyboardTypeAlphabet;//键盘类型
    //_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;//自动纠错类型
    //_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;//哪一次shitf被自动按下
    self.tableView.tableHeaderView = _searchBar;
    
    [self setRefrshController];
}

- (void)setRefrshController {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"下拉刷新"]];
    
    [self.refreshControl addTarget:self action:@selector(refreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshViewControlEventValueChanged {
    //重新加载数据
    [NSThread sleepForTimeInterval:3];
    
    //修改refreshControl状态
    [self.refreshControl endRefreshing];
    //更新列表
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isSearching) {
        return 1;
    }
    return [_datasource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearching) {
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
    if (_isSearching) {
        cell.textLabel.text = _filterdatasource[indexPath.row];
    } else {
        cell.textLabel.text = _datasource[indexPath.section][indexPath.row];
    }
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_isSearching) {
        return @"搜索结果";
    }
    return [NSString stringWithFormat:@"%d",section];
}

#pragma mark - Search bar delegate
//searchbar开始处于编辑状态时调用
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [_filterdatasource removeAllObjects];
    _isSearching = YES;
    [self.tableView reloadData];
}

//searchbar内容改变时调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_filterdatasource removeAllObjects];
    [_datasource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *str = [(NSString *)obj uppercaseString];
            if ([str rangeOfString:[searchText uppercaseString]].location != NSNotFound) {
                [_filterdatasource addObject:obj];
            }
        }];
    }];
    
    [self.tableView reloadData];
}

//点击searchbar的cancel按钮时调用
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    _isSearching = NO;
    [self.tableView reloadData];
}

//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
@end
