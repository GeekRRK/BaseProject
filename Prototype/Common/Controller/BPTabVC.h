#import <UIKit/UIKit.h>
#import "BPNavVC.h"

@interface BPTabVC : UITabBarController

- (void)addChildViewControllers;

- (void)addChildVC:(UIViewController*)vc withTitle:(NSString*)title withImage:(NSString*)imageName withSelectedImage:(NSString*)selectedImageName;

@end
