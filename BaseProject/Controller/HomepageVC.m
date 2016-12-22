//
//  ViewController.m
//  BaseProject
//
//  Created by GeekRRK on 16/11/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "HomepageVC.h"
#import "HZQPickerView.h"
#import "BPTouchTableView.h"
#import <SDCycleScrollView.h>
#import "BPAlertView.h"
#import "NextVC.h"
#import <Masonry.h>
#import "BPWebViewVC.h"
#import "BPThirdParty.h"
#import "BPRegisterVC.h"
#import "BPLoginVC.h"
#import "BPThirdPartyBindingVC.h"
#import "BPFindPwdVC.h"
#import "BPChangePwdVC.h"
#import "BPChangeUserInfoVC.h"
#import "BPSuggestionVC.h"
#import "BPWebDetailVC.h"
#import "BPPushDetailVC.h"

static float alpha = 1;
static float baseMinY = 0;
static float baseMaxY = 160 - 64;

@interface HomepageVC () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (strong, nonatomic) BPTouchTableView *tableView;
@property (strong, nonatomic) UIView *statusView;
@property (strong, nonatomic) UITextField *searchTextField;

@property (copy, nonatomic) NSArray *titles;

@end

@implementation HomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"注册", @"登录", @"第三方绑定解绑", @"找回密码", @"修改密码", @"修改用户信息", @"意见反馈", @"获取网页数据", @"推送详情"];
    [self setupHomepageUI];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = YES;
    _statusView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = NO;
    _statusView.hidden = YES;
}

- (void)setupHomepageUI {
    [self setupTitleView];
    [self setupNavBarBtn];
    [self setupTableHeaderView];
    [self setupNavBarTransparent];
}

- (void)setupNavBarBtn {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    rightBtn.backgroundColor = [UIColor greenColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupTitleView {
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 120, 30)];
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextField.textColor = [UIColor blackColor];
    _searchTextField.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = _searchTextField;
}

- (void)setupTableHeaderView {
    _tableView = [[BPTouchTableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(self.view.height);
    }];
    
    NSArray *imageArray = @[
                      @"http://cdn.duitang.com/uploads/item/201210/31/20121031085212_Kv4zZ.thumb.600_0.jpeg",
                      @"http://img5.duitang.com/uploads/item/201307/09/20130709201608_t5BJF.jpeg",
                      @"http://mg.soupingguo.com/bizhi/big/10/350/642/10350642.jpg",
                      @"http://iphone.tgbus.com/UploadFiles/201301/20130130145233400.jpg"
                      ];
    SDCycleScrollView *adScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 160)];
    adScrollView.delegate = self;
    adScrollView.imageURLStringsGroup = imageArray;
    adScrollView.autoScrollTimeInterval = 2.5;
    _tableView.tableHeaderView = adScrollView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusableCell = @"ReusableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCell];
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        BPRegisterVC *registerVC = [[BPRegisterVC alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    } else if (indexPath.row == 1) {
        BPLoginVC *loginVC = [[BPLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    } else if (indexPath.row == 2) {
        BPThirdPartyBindingVC *bindingVC = [[BPThirdPartyBindingVC alloc] init];
        [self.navigationController pushViewController:bindingVC animated:YES];
    } else if (indexPath.row == 3) {
        BPFindPwdVC *findPwdVC = [[BPFindPwdVC alloc] init];
        [self.navigationController pushViewController:findPwdVC animated:YES];
    } else if (indexPath.row == 4) {
        BPChangePwdVC *changePwdVC = [[BPChangePwdVC alloc] init];
        [self.navigationController pushViewController:changePwdVC animated:YES];
    } else if (indexPath.row == 5) {
        BPChangeUserInfoVC *changeUserInfo = [[BPChangeUserInfoVC alloc] init];
        [self.navigationController pushViewController:changeUserInfo animated:YES];
    } else if (indexPath.row == 6) {
        BPSuggestionVC *suggestionVC = [[BPSuggestionVC alloc] init];
        [self.navigationController pushViewController:suggestionVC animated:YES];
    } else if (indexPath.row == 7) {
        BPWebDetailVC *webDetailVC = [[BPWebDetailVC alloc] init];
        [self.navigationController pushViewController:webDetailVC animated:YES];
    } else if (indexPath.row == 8) {
        BPPushDetailVC *pushDetailVC = [[BPPushDetailVC alloc] init];
        [self.navigationController pushViewController:pushDetailVC animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= baseMinY) {
        scrollView.contentOffset = CGPointMake(0, baseMinY);
    }
    
    float curY = scrollView.contentOffset.y - baseMinY;
    if (curY > 0 && curY < baseMaxY) {
        alpha = curY / baseMaxY;
    } else if (curY <= 0) {
        alpha = 0;
    } else if (curY >= baseMaxY) {
        alpha = 1;
    }
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.4 green:0.8 blue:1 alpha:alpha];
    _statusView.backgroundColor = [UIColor colorWithRed:0.4 green:0.8 blue:1 alpha:alpha];
}

- (void)setupNavBarTransparent {
    self.navigationController.navigationBar.translucent = YES;
    UIImage *navClearBkg = [UIImage imageNamed:@"TransparentPixel"];
    [self.navigationController.navigationBar setBackgroundImage:navClearBkg forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = navClearBkg;
    
    _statusView = [[UIView alloc] init];
    [self.view addSubview:_statusView];
    
    [_statusView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@20);
    }];
}

@end
