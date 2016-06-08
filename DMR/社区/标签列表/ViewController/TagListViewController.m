//
//  TagListViewController.m
//  happigo
//
//  Created by shklxjsbmac004 on 16/1/5.
//  Copyright © 2016年 klx.iOS. All rights reserved.
//

#import "TagListViewController.h"
#import "TagListAPI.h"
#import "TagListCell.h"
#import "ColorTools.h"
#import "TagListModel.h"
#import "Global.h"

@interface TagListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,APIRequestManagerDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) TagListAPI *tagList;
@property (strong,nonatomic) NSMutableArray *hostListArray;
@property (strong,nonatomic) NSMutableArray *totalListArray;
@property (assign,nonatomic) BOOL isSearch;
@property (strong,nonatomic) NSMutableArray *searchArray;

@end

@implementation TagListViewController

- (void)loadView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签列表";

    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithImage:[UIImage imageNamed:@"btn_top_back"]
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(onBack)];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:255/255.0 green:117/255.0 blue:159/255.0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem =item;
    
    _isSearch = NO;
    _searchArray = [[NSMutableArray alloc]init];
    _hostListArray = [[NSMutableArray alloc]init];
    _totalListArray = [[NSMutableArray alloc]init];
    [self initSubviews];
    [self.tagList startRequestWithType:1 andIsHost:1];
}

- (void)initSubviews {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self initSearchView];
}

- (void)initSearchView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, 45)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 44.5, DeviceWidth, 0.5)];
    lineLabel.backgroundColor = [ColorTools lineColor];
    
    UIView *edgeView = [[UIView alloc]init];
    edgeView.center = CGPointMake(view.center.x, view.frame.size.height/2);
    edgeView.bounds = CGRectMake(0, 0, DeviceWidth-34, 31);
    edgeView.layer.borderColor = [ColorTools lineColor].CGColor;
    edgeView.layer.borderWidth = 0.5;
    edgeView.layer.cornerRadius = edgeView.frame.size.height/2;
    edgeView.clipsToBounds = YES;
    
    UIImageView *searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_shequ_taglist_search"]];
    searchImage.frame = CGRectMake(17, 7, 17, 17);
    
    UITextField *searchText = [[UITextField alloc]initWithFrame:CGRectMake(51, 0, edgeView.frame.size.width-51, 31)];
    searchText.placeholder = @"搜索";
    searchText.returnKeyType = UIReturnKeyDone;
    searchText.delegate = self;
    [searchText addTarget:self action:@selector(searchClickEvent:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:view];
    [view addSubview:lineLabel];
    [view addSubview:edgeView];
    [edgeView addSubview:searchImage];
    [edgeView addSubview:searchText];
}

-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIBarButtonItem*)backButton
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(back)];
    return barButtonItem;
}

-(void)back
{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 搜索输入框值变化事件

- (void)searchClickEvent:(UITextField *)textField {
    _isSearch = YES;
    [_searchArray removeAllObjects];
    for (TagListModel *model in _totalListArray) {
        if ([model.tag_name containsString:textField.text]) {
            [_searchArray addObject:model];
        }
    }
    if (textField.text.length == 0) {
        _isSearch = NO;
    }
    [_tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return NO;
}

#pragma mark - 网络回调

- (void)apiRequestManagerDidSuccess:(BaseAPIManager *)apiManager {
    
    NSDictionary *json = [apiManager fetchDataWithTransformer:nil];
    ListModel *list = [MTLJSONAdapter modelOfClass:[ListModel class] fromJSONDictionary:json[@"data"] error:nil];
    [_hostListArray addObjectsFromArray:list.hotTags];
    [_totalListArray addObjectsFromArray:list.tags];
    [_tableView reloadData];
    
}

- (void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager {
//    [TNToast showWithText:apiManager.responseMessage];
}

#pragma mark - tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isSearch == YES) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearch == YES) {
        return _searchArray.count;
    } else {
        if (section == 0) {
            return _hostListArray.count;
        } else if (section == 1) {
            return _totalListArray.count;
        }
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_isSearch == YES) {
        return 0.1;
    }
    return 35.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_isSearch == YES) {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 35.0)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, DeviceWidth-17, 35.0)];
    headerLabel.font = [UIFont systemFontOfSize:15.0];
    headerLabel.textColor = [ColorTools officialPriceTextColor];
    if (section == 0) {
        headerLabel.text = @"热门标签";
    } else if (section == 1) {
        headerLabel.text = @"全部标签";
    }
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34.5, DeviceWidth, 0.5)];
    lineLabel.backgroundColor = [ColorTools lineColor];
    
    [view addSubview:headerLabel];
    [view addSubview:lineLabel];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"TagListCell";
    TagListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TagListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 70)];
    }
    if (_isSearch == YES) {
        [cell setContentWithModel:(TagListModel *)_searchArray[indexPath.row]];
    } else {
        if (indexPath.section == 0) {
            [cell setContentWithModel:(TagListModel *)_hostListArray[indexPath.row]];
        } else if (indexPath.section == 1) {
            [cell setContentWithModel:(TagListModel *)_totalListArray[indexPath.row]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isSearch == YES) {

        TagListModel *model = _searchArray[indexPath.row];
        if (_selectTagBlock && model.tag_name.length > 0)
        {
            _selectTagBlock(model.tag_name);
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            TagListModel *model = _hostListArray[indexPath.row];
            if (_selectTagBlock) {
                _selectTagBlock(model.tag_name);
            }
        }
        else if (indexPath.section == 1)
        {
            TagListModel *model  = _totalListArray[indexPath.row];
            if (_selectTagBlock) {
                _selectTagBlock(model.tag_name);
            }
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 属性

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 105, DeviceWidth , DeviceHeight-105) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.1)];
    }
    return _tableView;
}

- (TagListAPI *)tagList {
    if (_tagList == nil) {
        _tagList = [[TagListAPI alloc]init];
        _tagList.apiMangerCallBackDelegate = self;
    }
    return _tagList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
