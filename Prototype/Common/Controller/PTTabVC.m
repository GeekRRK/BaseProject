#import "PTTabVC.h"
#import "PTNavVC.h"
#import "HomepageVC.h"
#import "VideoVC.h"
#import "MeVC.h"

@interface PTTabVC ()

@end

@implementation PTTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    [self setupNavigationBackItem];
    
    HomepageVC *vc1 = [[HomepageVC alloc] init];
    VideoVC *vc2 = [[VideoVC alloc] init];
    MeVC *vc3 = [[MeVC alloc] init];
    
    NSArray *vcs = @[vc1, vc2, vc3];
    
    NSArray *titles = @[@"首页", @"视频", @"我的"];
    NSArray *tabItemImages = @[@"tabbar_home", @"tabbar_video", @"tabbar_me"];
    NSArray *tabSelectedItemImages = @[@"tabbar_home_sel", @"tabbar_video_sel",  @"tabbar_me_sel"];
    
    [self addSubVCsWithVCs:vcs titles:titles imageNames:tabItemImages highlightedImageNames:tabSelectedItemImages];
}

- (void)setupNavigationBackItem {
    UIEdgeInsets insets = UIEdgeInsetsMake(4, 0, -4, 0);
    UIImage *alignedImage = [[UIImage imageNamed:@"navigation_back_arrow"] imageWithAlignmentRectInsets:insets];
    
    [[UINavigationBar appearance] setBackIndicatorImage:alignedImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:alignedImage];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)addSubVC:(UIViewController*)vc withTitle:(NSString*)title withImage:(NSString*)imageName withSelectedImage:(NSString*)selectedImageName{
    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    PTNavVC *navi = [[PTNavVC alloc] initWithRootViewController:vc];
    navi.interactivePopGestureRecognizer.enabled = YES;
    [self addChildViewController:navi];
}

- (void)addSubVCsWithVCs:(NSArray *)vcs titles:(NSArray *)titles imageNames:(NSArray *)imageNames highlightedImageNames:(NSArray *)highlightedImageNames {
    
    for (int i = 0; i < vcs.count; ++i) {
        [self addSubVC:vcs[i] withTitle:titles[i] withImage:imageNames[i] withSelectedImage:highlightedImageNames[i]];
    }
}

@end
