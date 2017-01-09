//
//  AAASection.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "AAASection.h"
#import "AAACell.h"

#import "AAAViewController.h"
@interface AAASection()

@end
@implementation AAASection
+ (NSDictionary *)cellClassForViewModelClass {
    return @{
             @"AAACell":@"AAAItemViewModel"
             };
}

- (id)objectForSelectRowIndex:(NSInteger)rowIndex {
    AAAItemViewModel *viewModel = self.viewModels[rowIndex];
    AAAViewController *vc = [[AAAViewController alloc] init];
    vc.message = viewModel.title;
    return vc;
}

- (void)setNeedUpdate {
    // need to update data
}

+ (AAASection *)testExample {
    AAAItemViewModel *viewModel1 = [[AAAItemViewModel alloc] initWithTitle:@"AAAModule: Test 1"];
    AAAItemViewModel *viewModel2 = [[AAAItemViewModel alloc] initWithTitle:@"AAAModule: Test 2"];
    AAAItemViewModel *viewModel3 = [[AAAItemViewModel alloc] initWithTitle:@"AAAModule: Test 3"];
    AAAItemViewModel *viewModel4 = [[AAAItemViewModel alloc] initWithTitle:@"AAAModule: Test 4"];
    
    AAASection *example = [[AAASection alloc] init];
    example.viewModels =  @[viewModel1, viewModel2, viewModel3, viewModel4];
    return example;
}

@end
