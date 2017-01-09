//
//  YLTableView.m
//  YLTableView
//
//  Created by Yunpeng on 2016/10/5.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLTableView.h"

@interface YLTableView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<YLTableViewSection *> *sections;
@property (nonatomic, strong) NSMutableArray<YLTableViewSection *> *visibleSections;
@property (nonatomic, strong) NSMutableDictionary<Class, Class> *cellClassMap;
@end

@implementation YLTableView

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLTableViewSection *section = self.visibleSections[indexPath.section];
    if([section beforeSelectRowAtIndexPath:indexPath]) {
        if ([self.yl_delegate respondsToSelector:@selector(yl_tableView:didSelectRowAtIndexPath:section:withObject:)]) {
            id obj = [section objectForSelectRowIndex:indexPath.row];
            [self.yl_delegate yl_tableView:self didSelectRowAtIndexPath:indexPath section:section withObject:obj];
        }
        [section afterSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.visibleSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"[numberOfRowsInSection]section: %td count:%td",section, self.visibleSections[section].viewModels.count);
    if(self.visibleSections.count != 0) {
        return self.visibleSections[section].viewModels.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id viewModel = self.visibleSections[indexPath.section].viewModels[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self identifierOfViewModel:viewModel]
                                                            forIndexPath:indexPath];
    [cell performSelector:@selector(configWithViewModel:) withObject:viewModel];
    
    [self.visibleSections[indexPath.section] configCell:cell forRowIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id viewModel = self.visibleSections[indexPath.section].viewModels[indexPath.row];
    return [(id<YLTableViewCellProtocol>)self.cellClassMap[[viewModel class]] height];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    YLTableViewSection *sec = self.visibleSections[section];
    if(!sec.hidden
       && [self.yl_delegate respondsToSelector:@selector(yl_tableView:heightForHeaderInSection:)]) {
        return [self.yl_delegate yl_tableView:self heightForHeaderInSection:sec];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    YLTableViewSection *sec = self.visibleSections[section];
    if(!sec.hidden
       && [self.yl_delegate respondsToSelector:@selector(yl_tableView:heightForFooterInSection:)]) {
        return [self.yl_delegate yl_tableView:self heightForFooterInSection:sec];
    }
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YLTableViewSection *sec = self.visibleSections[section];
    if(!sec.hidden
       && [self.yl_delegate respondsToSelector:@selector(yl_tableView:viewForHeaderInSection:)]) {
        return [self.yl_delegate yl_tableView:self viewForHeaderInSection:sec];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YLTableViewSection *sec = self.visibleSections[section];
    if(!sec.hidden
       && [self.yl_delegate respondsToSelector:@selector(yl_tableView:viewForFooterInSection:)]) {
        return [self.yl_delegate yl_tableView:self viewForFooterInSection:sec];
    }
    return nil;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.yl_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.yl_delegate scrollViewDidScroll:scrollView];
    }
}




#pragma mark - Public API
- (void)registerSection:(YLTableViewSection *)section {
    [self registerSection:section atIndex:NSIntegerMax];
}

- (void)registerSection:(YLTableViewSection *)section atIndex:(NSInteger)index {
    if (section == nil) {
        NSLog(@"注册失败,section为nil");
        return;
    }
    
    NSDictionary<NSString *, NSString *> *dict = [[section class] cellClassForViewModelClass];
    
    __weak __typeof(self) weakSelf = self;
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        Class cellClass = NSClassFromString(key);
        Class viewModelClass = NSClassFromString(obj);
        [strongSelf bindCellClass:cellClass withViewModelClass:viewModelClass];
    }];
    
    
    if (index < 0) {
        [self.sections insertObject:section atIndex:0];
    } else if(index >= self.sections.count) {
        [self.sections addObject:section];
    } else {
        [self.sections insertObject:section atIndex:index];
    }
    
    if (!section.hidden) {
        [self addSectionToVisibleSections:section];
    }
    
    
    // KVO
    [section addObserver:self
              forKeyPath:@"viewModels"
                 options:NSKeyValueObservingOptionNew
                 context:nil];
    
    [section addObserver:self
              forKeyPath:@"hidden"
                 options:NSKeyValueObservingOptionNew
                 context:nil];
    
    NSLog(@"%@",self.sections);
}

//- (void)adjustSection:(YLTableViewSection *)section toIndex:(NSInteger)index {
//    // TO DO
//    
//}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([object isKindOfClass:[YLTableViewSection class]]) {
        YLTableViewSection *section = object;
        
        if ([keyPath isEqualToString:@"viewModels"]) {
            NSInteger index = [self.visibleSections indexOfObject:section];
            if (index != NSNotFound) {
                [self reloadSections:[NSIndexSet indexSetWithIndex:index]
                    withRowAnimation:UITableViewRowAnimationNone];
            }
        } else if([keyPath isEqualToString:@"hidden"]) {
            NSInteger targetIndex = [self.visibleSections indexOfObject:section];
            if (section.hidden) {
                if (targetIndex >= 0) {
                    [self.visibleSections removeObjectAtIndex:targetIndex];
                    [self deleteSections:[NSIndexSet indexSetWithIndex:targetIndex]
                        withRowAnimation:UITableViewRowAnimationFade];
                }
            } else {
                if (targetIndex == NSNotFound) {
                    NSUInteger targetIndex = [self addSectionToVisibleSections:section];
                    [self insertSections:[NSIndexSet indexSetWithIndex:targetIndex]
                        withRowAnimation:UITableViewRowAnimationFade];
                }
            }
        }
    }
}

#pragma mark - Private API
- (NSUInteger)addSectionToVisibleSections:(YLTableViewSection *)section {
    if(section.hidden) {
        NSLog(@"[WAR]");
    }
    
    NSUInteger index = [self.sections indexOfObject:section];
    
    __block NSUInteger targetIndex = self.visibleSections.count; // 默认最后一个
    [self.visibleSections enumerateObjectsUsingBlock:^(YLTableViewSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger tmpIndex = [self.sections indexOfObject:obj];
        if(tmpIndex >= index) {
            targetIndex = idx;
            *stop = YES;
        }
    }];
    
    [self.visibleSections insertObject:section atIndex:targetIndex];
    return targetIndex;
}


- (void)bindCellClass:(Class)cellClass withViewModelClass:(Class)modelClass {
    NSParameterAssert(modelClass);
    [self registerCellWithClass:cellClass];
    self.cellClassMap[(id<NSCopying>)modelClass] = cellClass;
}

- (void)registerCellWithClass:(Class)clazz {
    if (![clazz conformsToProtocol:@protocol(YLTableViewCellProtocol)]) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ init failed",[self class]]
                                       reason:@"cell of YLTableView should implement <YLTableViewCellProtocol>"
                                     userInfo:nil];
    }
    
    NSLog(@"register %@",NSStringFromClass(clazz));
    NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clazz) ofType:@"nib"];
    if (path != nil) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(clazz) bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:[self identifierOfClass:clazz]];
    } else {
        [self registerClass:clazz forCellReuseIdentifier:[self identifierOfClass:clazz]];
    }
}


- (NSString *)identifierOfViewModel:(id)viewModel {
    return [self identifierOfClass:self.cellClassMap[[viewModel class]]];
}

- (NSString *)identifierOfClass:(Class)clazz {
    NSLog(@"identifierOfClass:%@",NSStringFromClass(clazz));
    return NSStringFromClass(clazz);
}

#pragma mark - getter && setter
- (NSMutableArray<YLTableViewSection *> *)sections {
    if (_sections == nil) {
        _sections = [NSMutableArray new];
    }
    return _sections;
}

- (NSMutableArray<YLTableViewSection *> *)visibleSections {
    if (_visibleSections == nil) {
        _visibleSections = [NSMutableArray new];
    }
    return _visibleSections;
}

- (NSMutableDictionary<Class,Class> *)cellClassMap {
    if (_cellClassMap == nil) {
        _cellClassMap = [NSMutableDictionary dictionary];
    }
    return _cellClassMap;
}


- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if(delegate != nil
       && delegate != self) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ Error",[self class]]
                                       reason:@"DON'T change delegate of YLTableView. Use yl_delegate instead."
                                     userInfo:nil];
    }
    [super setDelegate:delegate];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    if (dataSource != nil
        && dataSource != self) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ Error",[self class]]
                                       reason:@"DON'T change dataSource of YLTableView. Use yl_delegate instead."
                                     userInfo:nil];
    }
    [super setDataSource:dataSource];
}


- (void)dealloc {
    for (YLTableViewSection *section in self.sections) {
        [section removeObserver:self forKeyPath:@"viewModels"];
        [section removeObserver:self forKeyPath:@"hidden"];
    }
}
@end
