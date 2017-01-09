//
//  YLTableViewSection.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLTableViewSection.h"
@interface YLTableViewSection()
@end


@implementation YLTableViewSection
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Public API

- (NSString *)title {
    return NSStringFromClass([self class]);
}

+ (BOOL)enable {
    return YES;
}

- (void)configCell:(UITableViewCell *)cell forRowIndex:(NSInteger)rowIndex {
    // do nothing in base class.
}

- (id)objectForSelectRowIndex:(NSInteger)rowIndex {
    return nil;
}

+ (NSDictionary<NSString *,NSString *> *)cellClassForViewModelClass {
    @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ init failed",[self class]]
                                   reason:@"Subclass of YLTableViewSection should override @selector(cellClassForViewModelClass)"
                                 userInfo:nil];
}

- (void)setNeedUpdate {
    // do nothing in base class.
}

#pragma mark - interceptor
- (BOOL)beforeSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)afterSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

