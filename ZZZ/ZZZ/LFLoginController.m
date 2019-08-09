//
//  LFLoginController.m
//  ZZZ
//
//  Created by zxw on 2018/3/7.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "LFLoginController.h"
#import "LFTableViewController.h"
#import "ViewController.h"


@interface LFLoginController ()

@end

@implementation LFLoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登录";
    
    
    self.login.layer.cornerRadius = 6;
    self.login.clipsToBounds = YES;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lfusername"] != nil) {
        self.account.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"lfusername"];
    }
    
    if (self.account.text.length < 11) {
        [self.account becomeFirstResponder];
    }else{
        [self.sec becomeFirstResponder];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)login:(UIButton *)sender {
    
    if (self.account.text.length != 11 || self.sec.text.length < 6) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"请输入正确的帐号密码！！"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil]
         show];
        
        return;
    }
    
    
    NSString * str = [NSString stringWithFormat:@"http://api.fxhyd.cn/UserInterface.aspx?action=login&username=%@&password=%@",self.account.text,self.sec.text];
    
    [self getJson:str completionHandler:^(id data) {
        
        NSString * str = (NSString *)data;
        
        if (str.length < 6) {
        
            int code = [[[str componentsSeparatedByString:@"|"] firstObject] intValue];
            
            NSString * message = [NSString stringWithFormat:@"登录失败！！"];
            if (code >= 1008 && code <= 1012) {
                message = [NSString stringWithFormat:@"登录失败！！\n请联系管理员%@",str];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil]
                 show];
                
            });
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                NSString * token = [NSString stringWithFormat:@"%@token",self.account.text];
                NSString * password = [NSString stringWithFormat:@"%@lfpassword",self.account.text];
                
                [[NSUserDefaults standardUserDefaults] setObject:self.account.text  forKey:@"lfusername"];
                [[NSUserDefaults standardUserDefaults] setObject:self.sec.text forKey:password];
                [[NSUserDefaults standardUserDefaults] setObject:[[str componentsSeparatedByString:@"|"] lastObject] forKey:token];
                
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                 [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
                
            });
            
            
        }
        
        
        
    }];
    
    
    
   
    
}

- (void)getJson:(NSString *)host completionHandler:(void (^)(id  data))completionHandler{
    //post方法
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",host]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4.修改请求方法为POST
    request.HTTPMethod=@"GET";
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (data != nil) {
            //8.解析数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (dict == nil) {
                completionHandler([[NSString alloc] initWithData:data encoding:4]);
                return ;
            }
            
            completionHandler(dict);
        }else{
            NSLog(@"%@",error);
        }
        
    }];
    
    //7.执行任务
    [dataTask resume];
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
