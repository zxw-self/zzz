//
//  LFTableViewController.m
//  ZZZ
//
//  Created by zxw on 2018/3/5.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "LFTableViewController.h"
#import "LFTableViewCell.h"

@interface LFTableViewController ()
{
    
}
@property(nonatomic, strong) NSMutableArray * cells;

@end

@implementation LFTableViewController

static LFTableViewController * lftableViewController = nil;
+ (instancetype)lftableViewController{
    
    if (lftableViewController == nil) {
        lftableViewController = [[LFTableViewController alloc] init];
    }
    return lftableViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = [NSMutableArray array];
    for (int a = 0; a< 20; a++) {
        LFTableViewCell * cell = [[LFTableViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
        [self.cells addObject:cell];
        
    }
    

    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [btn setTitle:@"清除返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * bar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
}
- (void)clear{
    
    lftableViewController = nil;
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = self.cells[indexPath.row];
    
    return cell;
}





@end
