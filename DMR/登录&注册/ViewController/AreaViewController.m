//
//  AreaViewController.m
//  happigo
//
//  Created by 雨 on 16/2/23.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "AreaViewController.h"
#import "AreaCell.h"

@interface AreaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AreaViewController

- (void)loadView {
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    [self initData];
    [self initSubviews];
}

#pragma mark - 初始化

- (void)initSubviews {
    [self.view addSubview:self.tableView];
}

- (void)initData {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_top_back"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(back)];
    self.title = @"选择国家和地区";
    
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:pathString];
    
    _dataArray = [[NSMutableArray alloc]init];
    _keys = [[NSMutableArray alloc]init];
    
    [_dataArray addObjectsFromArray:array];
    for (NSDictionary *dic in array) {
        [_keys addObject:dic[@"initial"]];
    }
    [_keys replaceObjectAtIndex:0 withObject:@""];
}

#pragma mark - 私有

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(_dataArray[section][@"area"]) count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _dataArray[section][@"initial"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"AreaCell";
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AreaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell configCellWithAreaName:_dataArray[indexPath.section][@"area"][indexPath.row][@"areaName"]
                      areaNumber:_dataArray[indexPath.section][@"area"][indexPath.row][@"areaNumber"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *areaNumber = _dataArray[indexPath.section][@"area"][indexPath.row][@"areaNumber"];
    self.areaNumber(areaNumber);
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _keys;
}

#pragma mark - 属性

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
