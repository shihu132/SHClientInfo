//
//  ViewController.m
//  SHClientInfo
//
//  Created by joyshow on 2018/11/20.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "SHViewController.h"
#import "SHInfoModel.h"
#import "SHClientModel.h"
#import "SHClientCell.h"

static NSString *idetifier = @"SHViewControllerIndentifier";
@interface SHViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) SHClientModel *clientModel;

@end

@implementation SHViewController

#pragma mark----------------------------------life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"客户端信息";
    [self addClientModelinfo];
    [self addNavView];
    [self addTableView];
}

- (void)addClientModelinfo{
    _clientModel = [[SHClientModel alloc]init];
    [_clientModel sh_setupHardwareInfo];
    [_clientModel sh_setupBatteryInfo];
    [_clientModel sh_setupAddressInfo];
    [_clientModel sh_setupCPUInfo];
    [_clientModel sh_setupDiskInfo];
}

- (void)addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark----------------------------------private method
- (void)addNavView{
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{
                                                                             NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:28],
                                                                             NSForegroundColorAttributeName:[UIColor redColor]};
    }
}

#pragma mark----------------------------------UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     return @"信息如下 ⤵️";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _clientModel.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    /***
     方式一: 
    SHClientCell *cell = [self.tableView dequeueReusableCellWithIdentifier:idetifier];

    if (cell == nil) {
         cell = [[SHClientCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetifier];
    }
    */
    SHClientCell *cell = [SHClientCell cellWithTableView:tableView];
    if (indexPath.row < _clientModel.infoArray.count) {// 获取数据字典
        cell.infoModel = _clientModel.infoArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
