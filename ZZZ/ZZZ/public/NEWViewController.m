//
//  NEWViewController.m
//  ZZZ
//
//  Created by zxw on 17/3/9.
//  Copyright © 2017年 tianshikechuang. All rights reserved.
//

#import "NEWViewController.h"

#import "ViewController.h"
#import "AppDelegate.h"
#import "NotificationCenterBlock.h"
#import "ZZSlider.h"

#import "NSObject+Property.h"


@interface NEWViewController ()<UIImagePickerControllerDelegate>
@property(nonatomic, strong) ZZSlider * slider;


@end

@implementation NEWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * button = [self.view viewWithTag:11];
    [button addTarget:self action:@selector(buttonFunction) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
    
    NotificationCenterBlock * notif = [NotificationCenterBlock shareNotificationCenterBlockWithKey:@"self"];

    [notif addBlocksObject:^(NSDictionary *info) {
        NSLog(@"%s 1- %@",__func__,info);
    }];


    [notif addBlocksObject:^(NSDictionary *info) {
        NSLog(@"%s 2- %@",__func__,info);
    }];


    [NotificationCenterBlock addBlocksObject:^(NSDictionary *info) {
        NSLog(@"%s -- %@",__func__,info);
    } WithKey:@"zzz"];

    
    
    self.slider.frame = CGRectMake(40, 300, 300, 300);
    self.slider.maximumValue = 35;
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quantity_bg"] highlightedImage:[UIImage imageNamed:@"quantity_bg"]];
    [self.slider setImageViewText:imageView];
    
    UILabel * la = [[UILabel alloc] initWithFrame:imageView.bounds];
    la.contentMode = UIViewContentModeCenter;
    [self.slider setLabelView:la];
    
    [self.slider setSliderChangeblock:^(float value) {
        
        la.text = [NSString stringWithFormat:@"%.0f",value];
        
    }];
    
//    [self GET];
    
    [self.view addSubview:self.slider];
    
//    NSLog(@"\n\nproperties_aps : %@\n\n",[self.slider properties_aps]);
//    
//    NSLog(@"\n\nivar_aps : %@\n\n",[self.slider ivar_aps]);
}




- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
//    NSLog(@"\n\nproperties_aps : %@\n\n",[self.slider properties_aps]);
//    
//    NSLog(@"\n\nivar_aps : %@\n\n",[self.slider ivar_aps]);
    
    
}


- (ZZSlider *)slider{
    if (!_slider) {
        _slider = [[ZZSlider alloc] init];
    }
    return _slider;
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    
    [self upImage:image];
    
    
}
- (void)buttonFunction{
    NSLog(@"%s",__func__);
    
    
//    [NotificationCenterBlock sendNotificationWithKey:@"self2" Info:@{@"JAJAAA":@"SSDDDDD"}];
//
//    [NotificationCenterBlock sendNotificationWithKey:@"zzz" Info:@{@"JAJAAA":@"SSDDDDD",@"JAJAAAss":@"SSDDDDDss"}];
//
//    NSMethodSignature * signature = [NSMethodSignature signatureWithObjCTypes:[@"v" UTF8String]];
//    signature = [[self class] instanceMethodSignatureForSelector:@selector(testArr:)];
//    NSLog(@"%d",[signature isOneway]);
//    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
//
//    invocation.selector = @selector(test:);
//    NSString *way = @"hahahha";
//    [invocation setArgument:&way atIndex:2];
//    [invocation invokeWithTarget:self];
    
    
//    FeedbackController *vc = [[FeedbackController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    
    
    
}





- (void)GET{
    
    /*
     使用NSURLSession 进行网络请求的几个步骤
     1.构造NSURL地址
     2.构造请求对象 NSURLRequest
     3.构造NSURLSessionConfiguration配置文件，可选
     4.构造NSURLSession网络会话对象
     5.创建网络任务
     6.执行网络任务，发送网络请求
     */
    
    NSString *str = @"食品";
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)str,NULL,NULL,kCFStringEncodingUTF8));
    
    //1
    NSString * strURL = [NSString stringWithFormat:@"http://www.yhhzypt.cn/mobile/index.php?act=goods&op=goods_list&keyword=%@&page=10&curpage=1",encodedString];
    
    NSLog(@"strURL - %@",strURL);
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    //2 使用URL 创建一个可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求对象
    //请求方式
    request.HTTPMethod = @"GET";
    
    //超时时间
    request.timeoutInterval = 60;
    
    //设置请求头中的参数
    // [request setValue:@"1533" forHTTPHeaderField:@"cinema_id"];
    
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //判断错误
        if (error) {
            NSLog(@"请求出错:%@", error);
            
            return;
        }
        
        NSError *jsonError = nil;
        
        //Json解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSString *jsonText = [NSString stringWithFormat:@"%@", dic];
        
        NSLog(@"Json解析:%@", dic);
        
    }];
    
    //5 开启任务
    [dataTask resume];
    
    
}


-(NSString *)utf8ToUnicode:(NSString *)string{
    
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='a' && _char <= 'z'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else{
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
    return s;
}




- (void)test:(NSString *)message{
    NSLog(@"%@",message);
    
    
     [NotificationCenterBlock sendNotificationWithKey:@"self" Info:@{@"JAJ":@"SSS"}];
    
}

- (NSArray *)testArr:(NSString *)message{
    
    NSLog(@"%@",message);
    return @[message];
}


- (void)upImage:(UIImage *)image{
   
    NSData * data = UIImagePNGRepresentation(image);
    
//    NSData * data2 = UIImageJPEGRepresentation([UIImage imageWithData:data], 0.6);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@_photo%@.png",@"Image",str];
    [self upload:@"file" url:@"http://proxy.whyingli.net/task/screen" filename:fileName mimeType:@"image/png" data:data parmas:nil];
}
/**
 *  upload 单标文件
 *
 *  @param name     @"image"
 *  @param filename filename
 *  @param mimeType @"image/png"
 *  @param data     图片的data
 *  @param params   其他的参数
 */
#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
- (void)upload:(NSString *)name url:(NSString *)urlStr filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params
{
    // 文件上传
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    /***************文件参数***************/
    // 参数开始的标志
    [body appendData:YYEncode(@"--YY\r\n")];
    // name : 指定参数名(必须跟服务器端保持一致)
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
    [body appendData:YYEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    [body appendData:YYEncode(type)];
    
    [body appendData:YYEncode(@"\r\n")];
    [body appendData:data];
    [body appendData:YYEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [body appendData:YYEncode(@"--YY\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [body appendData:YYEncode(disposition)];
        
        [body appendData:YYEncode(@"\r\n")];
        [body appendData:YYEncode(obj)];
        [body appendData:YYEncode(@"\r\n")];
    }];
    
    /***************参数结束***************/
    // YY--\r\n
    [body appendData:YYEncode(@"--YY--\r\n")];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"%@", dict);
            
//            if (dict && [[dict objectForKey:@"status"] intValue] == 1) {
//                NSLog(@"提交成功");
//                [self.navigationController popViewControllerAnimated:YES];
//
//            }else{
//                NSLog(@"提交失败");
//            }
            
        } else {
//            NSLog(@"提交失败");
        }
    }];
}


@end
