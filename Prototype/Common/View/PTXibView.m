//
//  PTXibView.m
//  Prototype
//
//  Created by mc003 on 2017/8/16.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import "PTXibView.h"

@interface PTXibView()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation PTXibView

/*
 在initWithCoder:里面访问属性，比如self.button，会发现它是nil的，因为此时自定义控件正在初始化，self.button可能还未赋值（self.button是一个IBOutlet，IBOutlet本质上就相当于Xcode找到这个对应的属性，然后UIButton button = … , [self.view addSubview: button]这种操作，而这一切的操作都是相当于在CYLView view = [[CYLView alloc] initWithCoder: nil]方法之后执行的。上面的代码就相当于用代码的方式实现Xcode在storyboard中加载CYLView），所以如果在这个方法中进行初始化操作是可能会失败的。
 所以建议在awakeFromNib方法中进行初始化的额外操作。因为awakeFromNib是在初始化完成后调用，所以在这个方法里面访问属性（IBOutlet）就可以保证不为nil。
 如果我们想，无论是通过代码的方式，还是通过xib的方式，都会初始化一些值，那么我们可以将初始化的代码抽到一个方法里面，然后在initWithFrame:方法和awakeFromNib方法中分别调用这个方法。
 */

- (void)setCodeModel:(PTCodeModel *)codeModel {
    _codeModel = codeModel; // 注意在这个方法中，不写这句也是没有问题的，因为在下面的语句使用的是codeModel而非self.codeModel或_codeModel，但是如果在其他的方法中也想要访问codeModel这个属性，那么就需要写上，否则self.codeModel或_codeModel会一直是nil（因为出了这个方法的作用域，codeModel就销毁了，如果再想访问需要有其他的引用指向它）。所以建议，要写上这句。
    
    [_button setTitle: _codeModel.title forState:UIControlStateNormal];
}

+ (instancetype)viewWithModel:(PTCodeModel *)codeModel {
    PTXibView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    view.codeModel = codeModel;
    
    return view;
}

@end
