//
//  DemoOneController.m
//  StackView-Demo
//
//  Created by sharejoy_lx on 16-07-10.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "DemoOneController.h"
#import "Masonry.h"
#import "CustomLabel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static const CGFloat labelWidth = 5;

@interface DemoOneController ()

@property (nonatomic, strong) UIStackView *containerView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *removeBtn;
@property (nonatomic, strong) UILabel *lblLeft;
@property (nonatomic, strong) UILabel *lblRight;
@property (nonatomic, strong) UILabel *lblTop;
@property (nonatomic, strong) UILabel *lblBottom;

@end

@implementation DemoOneController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.containerView = [[UIStackView alloc] init];
    self.containerView.backgroundColor = [UIColor orangeColor];
    self.containerView.layer.borderColor = [UIColor redColor].CGColor;
    self.containerView.layer.borderWidth = 10;

    /** UILayoutConstraintAxis
     UILayoutConstraintAxisHorizontal
     UILayoutConstraintAxisVertical
     */
    self.containerView.axis = UILayoutConstraintAxisHorizontal;

    self.containerView.spacing = 0;

    /**  UIStackViewDistribution
     UIStackViewDistributionFill,
     UIStackViewDistributionFillEqually,
     UIStackViewDistributionFillProportionally,
     UIStackViewDistributionEqualSpacing,
     UIStackViewDistributionEqualCentering,
     */
    self.containerView.distribution = UIStackViewDistributionFill;
    
    /**  UIStackViewAlignment
     UIStackViewAlignmentFill,
     UIStackViewAlignmentLeading,
     UIStackViewAlignmentTop = UIStackViewAlignmentLeading,
     UIStackViewAlignmentFirstBaseline,
     UIStackViewAlignmentCenter,
     UIStackViewAlignmentTrailing,
     UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing,
     UIStackViewAlignmentLastBaseline,
     */
    self.containerView.alignment = UIStackViewAlignmentCenter;

    [self.view addSubview:self.containerView];
    
    [self configAssistantViews];
}

- (void)configAssistantViews
{
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setTitle:@"Add Label" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    
    self.removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.removeBtn setTitle:@"Remove Label" forState:UIControlStateNormal];
    [self.removeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.removeBtn addTarget:self action:@selector(removeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.removeBtn];
    
    self.lblBottom = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.lblBottom];
    
    self.lblTop= [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.lblTop];
    
    self.lblLeft = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.lblLeft];
    
    self.lblRight = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.lblRight];
    
    self.lblBottom.backgroundColor = self.lblTop.backgroundColor = self.lblLeft.backgroundColor = self.lblRight.backgroundColor = [UIColor blackColor];
}

- (void)addClick:(id)sender
{
    NSLog(@"Before Add arrangedSubviews: %zd Subviews: %zd", self.containerView.arrangedSubviews.count, self.containerView.subviews.count);

    CustomLabel *view = [[CustomLabel alloc] initWithFrame:CGRectZero];
//    view.numberOfLines = 0;
    view.textAlignment = NSTextAlignmentCenter;
    view.text = @"test";

//    int count = (int)(3 - self.containerView.subviews.count);
//    [view setContentHuggingPriority:abs(count)
//                            forAxis:self.containerView.axis];

//    view.customIntrinsicContentSize = CGSizeMake(100, 30);
//    [view setContentCompressionResistancePriority:abs(count)
//                                          forAxis:self.containerView.axis];
    NSLog(@"%f %f", [view contentCompressionResistancePriorityForAxis:self.containerView.axis],
          [view contentHuggingPriorityForAxis:self.containerView.axis]);

//    CGRect frame = view.frame;
//    frame.size = CGSizeMake((self.containerView.subviews.count+1) * 5, 30);
//    view.frame = frame;
    view.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];

    [self.containerView addArrangedSubview:view];
//    [self.containerView addSubview:view];

    [UIView animateWithDuration:1.0 animations:^{
        [self.containerView layoutIfNeeded];
    }];

    NSLog(@"After Add arrangedSubviews: %zd Subviews: %zd", self.containerView.arrangedSubviews.count, self.containerView.subviews.count);
}

- (void)removeClick:(id)sender
{
    NSLog(@"Before Remove arrangedSubviews: %zd Subviews: %zd", self.containerView.arrangedSubviews.count, self.containerView.subviews.count);
    
    UIView *view = self.containerView.arrangedSubviews.lastObject;
    [self.containerView removeArrangedSubview:view];
//    [view removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        [self.containerView layoutIfNeeded];
    }];
    NSLog(@"After Remove arrangedSubviews: %zd Subviews: %zd", self.containerView.arrangedSubviews.count, self.containerView.subviews.count);
}

- (void)updateViewConstraints
{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(70+labelWidth);
//        make.leading.equalTo(self.view.mas_leading).offset(labelWidth);
//        make.trailing.equalTo(self.view.mas_trailing).offset(-labelWidth);
    }];
    
    [self.lblRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.containerView.mas_leading);
        make.top.equalTo(self.containerView.mas_top);
        make.height.equalTo(self.containerView.mas_height);
        make.width.mas_equalTo(labelWidth);
    }];
    
    [self.lblLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.containerView.mas_trailing);
        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.containerView.mas_top);
        make.height.equalTo(self.containerView.mas_height);
        make.width.mas_equalTo(labelWidth);
    }];

    [self.lblTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.containerView.mas_trailing);
        make.top.equalTo(self.view.mas_top).offset(70);
        make.bottom.equalTo(self.containerView.mas_top);
        make.width.equalTo(self.containerView.mas_width);
        make.height.mas_equalTo(labelWidth);
    }];
    
    [self.lblBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.containerView.mas_trailing);
        make.top.equalTo(self.containerView.mas_bottom);
        make.width.equalTo(self.containerView.mas_width);
        make.height.mas_equalTo(labelWidth);
    }];

    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblBottom.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view.mas_leading).offset(10);
        make.width.equalTo(self.removeBtn.mas_width);
        make.height.mas_equalTo(50);
    }];

    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblBottom.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.addBtn.mas_trailing).offset(10);
        make.trailing.equalTo(self.view.mas_trailing).offset(-10);
        make.height.mas_equalTo(50);
    }];

    [super updateViewConstraints];
}

@end
