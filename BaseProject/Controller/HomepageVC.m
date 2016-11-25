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

static float alpha = 1;
static float baseMinY = -64;
static float baseMaxY = 160 - 64;

@interface HomepageVC () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (strong, nonatomic) BPTouchTableView *tableView;
@property (strong, nonatomic) UIView *statusView;
@property (strong, nonatomic) UITextField *searchTextField;

@end

@implementation HomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[BPTouchTableView alloc] initWithFrame:CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self setupNavBarTransparent];
    
    [self setupTableHeaderView];
    
    [self setupTitleView];
}

- (void)setupTitleView {
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 60, 30)];
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextField.textColor = [UIColor blackColor];
    _searchTextField.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = _searchTextField;
}

- (void)setupTableHeaderView {
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
    return 20;
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = @"iOS";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BPAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"BPAlertView" owner:nil options:nil] firstObject];
    [alertView showAlertView:self block:^(NSString *name) {
        NSLog(@"Click confirm button of BPAlertView");
    }];
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
    //Make navigationbar transparent.
    UIImage *navClearBkg = [UIImage imageNamed:@"TransparentPixel"];
    [self.navigationController.navigationBar setBackgroundImage:navClearBkg forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = navClearBkg;
    
    _statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20)];
    [self.view addSubview:_statusView];
}

@end
