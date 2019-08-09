#import "ViewController.h"

#import "XZViewController.h"
#import "LFViewController.h"
#import "LFTableViewController.h"
#import "LFLoginController.h"

#import "ETH_tvc.h"

@interface ViewController ()
{
    
}
@property(nonatomic, strong) UITextField * field;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 120, 40)];
    self.field = field;
    field.placeholder = @"ETH邀请人";
    [self.view addSubview:field];
    field.layer.borderWidth = 1;
    field.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    field.layer.cornerRadius = 5;
    field.layer.masksToBounds = YES;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(5,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    field.leftView = leftView;
    field.leftViewMode = UITextFieldViewModeAlways;
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    for (int a = 1; a < 3; a++) {
        
        UIButton * field = [[UIButton alloc] initWithFrame:CGRectMake(20, 50 * a + 20, CGRectGetWidth(self.view.frame) - 40, 40)];
        field.tag = 10 + a;
        field.backgroundColor = [UIColor grayColor];
        
        [self.view addSubview:field];
        
        
        switch (a) {
            case 1:
                
                [field setTitle:@"ETH" forState:UIControlStateNormal];
                [field addTarget:self action:@selector(xiaZhuang) forControlEvents:UIControlEventTouchUpInside];
                break;
            
            case 2:
                
                [field setTitle:@"乐发" forState:UIControlStateNormal];
                [field addTarget:self action:@selector(lefa) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                break;
        }
        
        
        
    }
    
}
- (void)xiaZhuang{
    ETH_tvc * vc = [[ETH_tvc alloc] init];
    
    if (self.field.text.length > 8) {
        self.field.text = @"zmz02";
    }
    vc.yaoqingren =self.field.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)lefa{
    [self.navigationController pushViewController:[LFTableViewController lftableViewController] animated:YES];
    
}


- (void)login{
    
    [self getJson:@"http://api.fxhyd.cn/UserInterface.aspx?action=login&username=13873162949&password=csl123456" completionHandler:^(id data) {
       
        NSLog(@"%@",data);
        
        NSString * str = (NSString *)data;
        if (str.length > 6) {
            
            NSString * token = [[str componentsSeparatedByString:@"|"] lastObject];
            [self getJson:[NSString stringWithFormat:@"http://api.fxhyd.cn/UserInterface.aspx?action=getmobile&token=%@&itemid=14482",token] completionHandler:^(id data) {
                
                NSLog(@"%@",data);
                if (str.length > 6) {
                    NSString * mobile = [[str componentsSeparatedByString:@"|"] lastObject];
                    
                    
                }else{
                    
                    
                    
                }
                
                
            }];
            
        }else{
            NSLog(@"登录失败");
        }
        
        
    }];
    
}

// 14482

- (void)postDic:(NSString *)host POST:(NSString *)post data:(NSDictionary *)dic  completionHandler:(void (^)(id  data))completionHandler{
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
        if (dict == nil) {
            completionHandler(data);
            return ;
        }
        completionHandler(dict);
        
        
        
    }];
    
    //7.执行任务
    [dataTask resume];
}

- (void)postJson:(NSString *)host POST:(NSString *)post dataString:(NSString *)string  completionHandler:(void (^)(id  data))completionHandler{
    //post方法
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",host,post]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4.修改请求方法为POST
    request.HTTPMethod=@"POST";
    
    NSData *sendData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //5.设置请求体
    request.HTTPBody = sendData;
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", [sendData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        
        
        if (data != nil) {
            //8.解析数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            completionHandler(dict);
        }else{
            NSLog(@"%@",error);
        }
        
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
