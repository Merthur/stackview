//
//  CustomLabel.m
//  StackView-Demo
//
//  Created by Yichuan Zhang on 27/10/16.
//  Copyright © 2016 shangbin. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (CGSize)intrinsicContentSize
{
    if (self.customIntrinsicContentSize.height == 0 &&
        self.customIntrinsicContentSize.width == 0) {
        return [super intrinsicContentSize];
    }
    return self.customIntrinsicContentSize;
}

@end
