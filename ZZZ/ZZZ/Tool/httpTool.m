//
//  httpTool.m
//  ZZZ
//
//  Created by zxw on 2018/3/8.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "httpTool.h"

@implementation httpTool




- (void)post_Dic:(NSString *)host POST:(NSString *)post dicData:(NSDictionary *)dic  completionHandler:(void (^)(id  data))completionHandler{
    //post方法
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",host,post]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod=@"POST";
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strData = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSString *postData = [[NSString alloc] initWithFormat:@"%@",strData];
    NSData *sendData = [postData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]; //这个sendData才可以发送给服务端
    NSString *postLength = [NSString stringWithFormat:@"%ld", [sendData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    //5.设置请求体
    request.HTTPBody= sendData;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        //8.解析数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        completionHandler(dict);
        
    }];
    
    //7.执行任务
    [dataTask resume];
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



#pragma mark - 以太坊8
- (void)GetImageAndCookies:(NSString *)host completionHandler:(void (^)(UIImage * image,id  cookies))completionHandler{
    
    
    //post方法
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",host]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://www.ytf188.com/member/register.php?" forHTTPHeaderField: @"Referer"];
    NSMutableString *cookieString = [[NSMutableString alloc] init];
    [request setValue:cookieString forHTTPHeaderField:@"Cookie"];
    
    //4.修改请求方法为POST
    request.HTTPMethod=@"GET";
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (data != nil) {
            //转换NSURLResponse成为HTTPResponse
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            NSDictionary *fields = [httpResponse allHeaderFields];
            
            NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:url];
            NSDictionary * cookieDic;
            for (NSHTTPCookie * cookie in cookies) {
                cookieDic = [cookie properties];
            }
            completionHandler([UIImage imageWithData:data],cookieDic);
        }
        
    }];
    
    //7.执行任务
    [dataTask resume];
}


- (void)sendMsm:(NSString *)str completionHandler:(void (^)(id  data))completionHandler{
    //post方法
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ytf188.com/member/bin.php?act=regcheck&username=%@&a=t",str]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://www.ytf188.com/member/register.php?" forHTTPHeaderField: @"Referer"];
    
    //4.修改请求方法为POST
    request.HTTPMethod=@"GET";
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){

        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

        if ([dict[@"state"] integerValue]== 1) {
            completionHandler(dict[@"msg"]);
        }else{
            completionHandler(@"发送短信失败");
        }
        
    }];
    
    //7.执行任务
    [dataTask resume];
    
}


- (void)sendReg:(NSString *)str comMember:(NSString *)comMember msg:(NSString *)sms code:(NSString *)code PHPSESSID:(NSString *)PHPSESSID completionHandler:(void (^)(id  data))completionHandler{
    
    //post方法 4tf1j
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ytf188.com/member/bin.php?act=reg&comMember=%@&username=%@&msgcode=%@&pwd=1123456&pwd2=1123456&vCode=%@",comMember,str,sms,code]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://www.ytf188.com/member/register.php?" forHTTPHeaderField: @"Referer"];
    
    NSMutableString *cookieString = [[NSMutableString alloc] init];
    
    [cookieString appendFormat:@"%@=%@",@"PHPSESSID",PHPSESSID];
    
    [request setValue:cookieString forHTTPHeaderField:@"Cookie"];
    
    //4.修改请求方法为POST
    request.HTTPMethod=@"GET";
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (data != nil) {
            
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"dict ---- %@",dict);
            
//            if ([dict[@"state"] integerValue]== 1) {
                completionHandler(dict);
//            }else{
//                completionHandler(dict);
//            }
        }
        
    }];
    
    //7.执行任务
    [dataTask resume];
    
}




@end
