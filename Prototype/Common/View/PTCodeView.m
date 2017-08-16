//
//  PTCodeView.m
//  Prototype
//
//  Created by mc003 on 2017/8/16.
//  Copyright © 2017年 GeekRRK. All rights reserved.
//

#import "PTCodeView.h"

@interface PTCodeView()

@property (weak, nonatomic) UIButton *button; // 注意这里使用weak就可以，因为button已经被加入到self.view.subviews这个数组里。

@end

@implementation PTCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview: button];
        _button = button; //将self.button指向这个button保证在layoutSubviews中可以访问
        
        return self;
    }
    
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews]; // 注意，一定不要忘记调用父类的layoutSubviews方法！
    
    float w = self.frame.size.width / 2;
    float h = self.frame.size.height / 2;
    float x = (self.frame.size.width - w) / 2;
    float y = (self.frame.size.height - h) / 2;
    _button.frame = CGRectMake(x, y, w, h);
}

- (void)setCodeModel:(PTCodeModel *)codeModel {
    _codeModel = codeModel; // 注意在这个方法中，不写这句也是没有问题的，因为在下面的语句使用的是codeModel而非self.codeModel或_codeModel，但是如果在其他的方法中也想要访问codeModel这个属性，那么就需要写上，否则self.codeModel或_codeModel会一直是nil（因为出了这个方法的作用域，codeModel就销毁了，如果再想访问需要有其他的引用指向它）。所以建议，要写上这句。
    
    [_button setTitle: _codeModel.title forState:UIControlStateNormal];
}

@end
