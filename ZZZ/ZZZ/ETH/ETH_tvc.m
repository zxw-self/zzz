//
//  ETH_tvc.m
//  ZZZ
//
//  Created by zxw on 2018/3/8.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "ETH_tvc.h"

#import "httpTool.h"
#import "UIImageView+WebCache.h"
#import "ETHcell.h"

@interface ETH_tvc () <UIWebViewDelegate>
@property(nonatomic, strong) NSMutableArray * cells;


@end

@implementation ETH_tvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"aa";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.cells = [NSMutableArray array];
    for (int a = 0; a< 10; a++) {
        ETHcell * cell = [[ETHcell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 70)];
        cell.yaoqingren = self.yaoqingren.length<5?@"zmz02":self.yaoqingren;
        [self.cells addObject:cell];
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cells.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = self.cells[indexPath.row];
    
    return cell;
}


@end
