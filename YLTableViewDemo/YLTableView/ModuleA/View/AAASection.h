//
//  AAASection.h
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLTableViewSection.h"
#import "AAAItemViewModel.h"
@interface AAASection : YLTableViewSection
@property (nonatomic, copy) NSArray<AAAItemViewModel *> *viewModels;

+ (AAASection *)testExample;
@end
