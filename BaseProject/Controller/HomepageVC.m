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

static float alpha = 1;
static float baseMinY = 0;
static float baseMaxY = 160 - 64;

@interface HomepageVC () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (strong, nonatomic) BPTouchTableView *tableView;
@property (strong, nonatomic) UIView *statusView;
@property (strong, nonatomic) UITextField *searchTextField;

@end

@implementation HomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    return 16;
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
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"注册";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"第三方登录";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"获取验证码";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"登录";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"修改密码";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"找回密码";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"获取用户信息";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"修改用户信息";
    } else if (indexPath.row == 8) {
        cell.textLabel.text = @"开屏广告";
    } else if (indexPath.row == 9) {
        cell.textLabel.text = @"第三方绑定";
    } else if (indexPath.row == 10) {
        cell.textLabel.text = @"第三方解绑";
    } else if (indexPath.row == 11) {
        cell.textLabel.text = @"开屏广告";
    } else if (indexPath.row == 12) {
        cell.textLabel.text = @"省市列表";
    } else if (indexPath.row == 13) {
        cell.textLabel.text = @"推送详情";
    } else if (indexPath.row == 14) {
        cell.textLabel.text = @"意见反馈";
    } else if (indexPath.row == 15) {
        cell.textLabel.text = @"获取web内容";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        // 注册
        NSString *codeApi = SERVER_ADDRESS API_REGISTER;
        NSDictionary *codeParam = @{FIXED_PARAMS, @"mobile":@"18516282405", @"password":[BPUtil md5:@"111111"], @"code":@"6624", @"email":@"669672615@qq.com", @"sex":@"1", @"province_id":@"1", @"city_id":@"37", @"area_id":@"", @"device":@"IOS"};
        [BPInterface request:codeApi param:codeParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 1) {
        // 第三方登录 7001 未注册
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 2;
        [[BPThirdParty shareInstance] loginWithThirdParty:btn];
    } else if (indexPath.row == 2) {
        // 获取验证码 content结构要变回来
        NSString *codeApi = SERVER_ADDRESS API_VERIFICATION_TOKEN;
        NSDictionary *codeParam = @{FIXED_PARAMS, @"mobile":@"18516282405"};
        [BPInterface request:codeApi param:codeParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 3) {
        // 登录
        NSString *loginApi = SERVER_ADDRESS API_LOGIN;
        NSDictionary *loginParam = @{FIXED_PARAMS, @"mobile":@"18516282405", @"password":[BPUtil md5:@"111111"], @"device":@"IOS"};
        [BPInterface request:loginApi param:loginParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                [BPUtil saveLoginInfo:responseObject[@"content"]];
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 4) {
        // 修改密码
        NSString *changePwdApi = SERVER_ADDRESS API_CHANGE_PWD;
        NSDictionary *changePwdParam = @{FIXED_PARAMS, @"mobile":@"13865250636", @"password":[BPUtil md5:@"222222"], @"oldpassword":[BPUtil md5:@"222222"]};
        [BPInterface request:changePwdApi param:changePwdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 5) {
        // 找回密码
        NSString *findPwdApi = SERVER_ADDRESS API_FIND_PWD;
        NSDictionary *findPwdParam = @{FIXED_PARAMS, @"mobile":@"13865250636", @"code":@"4348", @"password":[BPUtil md5:@"222222"]};
        [BPInterface request:findPwdApi param:findPwdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 6) {
        // 获取用户详细信息
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
        NSString *userinfoApi = SERVER_ADDRESS API_USERINFO;
        NSMutableDictionary *userinfoParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"token":TOKEN} copyItems:YES];
        [userinfoParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
        [BPInterface request:userinfoApi param:userinfoParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 7) {
        // 修改用户资料
        NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
        NSString *siginid = [[NSUserDefaults standardUserDefaults] objectForKey:SIGNID];
        NSString *modifyUserinfoApi = SERVER_ADDRESS API_MODIFY_USERINFO;
        NSMutableDictionary *modifyUserinfoParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"name":@"iOS_Developer"} copyItems:YES];
        [modifyUserinfoParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
        NSString *imgPath = [CACHE_DIR stringByAppendingPathComponent:@"avatar.png"];
        [BPInterface request2UploadFile:modifyUserinfoApi files:@{@"avatar":imgPath} param:modifyUserinfoParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } if (indexPath.row == 8) {
        // 开屏广告 暂无
        NSString *launchAdApi = SERVER_ADDRESS API_LAUNCH_AD;
        NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS} copyItems:YES];
        [launchAdParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
        [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 9) {
        // 第三方绑定
        NSString *launchAdApi = SERVER_ADDRESS API_BIND_THIRDPARTY;
        NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"platform":@"WX", @"openid":@"o3LILj1K6teKK8Z6WSatN7MP8Zqo", @"device":@"IOS"} copyItems:YES];
        [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 10) {
        // 第三方解绑
        NSString *launchAdApi = SERVER_ADDRESS API_UNBIND_THIRDPARTY;
        NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"platform":@"WX", @"openid":@"o3LILj1K6teKK8Z6WSatN7MP8Zqo", @"device":@"IOS"} copyItems:YES];
        [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 11) {
        // 开屏广告详情 暂无
        NSString *launchAdApi = SERVER_ADDRESS API_LAUNCHAD_DETAIL;
        NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
        [launchAdParam setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
        [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 12) {
        // 省市列表 应该一次性返回
        NSString *launchAdApi = SERVER_ADDRESS API_PROVINCE_CITY;
        NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS} copyItems:YES];
        [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 13) {
        // 推送详情
        NSString *launchAdApi = SERVER_ADDRESS API_PUSH_DETAIL;
        NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
        [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 14) {
        // 意见反馈 返回非法数据
        NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
        NSString *launchAdApi = SERVER_ADDRESS API_SUGGEST;
        NSMutableDictionary *launchAdParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"userid":userid, @"context":@"test suggestion", @"email":@"668672615@qq.com", @"phone":@"18516282405"} copyItems:YES];
        [BPInterface request:launchAdApi param:launchAdParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
    } else if (indexPath.row == 15) {
        // 获取web内容
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
        NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
        NSString *webApi = SERVER_ADDRESS API_WEB_CONTENT;
        NSMutableDictionary *webParam = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"id":@"1"} copyItems:YES];
        [BPInterface request:webApi param:webParam success:^(NSDictionary *responseObject) {
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [BPUtil showMessage:error.localizedDescription];
        }];
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
