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

@interface HZQPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *backgVIew;

@end

@implementation HZQPickerView

+ (void)showPickerViewInVC:(UIViewController *)parentVC titles:(NSArray *)titles block:(HZQBlock)block {
    curTitles = titles;
    curBlock = block;
    
    HZQPickerView *pickerView = [[[NSBundle mainBundle] loadNibNamed:@"HZQPickerView" owner:nil options:nil] firstObject];
    pickerView.frame = parentVC.view.bounds;
    [parentVC.view addSubview:pickerView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgVIew.layer.cornerRadius = 5;
    self.backgVIew.layer.borderWidth = 1;
    self.backgVIew.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backgVIew.layer.masksToBounds = YES;
    
    self.sureBtn.layer.cornerRadius = 3;
    self.sureBtn.layer.borderWidth = 1;
    self.sureBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.sureBtn.layer.masksToBounds = YES;
    
    self.cannelBtn.layer.cornerRadius = 3;
    self.cannelBtn.layer.borderWidth = 1;
    self.cannelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.cannelBtn.layer.masksToBounds = YES;
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
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
    return curTitles.count;
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
