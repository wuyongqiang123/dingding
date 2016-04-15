//
//  ViewController.m
//  dingding
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 wyq. All rights reserved.
//

#import "ViewController.h"
#import "firstViewController.h"
#import "dingdingHelper.h"
#import "AFNetworking.h"
#import "dataModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * mTableView;
@property(strong,nonatomic)NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"联系人";

    [self.view addSubview:self.mTableView];
    [self requestinfo];
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
-(void)requestinfo {

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager POST:@"http://mail.wisdudu.com:9000/schedule/PersonneAll.ashx" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray * return_result = [responseObject objectForKey:@"return_result"];
        for (int i=0; i<return_result.count; i++) {
            NSDictionary * dic = [return_result objectAtIndex:i];
            dataModelID * modelid = [[dataModelID alloc]init];
            modelid.BM_ID = [dic objectForKey:@"BM_ID"];
            modelid.BM_MC = [dic objectForKey:@"BM_MC"];
            NSArray * MJDate = [dic objectForKey:@"MJDate"];

            for (int j=0; j<MJDate.count; j++) {
                NSDictionary * dicc = [MJDate objectAtIndex:j];
                dataModel * model = [[dataModel alloc]init];
                model.EasemoName = [dicc objectForKey:@"EasemoName"];
                model.EasemobPwd = [dicc objectForKey:@"EasemobPwd"];
                model.bm_mc = [dicc objectForKey:@"bm_mc"];
                model.ssoid = [dicc objectForKey:@"ssoid"];
                model.ui_desc = [dicc objectForKey:@"ui_desc"];
                model.ui_id = [dicc objectForKey:@"ui_id"];
                model.ui_yddh = [dicc objectForKey:@"ui_yddh"];
                model.zpurl = [dicc objectForKey:@"zpurl"];
                model.zwmc = [dicc objectForKey:@"zwmc"];
                [self.dataArr addObject:model];
            }


        }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        

    }];
}

-(UITableView *)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
    }
    return _mTableView;
}

#pragma mark delegate dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if (indexPath.row==0) {
        cell.textLabel.text = @"组织架构";
    }
    else{
        cell.textLabel.text = @"我的部门";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {

        firstViewController * first = [[firstViewController alloc]init];
        first.title = @"公司名字";
        first.dataArray = @[@"a",@"b",@"c",@"d",@"e"];
        [[dingdingHelper shareHelper].titleList addObject:@"联系人"];
        [self.navigationController pushViewController:first animated:YES];

        

    }
    else{

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
