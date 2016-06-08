//
//  AtUserViewController.m
//  happigo
//
//  Created by fei on 16/1/4.
//  Copyright (c) 2016年 klx.iOS. All rights reserved.
//

#import "AtUserViewController.h"
#import "AtUserCell.h"
#import "AtUserModel.h"
#import "AtUserListAPI.h"
#import "AppDelegate.h"
#import "ConcernAndBlackListModel.h"
#import "Global.h"
#import "ColorTools.h"


@interface AtUserViewController ()<UITableViewDataSource, UITableViewDelegate,APIRequestManagerDelegate,UITextFieldDelegate>

@property(strong, nonatomic) UITableView *useTableView;
@property(strong, nonatomic) AtUserListAPI *userAPI;
@property(strong, nonatomic) AtUserModel *model;
@property(strong, nonatomic) NSMutableArray *modelArray;
@property(strong, nonatomic) NSMutableArray *concernArray;
@property(strong, nonatomic) NSMutableDictionary *modelDic;
@property(strong, nonatomic) NSArray *titleArray;
@property(strong, nonatomic) UIButton *leftButton;
@property(strong, nonatomic) UILabel *titleLable;
@property(strong, nonatomic) UITableView *searchTableView;
@property(strong, nonatomic) NSMutableArray *searchArray;

@end

static NSString *cellID = @"cellID";

@implementation AtUserViewController

-(void)dealloc{
    self.useTableView.dataSource = nil;
    self.useTableView.delegate = nil;
}

-(void)loadView
{
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.titleView = self.titleLable;
    
//    self.title = @"@";
    NSArray *array =
    [ApplicationDelegate.synchronizeManager findAllMasterWithTableName:ConcernList];
    for (ConcernAndBlackModel *model in array)
    {
        AtUserModel *atModel = [AtUserModel new];
        atModel.uid = model.uid;
        atModel.nickname = model.nickname;
        atModel.head_img_url = model.headurl;
        atModel.ismaster = model.ismaster;
        atModel.desc = @"";
        [self.concernArray addObject:atModel];
    }
    [self requestData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)leftButtonClick:(UIButton *)sender{
   
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
   
}

- (void)requestData{
    [self.userAPI startRequest];
}

- (void)apiRequestManagerDidSuccess:(BaseAPIManager*)apiManager{
    
     NSDictionary *json  = [self.userAPI fetchDataWithTransformer:nil];
    
     AtUserList *modelList = [MTLJSONAdapter modelOfClass:[AtUserList class] fromJSONDictionary:json error:nil];
    [_modelArray addObjectsFromArray:modelList.data];
    [self.useTableView reloadData];
    
    
    
}
- (void)apiRequestManagerDidFailed:(BaseAPIManager *)apiManager{
    
}

//-(UIBarButtonItem*)backButton
//{
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消"
//                                                                     style:UIBarButtonItemStylePlain
//                                                                    target:self
//                                                                    action:@selector(back)];
//    return barButtonItem;
//}
//
//-(void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}


- (instancetype)init{
    if (self = [super init]) {
        [self initSubviews];
        [self setLayoutSubviews];
    }
    return self;
}

- (void)initSubviews{
    
    [self.view addSubview:self.useTableView];
    [self.view addSubview:self.searchTableView];
    self.useTableView.hidden = NO;
    self.searchTableView.hidden = YES;
    
    UIView *useview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.1)];
    UIView *useview2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.1)];
    self.useTableView.tableFooterView = useview1;
    self.useTableView.tableHeaderView = useview2;
    
    UIView *searchview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 20)];
    UIView *searchview2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 20)];
    self.searchTableView.tableFooterView = searchview1;
    self.searchTableView.tableHeaderView = searchview2;

    [self addsearchView];

}

- (void)addsearchView{
    
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

- (void)setLayoutSubviews{
    
    WeakObject(weakSelf);
    [self.useTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(44);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(89);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        
    }];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchTableView){
        AtUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[AtUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
       [cell setcontentWithModel2:self.searchArray[indexPath.row]];
        return cell;
        
    } else{
        
        if (indexPath.section == 0)
        {
            AtUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[AtUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setcontentWithModel1:self.modelArray[indexPath.row]];
            return cell;
        }
        else if (indexPath.section == 1)
        {
            AtUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[AtUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            [cell setcontentWithModel2:self.concernArray[indexPath.row]];
            return cell;
        } else
            return nil;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.searchTableView) {
        CGFloat height = [AtUserCell heightForCell:self.searchArray[indexPath.row]];
        return height;
        
        
    } else{
        if (indexPath.section == 0)
        {
            CGFloat height = [AtUserCell heightForCell:self.modelArray[indexPath.row]];
            return height;
        }
        else if (indexPath.section == 1)
        {
            CGFloat height = [AtUserCell heightForCell:self.concernArray[indexPath.row]];
            return height;
        } else
            return 0;

    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchTableView) {
        return self.searchArray.count;
        
    } else{
        if (section == 0)
        {
            return self.modelArray.count;
        }
        else if (section == 1)
        {
            return self.concernArray.count;
        }
        else
            return 0;
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    if (tableView == self.searchTableView) {
        return 1;
    
        
    } else{
        if (self.concernArray.count == 0) {
            return 1;
        }
        else
            return 2;
    }
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSArray *titleArr = @[@"推荐@的人",@"关注的人"];
//    return titleArr[section];
//}
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return @[@"A", ];
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.searchTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.1)];
        return view;
        
        
    } else{

        UILabel *lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 35)];
        
        lableTitle.text = self.titleArray[section];
        lableTitle.textColor = [UIColor colorWithRed:157/255. green:157/255. blue:157/255. alpha:1.0];
        lableTitle.font = [UIFont systemFontOfSize:15];
        UIView *sectionView = [UIView new];
        sectionView.backgroundColor = [UIColor whiteColor];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 0.5)];
        line1.backgroundColor = [UIColor colorWithRed:176/255. green:176/255. blue:176/255. alpha:1.0];
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 34.5, DeviceWidth, 0.5)];
        line2.backgroundColor = [UIColor colorWithRed:176/255. green:176/255. blue:176/255. alpha:1.0];
        
        [sectionView addSubview:line1];
        [sectionView addSubview:line2];
        [sectionView addSubview:lableTitle];
        
        return sectionView;

    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.searchTableView) {
        return 0.1;
    } else{
        return 35;
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.searchTableView) {
        AtUserModel *model = _searchArray[indexPath.row];
        _AtBlock(model.nickname,model.uid);
    [self.navigationController popViewControllerAnimated:YES];
        
        
    } else{
       
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if(indexPath.section == 0)
        {
            AtUserModel *model = _modelArray[indexPath.row];
            _AtBlock(model.nickname,model.uid);
        }
        else if (indexPath.section == 1)
        {
            AtUserModel *model = _concernArray[indexPath.row];
            _AtBlock(model.nickname,model.uid);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}

- (void)searchClickEvent:(UITextField *)textField{
    
    [self.searchArray removeAllObjects];
    
    
    
    NSString *match = textField.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.nickname CONTAINS %@", match];
    NSArray *results = [self.concernArray filteredArrayUsingPredicate:predicate];
    
    if (results.count) {
       [self.searchArray addObjectsFromArray:results];
    }
    

    
    
    
    
//    NSLog(@"%@",results);
    
    
//    NSLog(@"*****************%@", self.searchArray);
    
    
    
//    for (AtUserModel *model in _concernArray) {
//        
//        NSString *string = [NSString stringWithFormat:@"%@", textField.text];
//        
//        if ([model.nickname rangeOfString:string].location != NSNotFound) {
//            
//            if ([self.searchArray containsObject:model]) {
//
//            } else{
//                [self.searchArray addObject:model];
//            }
//            //条件为真，表示字符串searchStr包含一个自字符串substr
//            
//        }else
//        {
//            //条件为假，表示不包含要检查的字符串
//        }
//        
//    }
    
    if (textField.text.length == 0) {
        _useTableView.hidden = NO;
        _searchTableView.hidden = YES;
        [textField resignFirstResponder];
        [_useTableView reloadData];
    } else{
        _useTableView.hidden = YES;
        _searchTableView.hidden = NO;
        [_searchTableView reloadData];
    }



    
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    
//    self.useTableView.hidden = YES;
//    self.searchTableView.hidden = NO;
//    
//    return YES;
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return NO;
}





- (UITableView *)useTableView{
    if (_useTableView == nil) {
         _useTableView = [[UITableView alloc] initWithFrame:
                          CGRectZero style:UITableViewStylePlain];
        _useTableView.delegate = self;
        _useTableView.dataSource = self;
        _useTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _useTableView.backgroundColor = [UIColor yellowColor];
    }
    return _useTableView;
}

- (AtUserListAPI *)userAPI{
    if (_userAPI == nil) {
        _userAPI = [[AtUserListAPI alloc] init];
        _userAPI.apiMangerCallBackDelegate = self;
    }
    return _userAPI;
}

-(NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
        
    }
    return _modelArray;
}

-(NSMutableArray *)concernArray{
    if (_concernArray == nil)
    {
        _concernArray = [NSMutableArray array];
    }
    return _concernArray;
}


-(NSMutableDictionary *)modelDic{
    if (_modelDic == nil) {
        _modelDic = [NSMutableDictionary dictionary];
        
    }
    return _modelDic;
}

-(NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[@"推荐@的人",@"我关注的人"];
    }
    return _titleArray;
}
- (UIButton *)leftButton {
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, 28, 28);
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"btn_top_back"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _leftButton;
}

-(UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
        _titleLable.text = @"@";
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.textColor = [ColorTools titleColor];
    }
    return _titleLable;
}


- (UITableView *)searchTableView{
    if (_searchTableView == nil) {
        _searchTableView = [[UITableView alloc] initWithFrame:
                            CGRectZero style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _useTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _searchTableView;
}

-(NSMutableArray *)searchArray{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

@end
