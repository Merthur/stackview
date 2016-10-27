//
//  ViewController.m
//  StackView-Demo
//
//  Created by sharejoy_lx on 16-07-10.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "DemoTwoController.h"
#import "Masonry.h"

#define RadomColor [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1]

static const CGFloat labelWidth = 5;

@interface DemoTwoController ()

@property (nonatomic, strong) UIStackView *horizontalView;
@property (nonatomic, strong) UIStackView *verticalView;
@property (nonatomic, strong) UIButton *addHorizontalBtn;
@property (nonatomic, strong) UIButton *removeHorizontalBtn;
@property (nonatomic, strong) UIButton *addVerticalBtn;
@property (nonatomic, strong) UIButton *removeVerticalBtn;
@property (nonatomic, strong) UILabel *lblLeft;

@end

@implementation DemoTwoController

- (UIStackView *)horizontalView
{
    if (!_horizontalView) {
        _horizontalView = [[UIStackView alloc] init];
        _horizontalView.axis = UILayoutConstraintAxisHorizontal;
        _horizontalView.distribution = UIStackViewDistributionFillEqually;
        _horizontalView.spacing = 10;
        _horizontalView.alignment = UIStackViewAlignmentFill;
        
    }
    return _horizontalView;
}

- (UIStackView *)verticalView
{
    if (!_verticalView) {
        _verticalView = [[UIStackView alloc] init];
        _verticalView.axis = UILayoutConstraintAxisVertical;
        _verticalView.distribution = UIStackViewDistributionFillEqually;
        _verticalView.spacing = 10;
        _verticalView.alignment = UIStackViewAlignmentFill;

    }
    return _verticalView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.verticalView];
    
    self.lblLeft = [[UILabel alloc] initWithFrame:CGRectZero];
    self.lblLeft.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.lblLeft];
    
    [self addClickEvent];
}

- (void)addClickEvent
{
    self.addHorizontalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addHorizontalBtn setTitle:@"Add Horizontal" forState:UIControlStateNormal];
    [self.addHorizontalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    [self.addHorizontalBtn addTarget:self action:@selector(addHorizontalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addHorizontalBtn];
    
    self.removeHorizontalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.removeHorizontalBtn setTitle:@"Remove Horizontal" forState:UIControlStateNormal];
    [self.removeHorizontalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    [self.removeHorizontalBtn addTarget:self action:@selector(removeHorizontalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.removeHorizontalBtn];
    
    self.addVerticalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addVerticalBtn setTitle:@"Add Vertical" forState:UIControlStateNormal];
    [self.addVerticalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    [self.addVerticalBtn addTarget:self action:@selector(addVerticalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addVerticalBtn];
    
    self.removeVerticalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.removeVerticalBtn setTitle:@"Remove Vertical" forState:UIControlStateNormal];
    [self.removeVerticalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    [self.removeVerticalBtn addTarget:self action:@selector(removeVerticalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.removeVerticalBtn];
}

- (void)addHorizontalClick
{
    if (!_horizontalView) {
        [self.verticalView addArrangedSubview:self.horizontalView];
    }
    
    UIImageView *imgView = [self getGodAnimal];
    [self.horizontalView addArrangedSubview:imgView];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.horizontalView layoutIfNeeded];
    }];
    
}

- (void)removeHorizontalClick
{
    if (!_horizontalView) return;
    UIView *view = [self.horizontalView subviews].lastObject;
    if (!view) return;
    
//    [self.horizontalView removeArrangedSubview:view];
    [view removeFromSuperview];
    view = nil;
    [UIView animateWithDuration:0.25 animations:^{
        [self.horizontalView layoutIfNeeded];
    }];
}


- (void)addVerticalClick
{
    UIImageView *imgView = [self getGodAnimal];
    [self.verticalView insertArrangedSubview:imgView atIndex:0];
    [UIView animateWithDuration:0.25 animations:^{
        [self.verticalView layoutIfNeeded];
    }];
}

- (void)removeVerticalClick
{
    if (!_verticalView) return;
    UIView *view = [self.verticalView subviews].lastObject;
    if (!view) return;
    if ([view isKindOfClass:[UIStackView class]]) return;
    
//    [self.verticalView removeArrangedSubview:view];
    [view removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        [self.verticalView layoutIfNeeded];
    }];
}

- (UIImageView *)getGodAnimal
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    NSString *imgName = [NSString stringWithFormat:@"666_%zd.jpg",random()%9+1];
    imgView.image = [self imageWithImage:[UIImage imageNamed:imgName] convertToSize:CGSizeMake(50, 50)];
    return imgView;
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (void)updateViewConstraints
{
    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
//        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.view.mas_top).offset(70);
    }];
    
    [self.lblLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verticalView.mas_top);
        make.leading.equalTo(self.verticalView.mas_trailing);
        make.height.equalTo(self.verticalView.mas_height);
        make.width.mas_equalTo(labelWidth);
    }];

    [self.addHorizontalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verticalView.mas_bottom);
        make.leading.equalTo(self.view.mas_leading).offset(10);
        make.width.equalTo(self.removeHorizontalBtn.mas_width);
        make.height.mas_equalTo(50);
    }];

    [self.removeHorizontalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verticalView.mas_bottom);
        make.leading.equalTo(self.addHorizontalBtn.mas_trailing).offset(10);
        make.trailing.equalTo(self.view.mas_trailing).offset(-10);
        make.height.mas_equalTo(50);
    }];

    [self.addVerticalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addHorizontalBtn.mas_bottom);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-5);
        make.leading.equalTo(self.view.mas_leading).offset(10);
        make.width.equalTo(self.removeVerticalBtn.mas_width);
        make.height.mas_equalTo(50);
    }];

    [self.removeVerticalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.removeHorizontalBtn.mas_bottom);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-5);
        make.leading.equalTo(self.addVerticalBtn.mas_trailing).offset(10);
        make.trailing.equalTo(self.view.mas_trailing).offset(-10);
        make.height.mas_equalTo(50);
    }];

    [super updateViewConstraints];
}

@end
