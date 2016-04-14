//
//  firstViewController.m
//  dingding
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 wyq. All rights reserved.
//

#import "firstViewController.h"
#import "MyScrollView.h"
#import "dingdingHelper.h"
@interface firstViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(strong,nonatomic)UITableView * mTableView;
@property(strong,nonatomic)MyScrollView * mScrollView;



@end
@implementation firstViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[dingdingHelper shareHelper].titleList addObject:self.title];
    [self.view addSubview:self.mTableView];


   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(UITableView *)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
    }
    return _mTableView;
}
-(UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _mScrollView.backgroundColor = [UIColor whiteColor];
        _mScrollView.delegate = self;
        
        _mScrollView.showsHorizontalScrollIndicator = NO;
        _mScrollView.showsVerticalScrollIndicator = NO;
        __weak typeof(self) weakSelf = self;
        [_mScrollView setBtnClick:^(NSString * title, NSInteger tag) {

            NSLog(@"title = %@,tag= %ld",title,(long)tag);
            if (tag==0) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                [[dingdingHelper shareHelper].titleList removeAllObjects];
            }
            else{

                [[dingdingHelper shareHelper].titleList removeObjectsInRange:NSMakeRange(tag+1, [dingdingHelper shareHelper].titleList.count-tag-1)];
                [weakSelf.navigationController.viewControllers
                 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,
                                              BOOL *stop) {
                     if ([obj isKindOfClass:firstViewController.class]) {

                         for (int i=0; i<[dingdingHelper shareHelper].titleList.count; i++) {
                             NSLog(@"--%@,%d",[[dingdingHelper shareHelper].titleList objectAtIndex:i],i);
                             if ([title isEqualToString:[[dingdingHelper shareHelper].titleList objectAtIndex:i]]) {
                                 idx = i;

                                 [weakSelf.navigationController
                                  popToViewController:weakSelf.navigationController
                                  .viewControllers[idx]
                                  animated:YES];

                                 return ;

                             }
                         }
                     }
                 }];
                weakSelf.mScrollView.titleArr = [dingdingHelper shareHelper].titleList;
                
            }
        }];

    }
    return _mScrollView;
}

#pragma mark delegate dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }

    if (indexPath.section==0) {
        [cell.contentView addSubview:self.mScrollView];
        self.mScrollView.titleArr = [dingdingHelper shareHelper].titleList;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"tabber_icon_inquiry_pre"];
        cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {

        firstViewController * first = [[firstViewController alloc]init];
        first.title = [NSString stringWithFormat:@"计划性%ld",(long)indexPath.row];
        
        first.dataArray = @[@"f",@"g",@"h",@"i",@"j"];
        [self.navigationController pushViewController:first animated:YES];


    }

}

-(void)dealloc {
    NSLog(@"dealloc");
}


@end
