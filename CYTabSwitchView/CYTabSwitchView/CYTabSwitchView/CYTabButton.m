//
//  CYTabButton.m
//  CYTabSwitchView
//
//  Created by Mr.GCY on 2019/5/14.
//  Copyright © 2019 Mr.GCY. All rights reserved.
//

#import "CYTabButton.h"
#import "Masonry.h"
@interface CYTabButton ()
@property (nonatomic, strong) UIImageView * tabTitleImageView;
@property (nonatomic, strong) UIImage * normalTabTextImage;
@property (nonatomic, strong) UIImage * selectTabTextImage;
@property (nonatomic, strong) UILabel * tipLabel;
@property (nonatomic, assign) NSInteger  tipNum;
@end

@implementation CYTabButton
-(instancetype)initWithFrame:(CGRect)frame{
     if (self = [super initWithFrame:frame]) {
          [self setupData];
          [self addTabTitleImageView];
     }
     return self;
}
-(void)setupData{
     self.tipTextFont = [UIFont systemFontOfSize:10];
     self.tipBackgroundColor = [UIColor redColor];
}
#pragma mark- setter
-(void)setNormalFontSize:(UIFont *)normalFontSize{
     _normalFontSize = normalFontSize;
     [self.tabTitleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.height.mas_equalTo(normalFontSize.pointSize + 5);
     }];
}
-(void)setTitle:(NSString *)title{
     _title = title;
     self.normalTabTextImage = [self txtSwapImageWithText:title textColor:self.normalTextColor];
     self.selectTabTextImage = [self txtSwapImageWithText:title textColor:self.selectTextColor];
     self.tabTitleImageView.image = self.normalTabTextImage;
}
-(void)setSelected:(BOOL)selected{
     if (selected) {
          [self updateTabImage:self.selectTabTextImage height:self.selectFontSize.pointSize bottom:-10];
     }else{
          [self updateTabImage:self.normalTabTextImage height:self.normalFontSize.pointSize bottom:-12];
     }
     if (selected != self.selected) {
          [UIView animateWithDuration:self.animationInterval animations:^{
               [self layoutIfNeeded];
          }completion:^(BOOL finished) {
          }];
     }
     [super setSelected:selected];
}
-(void)setTipTextFont:(UIFont *)tipTextFont{
     _tipTextFont = tipTextFont;
     self.tipLabel.font = tipTextFont;
}
-(void)setTipBackgroundColor:(UIColor *)tipBackgroundColor{
     _tipBackgroundColor = tipBackgroundColor;
     self.tipLabel.backgroundColor = tipBackgroundColor;
}
/**
 @param badge 角标数量
 */
- (void)setBadge:(NSInteger)badge{
     self.tipNum = badge;
     if (badge > 0) {
          self.tipLabel.hidden = NO;
          self.tipLabel.text = [NSString stringWithFormat:@"%zd  ",badge];
     }else{
          self.tipLabel.hidden = YES;
          self.tipLabel.text = @"";
     }
}
/**
 @param 获取角标数量
 */
- (NSInteger)getBadge{
     return self.tipNum;
}
#pragma mark- private methods
-(void)updateTabImage:(UIImage *)tabImage height:(CGFloat)height bottom:(CGFloat)bottom{
     self.tabTitleImageView.image = tabImage;
     [self.tabTitleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.height.mas_equalTo(height + 5);
          make.bottom.mas_equalTo(bottom);
     }];
}
-(void)addTabTitleImageView{
     self.tabTitleImageView = [[UIImageView alloc] init];
     self.tabTitleImageView.contentMode = UIViewContentModeScaleAspectFit;
     [self addSubview:self.tabTitleImageView];
     [self.tabTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.right.equalTo(self);
          make.bottom.mas_equalTo(-12);
          make.height.mas_equalTo(self.normalFontSize.pointSize + 5);
     }];
     self.tipLabel = [[UILabel alloc] init];
     self.tipLabel.textColor = [UIColor whiteColor];
     self.tipLabel.backgroundColor = self.tipBackgroundColor;
     self.tipLabel.font = self.tipTextFont;
     self.tipLabel.textAlignment = NSTextAlignmentCenter;
     [self addSubview:self.tipLabel];
     [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.tabTitleImageView.mas_right).offset(-5);
          make.top.equalTo(self.tabTitleImageView.mas_top);
          make.height.mas_equalTo(14);
          make.width.mas_lessThanOrEqualTo(25);
          make.width.mas_greaterThanOrEqualTo(14);
     }];
     self.tipLabel.layer.cornerRadius = 7;
     self.tipLabel.layer.masksToBounds = YES;
     [self setBadge:0];
}

-(UIImage *)txtSwapImageWithText:(NSString *)text textColor:(UIColor *)textColor{
     UIFont * textFont = self.selectFontSize;
     CGSize textSize = [self textSizeWithText:text font:textFont];
     NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
     style.alignment = NSTextAlignmentCenter;
     style.lineBreakMode = NSLineBreakByCharWrapping;
     style.lineSpacing = 0;
     style.paragraphSpacing = 2;
     NSDictionary * attributes = @{NSFontAttributeName : textFont,
                                   NSForegroundColorAttributeName : textColor,
                                   NSBackgroundColorAttributeName : [UIColor clearColor],
                                   NSParagraphStyleAttributeName : style
                                   };
     UIGraphicsBeginImageContextWithOptions(textSize, NO, 0);
     [text drawInRect:(CGRect){CGPointZero,textSize} withAttributes:attributes];
     UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return image;
}
-(CGSize)textSizeWithText:(NSString *)text font:(UIFont *)font{
     CGRect rect = [text boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
     return rect.size;
}
@end
