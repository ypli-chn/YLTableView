//
//  BBBSection.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "BBBSection.h"
#import "BBBCell.h"
#import "BBBItemViewModel.h"
#import "BBBViewController.h"

@interface BBBSection()
@property (nonatomic, strong) BBBItemViewModel *viewModel;
@end

@implementation BBBSection

- (instancetype)init {
    self = [super init];
    if (self) {
        BBBItemViewModel *viewModel1 = [[BBBItemViewModel alloc] init];
        viewModel1.image = [UIImage imageNamed:@"avatar"];
        
        self.viewModels = @[viewModel1];
    }
    return self;
}

+ (NSDictionary *)cellClassForViewModelClass {
    return @{
             @"BBBCell":@"BBBItemViewModel"
             };
}


- (id)objectForSelectRowIndex:(NSInteger)rowIndex {
    BBBItemViewModel *viewModel = self.viewModels[rowIndex];
    BBBViewController *vc = [[BBBViewController alloc] init];
    vc.imageView.image = viewModel.image;
    return vc;
}

+ (BBBSection *)testExample {
    return [[BBBSection alloc] init];
}


@end
