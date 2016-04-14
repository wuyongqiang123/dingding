//
//  MyScrollView.h
//  dingding
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 wyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollView : UIScrollView
@property(strong,nonatomic)NSMutableArray * titleArr;
@property(strong,nonatomic)UIButton * btn;
@property(strong,nonatomic)UIImageView * imv;
@property(copy,nonatomic) void(^btnClick)(NSString * title,NSInteger tag);
@end
