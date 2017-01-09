//
//  YLTableViewSection.h
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLTableView;

/**
 * cell of YLTableView must implement YLTableViewCellProtocol
 **/
@protocol YLTableViewCellProtocol <NSObject>
@required
- (void)configWithViewModel:(id)viewModel;
+ (CGFloat)height;
@end



@interface YLTableViewSection : NSObject
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

@property (nonatomic, copy) NSArray *viewModels;
@property (nonatomic, copy, readonly) NSString *title; //default is class's title



+ (BOOL)enable; //default is YES

- (void)configCell:(UITableViewCell *)cell forRowIndex:(NSInteger)rowIndex;

- (id)objectForSelectRowIndex:(NSInteger)rowIndex;

// subclass of YLTableViewSection must override viewModels and cellClassForViewModelClass
//- (NSArray *)viewModels;
+ (NSDictionary *)cellClassForViewModelClass;

// Used for updating data like to launch a network request.
- (void)setNeedUpdate;

#pragma mark - interceptor
- (BOOL)beforeSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)afterSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
