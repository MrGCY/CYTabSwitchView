//
//  ViewController.m
//  CYTabSwitchView
//
//  Created by Mr.GCY on 2019/5/14.
//  Copyright © 2019 Mr.GCY. All rights reserved.
//

#import "ViewController.h"
#import "CYTabSwitchView.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     CYTabSwitchView * tabSwitchView = [[CYTabSwitchView alloc] init];
     [self.view addSubview:tabSwitchView];
     [tabSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(50);
          make.left.mas_equalTo(20);
          make.right.mas_equalTo(-20);
          make.height.mas_equalTo(80);
     }];
     tabSwitchView.titleArray = @[@"乐库", @"推荐"];
     [tabSwitchView setBadgeWithIndex:1 badge:99];
     tabSwitchView.selectBlock = ^(NSInteger index) {
          NSLog(@"--------%zd",index);
     };
//     [tabSwitchView setTabSwitchSelectIndex:1];
}


@end
