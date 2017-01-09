//
//  ViewController.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "ViewController.h"
#import "YLTableView.h"


// Needn't import sections in actual project.
// Just fetch a instance of AAASection as YLTableViewSection from Mediator
#import "AAASection.h"
#import "BBBSection.h"



@interface ViewController ()<YLTableViewDelegate>
@property (nonatomic, strong) YLTableView *tableView;

@property (nonatomic, strong) YLTableViewSection *mAAASection;
@property (nonatomic, strong) YLTableViewSection *mBBBSection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mAAASection = [AAASection testExample];
    self.mBBBSection = [BBBSection testExample];
    
    [self.tableView registerSection:self.mAAASection];
    [self.tableView registerSection:self.mBBBSection];
    
    [self.view addSubview:self.tableView];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

#pragma mark - YLTableViewDelegate
- (void)yl_tableView:(YLTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath section:(YLTableViewSection *)section withObject:(id)obj {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([obj isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:obj animated:YES];
    }
}

#pragma mark - getter
- (YLTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[YLTableView alloc] initWithFrame:self.view.frame];
        _tableView.yl_delegate = self;
    }
    return _tableView;
}

@end
