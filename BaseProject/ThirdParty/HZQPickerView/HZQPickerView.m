//
//  HZQDatePickerView.m
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import "HZQPickerView.h"

static HZQBlock curBlock;
static NSArray *curTitles;
static int curNumOfComponent;
static NSString *curTitle;

@interface HZQPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *backgVIew;

@end

@implementation HZQPickerView

+ (void)showPickerViewInVC:(UIViewController *)parentVC titles:(NSArray *)titles numOfComponent:(int)numOfComponent block:(HZQBlock)block {
    curTitles = titles;
    curBlock = block;
    curNumOfComponent = numOfComponent;
    
    HZQPickerView *pickerView = [[[NSBundle mainBundle] loadNibNamed:@"HZQPickerView" owner:nil options:nil] firstObject];
    pickerView.frame = parentVC.view.bounds;
    [parentVC.view addSubview:pickerView];
    
    NSArray *arr = @[@{@"河北省":@[@"石家庄", @"承德"]}, @{@"上海市":@[@"嘉定区", @"黄浦区"]}];
    NSLog(@"%@", arr);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _backgVIew.layer.cornerRadius = 5;
    _backgVIew.layer.borderWidth = 1;
    _backgVIew.layer.borderColor = [UIColor whiteColor].CGColor;
    _backgVIew.layer.masksToBounds = YES;
    
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.layer.borderWidth = 1;
    _sureBtn.layer.borderColor = [UIColor redColor].CGColor;
    _sureBtn.layer.masksToBounds = YES;
    
    _cannelBtn.layer.cornerRadius = 3;
    _cannelBtn.layer.borderWidth = 1;
    _cannelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _cannelBtn.layer.masksToBounds = YES;
    
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
}

- (void)animationbegin:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = 0.1;
    animation.repeatCount = -1;
    animation.autoreverses = YES;
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.9];
    
    [view.layer addAnimation:animation forKey:@"scale-layer"];
}

- (IBAction)removeBtnClick:(id)sender {
    [self animationbegin:sender];

    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)sureBtnClick:(id)sender {
    NSInteger numOfComponents = _pickerView.numberOfComponents;
    NSMutableArray *indexs = [[NSMutableArray alloc] init];
    for (int i = 0; i < numOfComponents; ++i) {
        NSNumber *indexObj = [NSNumber numberWithInteger:[_pickerView selectedRowInComponent:i]];
        [indexs addObject:indexObj];
    }
    
    curBlock(1, 2, 3);
    
    [self animationbegin:sender];
    
    [self removeBtnClick:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return curNumOfComponent;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *titleOfRows = curTitles[component];
    
    return titleOfRows.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = curTitles[component][row];
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

@end