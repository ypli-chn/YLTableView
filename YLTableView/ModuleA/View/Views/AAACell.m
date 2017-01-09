//
//  AAACell.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "AAACell.h"

@implementation AAACell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - YLTableViewCellProtocol
- (void)configWithViewModel:(AAAItemViewModel *)viewModel {
    self.viewModel = viewModel;
    self.textLabel.text = viewModel.title;
}

+ (CGFloat)height {
    return 50;
}

@end
