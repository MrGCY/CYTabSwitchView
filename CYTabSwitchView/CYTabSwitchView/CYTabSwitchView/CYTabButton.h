//
//  CYTabButton.h
//  CYTabSwitchView
//
//  Created by Mr.GCY on 2019/5/14.
//  Copyright © 2019 Mr.GCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYTabButton : UIControl
@property (nonatomic, copy) NSString * title;
//选中的文字大小
@property (nonatomic, strong) UIFont * selectFontSize;
//正常状态的文字大小
@property (nonatomic, assign) UIFont * normalFontSize;
@property (nonatomic, assign) CGFloat  animationInterval;
@property (nonatomic, strong) UIColor * normalTextColor;
@property (nonatomic, strong) UIColor * selectTextColor;
//提示文字颜色
@property (nonatomic, strong) UIColor * tipBackgroundColor;
@property (nonatomic, strong) UIFont * tipTextFont;
/**
 @param badge 角标数量
 */
- (void)setBadge:(NSInteger)badge;
/**
 @param 获取角标数量
 */
- (NSInteger)getBadge;
//获取按钮文字大小
-(CGSize)textSizeWithText:(NSString *)text font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
