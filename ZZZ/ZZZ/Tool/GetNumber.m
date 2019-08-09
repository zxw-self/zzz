//
//  GetNumber.m
//  ZZZ
//
//  Created by zxw on 2018/3/6.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "GetNumber.h"

@interface GetNumber()
{
    
}
@property(nonatomic, strong) NSString * phone;
@property(nonatomic, strong) NSString * sms;

@property(nonatomic, strong) NSString * lfusername;
@property(nonatomic, strong) NSString * lfpassword;

@property(nonatomic, strong) NSString * heard;
@property(nonatomic, strong) NSString * fooder;

@property(nonatomic, strong) NSString * itemid;

@end


@implementation GetNumber

static NSString * Token = nil;


//@"【乐发游戏】您的验证码是"
//@"。如非本人操作，请忽略。"
+ (instancetype)initWithHeard:(NSString *)heard footer:(NSString *)footer itemid:(NSString *)itemid{
    
    GetNumber * ber = [[GetNumber alloc] init];
    ber.heard = heard;
    ber.fooder= footer;
    ber.itemid = itemid;
    
    return ber;
}

- (instancetype)init{
    if (self = [super init]) {
        
        self.lfusername = [[NSUserDefaults standardUserDefaults] objectForKey:@"lfusername"];
        self.lfpassword = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@lfpassword",self.lfusername]];
        if (Token == nil) {
            Token = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@token",self.lfusername]];
        }
        self.isTool = NO;
    }
    return self;
}

- (void)loginGetTokenCompletionHandler:(void (^)(id  data))completionHandler{
    
    NSString * str = [NSString stringWithFormat:@"http://api.fxhyd.cn/UserInterface.aspx?action=login&username=%@&password=%@",self.lfusername,self.lfpassword];
    
    [self getJson:str completionHandler:^(id data) {
        
        NSLog(@"%@",data);
        
        NSString * str = (NSString *)data;
        if (str.length > 6) {
            
            Token = [[str componentsSeparatedByString:@"|"] lastObject];
            completionHandler(Token);
            
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"获取Token失败，请联系管理员！！\n%@",str] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil]
                 show];
            });
            
        }
    }];
    
}
    


- (void)getmobileCompletionHandler:(void (^)(id  data))completionHandler{
    
    if (Token == nil || Token.length < 1) {
        [self loginGetTokenCompletionHandler:^(id data) {
            [self getmobileCompletionHandler:completionHandler];
        }];
        return;
    }

    [self getJson:[NSString stringWithFormat:@"http://api.fxhyd.cn/UserInterface.aspx?action=getmobile&token=%@&itemid=%@",Token,self.itemid] completionHandler:^(id data) {
        
        NSString * str = (NSString *)data;
        NSLog(@"%@",str);
        if ([str isEqualToString:@"1004"]) {
            Token = nil;
            [self getmobileCompletionHandler:completionHandler];
            return ;
            
        }
        
        if (str.length > 6) {
            NSString * phone = [[str componentsSeparatedByString:@"|"] lastObject];
            self.phone = phone;
            self.isTool = YES;
            completionHandler(phone);
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"获取手机号失败！！！\n%@",str] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil]
                 show];
            });
        }
    }];
    
}

- (void)getsmsCompletionHandler:(void (^)(id  data))completionHandler{
    
    if (Token == nil || Token.length < 1) {
        [self loginGetTokenCompletionHandler:^(id data) {
            [self getsmsCompletionHandler:completionHandler];
        }];
        
        return;
    }
    
    [self getJson:[NSString stringWithFormat:@"http://api.fxhyd.cn/UserInterface.aspx?action=getsms&token=%@&itemid=%@&mobile=%@&release=1",Token,self.itemid,self.phone] completionHandler:^(id data) {
        
        NSLog(@"%@-- %@",Token,self.phone);
        NSString * str = (NSString *)data;
        NSLog(@"%@",str);
        if ([str isEqualToString:@"1004"]) {
            Token = nil;
            [self getsmsCompletionHandler:completionHandler];
            return ;
            
        }
        
        if (str.length > 6) {
            NSString * sms = [[str componentsSeparatedByString:@"|"] lastObject];
            NSString * heard = self.heard;
            NSString * fooder = self.fooder;
            
            sms = [sms stringByReplacingOccurrencesOfString:heard withString:@""];
            sms = [sms stringByReplacingOccurrencesOfString:fooder withString:@""];
            if (sms != nil && sms.length <= 6) {
                self.sms = sms;
                
                completionHandler(sms);
                self.isTool = NO;
                return ;
            }else{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"格式有变请联系管理员！！\n%@",str] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil]
                     show];
                    
                });
                
            }
        }else{
            completionHandler([NSString stringWithFormat:@"错误:%@",str]);
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


@end
