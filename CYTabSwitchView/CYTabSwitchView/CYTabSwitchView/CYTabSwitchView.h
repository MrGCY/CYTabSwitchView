//
//  CYTabSwitchView.h
//  CYTabSwitchView
//
//  Created by Mr.GCY on 2019/5/14.
//  Copyright © 2019 Mr.GCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TabSelectBlock)(NSInteger);
@interface CYTabSwitchView : UIView
@property (nonatomic, copy) TabSelectBlock selectBlock;
//传入标题文字数组
@property (nonatomic, copy) NSArray * titleArray;
//当前选择的index
@property (nonatomic, assign,readonly) NSInteger currentSelectIndex;
//选中的文字大小
@property (nonatomic, strong) UIFont * selectFontSize;
//正常状态的文字大小
@property (nonatomic, assign) UIFont * normalFontSize;
//动画时间
@property (nonatomic, assign) CGFloat  animationInterval;
//正常的文字颜色
@property (nonatomic, strong) UIColor * normalTextColor;
//选中的文字颜色
@property (nonatomic, strong) UIColor * selectTextColor;
//提示文字颜色
@property (nonatomic, strong) UIColor * tipBackgroundColor;
@property (nonatomic, strong) UIFont * tipTextFont;
/**
 可选 设置某个item的角标
 设置角标  0 消失  大于零展示 小于0 圆圈
 @param index item下标 0开始
 @param badge 角标数量
 */
- (void)setBadgeWithIndex:(NSInteger)index  badge:(NSInteger)badge;
- (NSInteger)getBadgeWithIndex:(NSInteger)index;
/**
 设置默认选择的索引
 */
- (void)setDefaultSelectIndex:(NSInteger)index;
/**
 @param index item下标 0开始 必须添加布局完成后才能使用
 */
- (void)setTabSwitchSelectIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
