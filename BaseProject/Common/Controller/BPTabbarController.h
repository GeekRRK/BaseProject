#import <UIKit/UIKit.h>
#import "BPNavigationController.h"

@interface BPTabbarController : UITabBarController

-(void)addChildViewControllers;

- (void)addChildVC:(UIViewController*)vc withTitle:(NSString*)title withImage:(NSString*)imageName withSelectedImage:(NSString*)selectedImageName;

@end
