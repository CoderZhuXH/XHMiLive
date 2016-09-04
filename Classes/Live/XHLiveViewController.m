//
//  XHLiveViewController.m
//  XHMiLive
//
//  Created by xiaohui on 16/9/4.
//  Copyright © 2016年 returnoc.com. All rights reserved.
//

#import "XHLiveViewController.h"
#import "XHNetwork.h"
#import "XHLiveCell.h"
#import <MJExtension.h>
#import "XHLiveModel.h"
#import "XHPlayerViewController.h"
#import <MJRefresh.h>


static NSString *const cellId = @"cellLive";

NSInteger pageCount = 2;

@interface XHLiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation XHLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
-(NSMutableArray *)dataArray
{
    if(_dataArray==nil)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }

    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
-(void)initUI{

    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"首页";
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"XHLiveCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    self.myTableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) wself = self;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
         [self requestDataWithPage:1 loadMore:NO];
    }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        [wself requestDataWithPage:pageCount loadMore:YES];
    }];
    
    [self.myTableView.mj_header beginRefreshing];

}
-(void)requestDataWithPage:(NSInteger)page loadMore:(BOOL)loadMore{

    NSString *urlStr = [NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld",page];
    
    [XHNetwork GET:urlStr parameters:nil success:^(id response) {
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSLog(@"res=%@",response);
        NSDictionary *dic = response;
        if([dic[@"code"] integerValue]==100)
        {
            NSArray *arr = dic[@"data"][@"list"];
            NSArray *modelArray =  [XHLiveModel mj_objectArrayWithKeyValuesArray:arr];
            //刷新
            if(!loadMore)
            {   pageCount = 2;
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:modelArray];
            }
            else
            {
                 pageCount++;
                [self.dataArray addObjectsFromArray:modelArray];
            }
            [self.myTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60+ScaleH(320);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHLiveCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
    {
        cell = [[XHLiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHLiveModel *model = self.dataArray[indexPath.row];
    XHPlayerViewController *VC = [[XHPlayerViewController alloc] init];
    VC.model = model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
