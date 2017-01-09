//
//  BBBCell.h
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTableView.h"
#import "BBBItemViewModel.h"
@interface BBBCell : UITableViewCell<YLTableViewCellProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) BBBItemViewModel *viewModel;
@end
