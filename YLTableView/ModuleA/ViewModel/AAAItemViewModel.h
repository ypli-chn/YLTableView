//
//  AAAItemViewModel.h
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAAItemViewModel : NSObject
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithTitle:(NSString *)title;
@end
