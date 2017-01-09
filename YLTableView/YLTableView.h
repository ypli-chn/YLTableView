//
//  YLTableView.h
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTableViewSection.h"


@protocol YLTableViewDelegate <NSObject, UIScrollViewDelegate>
- (void)yl_tableView:(YLTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath section:(YLTableViewSection *)section withObject:(id)obj;

@optional
- (CGFloat)yl_tableView:(YLTableView *)tableView heightForHeaderInSection:(YLTableViewSection *)section;
- (CGFloat)yl_tableView:(YLTableView *)tableView heightForFooterInSection:(YLTableViewSection *)section;
- (UIView *)yl_tableView:(YLTableView *)tableView viewForHeaderInSection:(YLTableViewSection *)section;
- (UIView *)yl_tableView:(YLTableView *)tableView viewForFooterInSection:(YLTableViewSection *)section;
@end


@interface YLTableView : UITableView
@property (nonatomic, weak, setter=yl_setDelegate:) id<YLTableViewDelegate> yl_delegate;
- (void)registerSection:(YLTableViewSection *)section;
- (void)registerSection:(YLTableViewSection *)section atIndex:(NSInteger)index;
//- (void)adjustSection:(YLTableViewSection *)section toIndex:(NSInteger)index;
@end
