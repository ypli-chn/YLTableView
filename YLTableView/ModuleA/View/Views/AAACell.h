//
//  AAACell.h
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTableView.h"
#import "AAAItemViewModel.h"
@interface AAACell : UITableViewCell<YLTableViewCellProtocol>
@property (nonatomic, strong) AAAItemViewModel *viewModel;
@end
