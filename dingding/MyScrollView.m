//
//  MyScrollView.m
//  dingding
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 wyq. All rights reserved.
//

#import "MyScrollView.h"
#import "UIView+Utils.h"

@implementation MyScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }

    return self;
}
-(void)setTitleArr:(NSMutableArray *)titleArr
{
    NSLog(@"%lu",(unsigned long)titleArr.count);
    [self creatBtn:titleArr];
}

-(void)creatBtn:(NSMutableArray *)arr
{
    UIButton * btn;
    for (int i=0; i<arr.count; i++) {

        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+(100*i), 15, 60, 30);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        NSString * title = [arr objectAtIndex:i];
        btn.tag = i;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:btn];
        _btn = btn;
        _imv = [[UIImageView alloc]initWithFrame:CGRectMake(btn.right+10 , 20, 20, 20)];
        _imv.image = [UIImage imageNamed:@"btn_info_right"];
        [self addSubview:_imv];


        if (i==arr.count-1) {
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.enabled = NO;
            _imv.hidden = YES;
        }
        else{
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.enabled = YES;

        }

    }
    NSLog(@"frame = %@",NSStringFromCGRect(btn.frame));
    self.contentSize = CGSizeMake(btn.frame.origin.x+60, 60);
    [self scrollRectToVisible:btn.frame animated:YES];

}

-(void)btn:(UIButton *)sender{

    NSString * title = sender.titleLabel.text;
    NSInteger tag = sender.tag;
    if (self.btnClick) {
        self.btnClick(title,tag);
    }

}


@end
