//
//  BBBCell.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "BBBCell.h"
#import "BBBItemViewModel.h"

@implementation BBBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithViewModel:(BBBItemViewModel *)viewModel {
    self.iconImageView.image = viewModel.image;
}

+ (CGFloat)height {
    return 80;
}

@end
