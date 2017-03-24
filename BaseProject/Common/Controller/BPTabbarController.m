#import "BPTabbarController.h"

@interface BPTabbarController ()

@end

@implementation BPTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    [self addChildViewControllers];
    [self setupNavigationBackItem];
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

- (void)addChildVC:(UIViewController*)vc withTitle:(NSString*)title withImage:(NSString*)imageName withSelectedImage:(NSString*)selectedImageName{
    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    BPNavigationController *navi = [[BPNavigationController alloc] initWithRootViewController:vc];
    navi.interactivePopGestureRecognizer.enabled = YES;
    [self addChildViewController:navi];
}

@end
