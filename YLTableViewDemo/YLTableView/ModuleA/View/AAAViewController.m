//
//  AAAViewController.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "AAAViewController.h"

@interface AAAViewController ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation AAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.textLabel.text = self.message;
    [self.textLabel sizeToFit];
    
    
    [self.view addSubview:self.textLabel];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.textLabel.center = self.view.center;
}

#pragma mark - getter
- (UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
    }
    return _textLabel;
}

@end
