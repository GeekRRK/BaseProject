#import "BPLaunchAd.h"
#import "BPWebViewVC.h"

#define AD_IMG_NAME @"BPAdImg.jpg"
#define AD_INFO     @"BPAdInfo"

@interface BPLaunchAd ()

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) int countdown;
@property (strong, nonatomic) UIButton *countdownBtn;

@property (copy, nonatomic) NSDictionary *oldAdDict;
@property (copy, nonatomic) NSDictionary *curAdDict;
@property (strong, nonatomic) UIImage *img;

@end

@implementation BPLaunchAd

+ (void)load {
    //[self shareInstance];
}

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self checkNewAd];
        }];
    }
    return self;
}

- (void)checkNewAd {
    _oldAdDict = [BPUtil readDictBy:AD_INFO];
    if (_oldAdDict != nil && _oldAdDict.count > 0) {
        [self show];
    }
    
    NSString *api = SERVER_ADDRESS;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{} copyItems:YES];
    [BPInterface request:api param:param success:^(BPResponseModel *responseObject) {
        if (responseObject.status == 0) {
            if (_curAdDict == nil || _curAdDict.count == 0) {
                [BPUtil deleteFileByName:AD_INFO];
            } else {
                [self asyncDownloadAdImageWithUrl:_curAdDict[@"imgurl"] imageName:AD_IMG_NAME];
            }
        } else {
            [BPUtil showMessage:responseObject.content];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (void)show {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [UIViewController new];
    window.rootViewController.view.backgroundColor = [UIColor clearColor];
    window.rootViewController.view.userInteractionEnabled = NO;
    [self setupSubviews:window];
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.hidden = NO;
    window.alpha = 1;
    self.window = window;
}

- (void)clickAd {
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    BPWebViewVC *webVC = [[BPWebViewVC alloc] init];
    BPWebModel *webModel = [BPWebModel yy_modelWithDictionary:_curAdDict];
    webVC.webModel = webModel;
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        [rootVC.navigationController pushViewController:webVC animated:YES];
    } else {
        [(UINavigationController *)rootVC.navigationController pushViewController:webVC animated:YES];
    }
    
    [self hide];
}

- (void)requestLaunchAdDetail {
    // 开屏广告详情
    NSString *api = SERVER_ADDRESS;
    
    NSString *adId = @"广告id";
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{@"id":adId} copyItems:YES];
    
    [BPInterface request:api param:param success:^(BPResponseModel *responseObject) {
        if (responseObject.status == 0) {
            // 获取到广告详情进行处理
        } else {
            [BPUtil showMessage:responseObject.content];
        }
    } failure:^(NSError *error) {
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (void)clickJumpBtn {
    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window.subviews.copy enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [obj removeFromSuperview];
        }];
        self.window.hidden = YES;
        self.window = nil;
    }];
}

- (void)setupSubviews:(UIWindow*)window {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.bounds];
    
    NSString *imgPath = [BPUtil getFilePathBy:AD_IMG_NAME];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imgPath]];
    
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAd)];
    [imageView addGestureRecognizer:tap];

    [window addSubview:imageView];
    
    _countdown = 4;
    
    _countdownBtn = [[UIButton alloc] initWithFrame:CGRectMake(window.bounds.size.width - 65 - 20, 20, 65, 30)];
    [_countdownBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    _countdownBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _countdownBtn.layer.cornerRadius = 3.5;
    [_countdownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_countdownBtn addTarget:self action:@selector(clickJumpBtn) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:_countdownBtn];
    
    [self timer];
}

- (void)timer {
    if (_countdown <= 1) {
        [self hide];
    } else {
        [_countdownBtn setTitle:[NSString stringWithFormat:@"跳过 %ld",(long)--_countdown] forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self timer];
        });
    }
}

- (void)asyncDownloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [BPUtil getFilePathBy:imageName];
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
            [BPUtil writeDict:_curAdDict to:AD_INFO];
        }else{
            NSLog(@"保存图片失败");
        }
    });
}

@end
