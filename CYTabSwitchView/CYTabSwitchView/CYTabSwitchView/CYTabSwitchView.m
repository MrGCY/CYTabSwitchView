//
//  CYTabSwitchView.m
//  CYTabSwitchView
//
//  Created by Mr.GCY on 2019/5/14.
//  Copyright © 2019 Mr.GCY. All rights reserved.
//

#import "CYTabSwitchView.h"
#import "CYTabButton.h"
#import "Masonry.h"
@interface CYTabSwitchView()
@property (nonatomic, strong) NSMutableArray <CYTabButton *>* tabButtonsArray;
@property (nonatomic, strong) UIView * contentView;
//当前选择的index
@property (nonatomic, assign,readwrite) NSInteger currentSelectIndex;
@end
@implementation CYTabSwitchView
-(instancetype)initWithFrame:(CGRect)frame{
     if (self = [super initWithFrame:frame]) {
          [self setupData];
          [self addScrollView];
     }
     return self;
}
-(void)layoutSubviews{
     [super layoutSubviews];
     [self addConstraintForSubTabs];
}
#pragma mark- setter
-(void)setTitleArray:(NSArray *)titleArray{
     _titleArray = titleArray;
     [self addTabButtons];
}
#pragma mark- lazy
-(NSMutableArray<CYTabButton *> *)tabButtonsArray{
     if (!_tabButtonsArray) {
          _tabButtonsArray = [NSMutableArray arrayWithCapacity:0];
     }
     return _tabButtonsArray;
}
-(void)setupData{
     self.selectFontSize = [UIFont boldSystemFontOfSize:30];
     self.normalFontSize = [UIFont boldSystemFontOfSize:15];
     self.selectTextColor = [UIColor redColor];
     self.normalTextColor = [UIColor greenColor];
     self.animationInterval = 0.3;
}
-(void)addScrollView{
     UIScrollView * scrollView = [[UIScrollView alloc] init];
     scrollView.showsVerticalScrollIndicator = NO;
     scrollView.showsHorizontalScrollIndicator = NO;
     scrollView.clipsToBounds = NO;
     [self addSubview:scrollView];
     [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.edges.equalTo(self);
     }];
     self.contentView = [[UIView alloc] init];
     self.contentView.clipsToBounds = NO;
     [scrollView addSubview:self.contentView];
     [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.edges.equalTo(scrollView);
          make.height.equalTo(scrollView);
     }];
}
-(void)addTabButtons{
     [self.tabButtonsArray removeAllObjects];
     for (int i = 0; i < self.titleArray.count; i++) {
          CYTabButton * btn = [[CYTabButton alloc] init];
          btn.selectFontSize = self.selectFontSize;
          btn.normalFontSize = self.normalFontSize;
          btn.selectTextColor = self.selectTextColor;
          btn.normalTextColor = self.normalTextColor;
          btn.animationInterval = self.animationInterval;
          btn.tag = i;
          btn.title = self.titleArray[i];
          [btn addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
          [self.tabButtonsArray addObject:btn];
     }
}

-(void)addConstraintForSubTabs{
     for (UIView * view in self.contentView.subviews) {
          [view removeFromSuperview];
     }
     MASViewAttribute * leftConstraint = self.contentView.mas_left;
     for (int i = 0; i < self.tabButtonsArray.count; i++) {
          CYTabButton * btn = self.tabButtonsArray[i];
          [self.contentView addSubview:btn];
          [self addConstraintForButton:btn leftSlibling:leftConstraint];
          leftConstraint = btn.mas_right;
     }
     [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(leftConstraint);
     }];
}
-(void)addConstraintForButton:(CYTabButton *)btn leftSlibling:(MASViewAttribute *)leftSlibling{
     NSInteger leftOffset = btn.tag == 0 ? 0 : 10;
     UIFont * font = self.normalFontSize;
     if (self.currentSelectIndex == btn.tag) {
          btn.selected = YES;
          font = self.selectFontSize;
     }
     CGSize size = [btn textSizeWithText:btn.title font:font];
     [btn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(leftSlibling).offset(leftOffset);
          make.bottom.mas_equalTo(0);
          make.width.mas_equalTo(size.width);
          make.height.equalTo(self.contentView.mas_height);
     }];
}
-(void)updateUI:(NSInteger)index{
     if (index == self.currentSelectIndex) {
          return;
     }
     CYTabButton * currentBtn = self.tabButtonsArray[index];
     CYTabButton * lastSelectBtn = self.tabButtonsArray[self.currentSelectIndex];
     [currentBtn setSelected:YES];
     [lastSelectBtn setSelected:NO];
     [currentBtn mas_updateConstraints:^(MASConstraintMaker *make) {
          make.width.mas_equalTo([currentBtn textSizeWithText:currentBtn.title font:self.selectFontSize].width);
     }];
     [lastSelectBtn mas_updateConstraints:^(MASConstraintMaker *make) {
          make.width.mas_equalTo([lastSelectBtn textSizeWithText:lastSelectBtn.title font:self.normalFontSize].width);
     }];
     [UIView animateWithDuration:self.animationInterval animations:^{
          [self layoutIfNeeded];
     }];
     self.currentSelectIndex = index;
}
-(void)tapButton:(CYTabButton *)sender{
     if (self.selectBlock != nil) {
          self.selectBlock(sender.tag);
     }
     [self updateUI:sender.tag];
}
#pragma mark- common method
/**
 可选 设置某个item的角标
 设置角标  0 消失  大于零展示 小于0 圆圈
 @param index item下标 0开始
 @param badge 角标数量
 */
- (void)setBadgeWithIndex:(NSInteger)index  badge:(NSInteger)badge{
     if (index >= self.tabButtonsArray.count) {
          return;
     }
     CYTabButton * currentBtn = self.tabButtonsArray[index];
     [currentBtn setBadge:badge];
}
/**
 @param index item下标 0开始
 */
- (void)setTabSwitchSelectIndex:(NSInteger)index{
     if (index >= self.tabButtonsArray.count) {
          return;
     }
     [self updateUI:index];
}
/**
 设置默认选择的索引
 */
- (void)setDefaultSelectIndex:(NSInteger)index{
     if (index >= self.tabButtonsArray.count) {
          return;
     }
     self.currentSelectIndex = index;
     [self layoutSubviews];
}

@end
