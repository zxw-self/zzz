//
//  XZViewController.m
//  ZZZ
//
//  Created by zxw on 2018/3/1.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "XZViewController.h"

@interface XZViewController ()

{
    
}
@property(nonatomic, strong) NSString * uid;

@property(nonatomic, assign) int timer;

@property(nonatomic, assign) int scuCont;
@property(nonatomic, assign) float total;

@property(nonatomic, strong) UITextField * device;
@property(nonatomic, strong) UITextField * invite;
@property(nonatomic, strong) UITextField * username;
@property(nonatomic, strong) UITextField * key;
@property(nonatomic, strong) UITextField * qq;

@property(nonatomic, strong) UITextView * scuContL;

@property(nonatomic, strong) UIButton * start;
@property(nonatomic, strong) UIButton * end;

@property(nonatomic, strong) NSMutableArray * arr;
@property(nonatomic, strong) NSTimer *timerT;

@property(nonatomic, strong) NSString * deviceStr;
@property(nonatomic, strong) NSString * inviteStr;
@property(nonatomic, strong) NSString * usernameStr;
@property(nonatomic, strong) NSString * keyStr;
@property(nonatomic, strong) NSString * qqStr;


@property(nonatomic, strong) NSMutableArray * mKey;
@property(nonatomic, strong) NSString * currentKey;


@end

@implementation XZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"瞎转";
    self.view.backgroundColor = [UIColor whiteColor];
    self.arr = [NSMutableArray array];
    
    self.mKey = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"XZKEY"]];
    if (self.mKey == nil) {
        self.mKey = [NSMutableArray array];
    }
    
    for (int a = 0; a < 7; a++) {
        
        
        if (a < 5) {
            UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(20, 50 * a + 10, CGRectGetWidth(self.view.frame) - 40, 40)];
            field.tag = 100 + a;
            field.layer.borderWidth = 1;
            field.layer.backgroundColor = [UIColor grayColor].CGColor;
            field.backgroundColor = [UIColor whiteColor];
            field.textColor = [UIColor grayColor];
            [self.view addSubview:field];
            
            
        }else if (a == 5 ){
            
            CGFloat width = (CGRectGetWidth(self.view.frame) - 40)/3.0 - 20;
            
            UIButton * field = [[UIButton alloc] initWithFrame:CGRectMake(20, 50 * a + 10, width, 40)];
            field.tag = 10 + a;
            field.backgroundColor = [UIColor grayColor];
            [field setTitle:@"开始" forState:UIControlStateNormal];
            [field addTarget:self action:@selector(startA) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:field];
            
            field = [[UIButton alloc] initWithFrame:CGRectMake(130 , 50 * a + 10, width, 40)];
            field.tag = 20 + a;
            [field setTitle:@"结束" forState:UIControlStateNormal];
            [field addTarget:self action:@selector(endA) forControlEvents:UIControlEventTouchUpInside];
            field.backgroundColor = [UIColor grayColor];
           
            [self.view addSubview:field];
            
            field = [[UIButton alloc] initWithFrame:CGRectMake(230 , 50 * a + 10, width, 40)];
            field.tag = 30 + a;
            [field setTitle:@"0次" forState:UIControlStateNormal];
            [field setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            field.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:field];
            
            
        }else {
            UITextView * field = [[UITextView alloc] initWithFrame:CGRectMake(20, 50 * a + 10, CGRectGetWidth(self.view.frame) - 40, CGRectGetHeight(self.view.frame) - 64 - 50 * a - 20)];
            field.tag = a;
            [self.view addSubview:field];
            field.backgroundColor = [UIColor whiteColor];
            field.textColor = [UIColor grayColor];
            field.layer.borderWidth = 1;
            field.font = [UIFont systemFontOfSize:12];
            field.text = @"\t======成功日志显示处======";
            
            self.scuContL = field;
        }
        
    }
    
    self.device = [self.view viewWithTag:100];
    self.device.placeholder = @"设备号起始号15位数字(861322034657624)";
    self.invite = [self.view viewWithTag:101];
    self.invite.placeholder = @"邀请人号码(377596)";
    self.username = [self.view viewWithTag:102];
    self.username.placeholder = @"用户名后缀(Do_Myself)";
    self.key = [self.view viewWithTag:103];
    self.key.placeholder = @"微信openid28位(oweNHwqdqTVsIplHLCE3RDR2ByEU)";
    self.qq = [self.view viewWithTag:104];
    self.qq.placeholder = @"时间间隔秒(5)";
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)endA{
    [self.view endEditing:YES];
    [self.timerT invalidate];
    self.timer = 0;
    
    self.qq.text = @"";
}

- (void)startA{
     [self.view endEditing:YES];
    
    self.timer = 0;
    self.scuContL.text = @"\t======成功日志显示处======";
    self.scuCont = 0;
    self.total = 0;
    [self.arr removeAllObjects];
    
    if (self.timerT != nil) {
        [self.timerT invalidate];
        if (self.qq.text.length > 0 && [self.qq.text intValue] > 36000) {
            self.qq.text = @"";
        }
    }
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.qq.text.length > 0?[self.qq.text floatValue]:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self action];
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timerT = timer;
    
   
    
}

- (void)action{
    self.timer ++;
    
    UIButton * but = [self.view viewWithTag:35];
    [but setTitle:[NSString stringWithFormat:@"%d次",self.timer] forState:UIControlStateNormal];
    
    if (self.timer == 1) {
        self.deviceStr = self.device.text;
        self.inviteStr = self.invite.text;
        self.usernameStr = self.username.text;
        self.keyStr = self.key.text;
        self.qqStr = self.qq.text;
    }
    
    if (self.currentKey == nil) {
        self.currentKey = @"oweNHwqdqTVsIplHLCE3RDR2ByEU";
    }
    
    NSString * device = [NSString stringWithFormat:@"8613220346%d",17124 + self.timer];
    if (self.deviceStr.length > 0) {
        device = [NSString stringWithFormat:@"%@%ld",[self.deviceStr substringToIndex:9],[[self.deviceStr substringFromIndex:9] integerValue] + self.timer];
    }
    
    NSString * invite = @"377596";
    if (self.inviteStr.length > 0) {
        invite = self.inviteStr;
    }
    
    NSString * username = [NSString stringWithFormat:@"%@Do_Myself",[XZViewController generateTradeNO]];
    if (self.usernameStr.length > 0) {
        username = [NSString stringWithFormat:@"%@%@",[XZViewController generateTradeNO],self.usernameStr];
    }
    
    int loc = (self.timer%(28*38))/38;
    
    int ins = loc%28;
    int len = loc/28;
    
    if (len > 0) {
        self.currentKey = self.mKey[len];
    }
    
    NSString * str = self.currentKey;
    if (self.keyStr.length > 0) {
        str = self.keyStr;
    }
    
    NSString * key = [str stringByReplacingCharactersInRange:NSMakeRange(str.length - 1 -ins, 1) withString:[self getZM:self.timer%38]];

//    key = [NSString stringWithFormat:@"oweNHw%@",[[self class] generateRand:22]];
    
    NSString * qq= [NSString stringWithFormat:@"%d%d%d%d%d",rand()%24 + 1,rand()%90 + 10,self.timer%10,rand()%90 + 10,rand()%1000];

    
    
    self.device.text = device;
    self.invite.text = invite;
    self.username.text = username;
    self.key.text = key;
    self.qq.text = qq;
    
    [self begin:device invite:invite username:username key:key qq:qq];
    
}





- (void) begin:(NSString *)device invite:(NSString *)invite username:(NSString *)username key:(NSString *)key qq:(NSString *)qq{
    
    [self version:device];
    [self zhuanfa_cate:device];
    [self kuaibao:device];
    [self hongdian:device];
    [self qqqun:device];
    [self share_weixin_key:device];
    [self device_in_hongbao:device];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self parent_invite_hongbao:device invite:invite];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self login:device invite:invite username:username key:key qq:qq];
    });
}


#pragma mark - 接口区域

- (void)version:(NSString *)device{
    
    NSString * from = [NSString stringWithFormat:@"act=version&network=WIFI&device=%@&signature=82024da003020102020420cabb1d300d&version=2",device];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}

- (void)zhuanfa_cate:(NSString *)device{
    
    NSString * from = [NSString stringWithFormat:@"act=zhuanfa_cate&network=WIFI&device=%@&signature=82024da003020102020420cabb1d300d&version=2",device];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}

- (void)kuaibao:(NSString *)device{
    
    NSString * from = [NSString stringWithFormat:@"act=kuaibao&network=WIFI&device=%@&op=index&signature=82024da003020102020420cabb1d300d&version=2",device];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}


- (void)hongdian:(NSString *)device{
    
    NSString * from = [NSString stringWithFormat:@"act=hongdian&network=WIFI&device=%@&signature=82024da003020102020420cabb1d300d&version=2",device];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}
- (void)qqqun:(NSString *)device{
    
    NSString * from = [NSString stringWithFormat:@"act=qqqun&network=WIFI&device=%@&signature=82024da003020102020420cabb1d300d&version=2",device];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}


- (void)share_weixin_key:(NSString *)device{
    
    NSString * from = [NSString stringWithFormat:@"act=share_weixin_key&network=WIFI&device=%@&signature=82024da003020102020420cabb1d300d&version=2",device];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}

- (void)device_in_hongbao:(NSString *)device{
    
    NSString * from = [NSString stringWithFormat:@"act=device_in_hongbao&network=WIFI&device=%@&signature=82024da003020102020420cabb1d300d&version=2",device];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}


- (void)parent_invite_hongbao:(NSString *)device invite:(NSString *)invite{
    
    NSString * from = [NSString stringWithFormat:@"act=parent_invite_hongbao&network=WIFI&device=%@&invite=%@&signature=82024da003020102020420cabb1d300d&version=2",device,invite];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
    }];
    
}




- (void)login:(NSString *)device invite:(NSString *)invite username:(NSString *)username key:(NSString *)key qq:(NSString *)qq{
    
    NSString * from2 = [NSString stringWithFormat:@"act=login&device=%@&isemualtor=1&signature=82024da003020102020420cabb1d300d&ohterinfo=0||0||0||null||null||0||||0&figureurl_qq=http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJrxNAnfibiaU34I5bP2ic2f50ryiaWsfJJY3TH1LYkGNPCUXgvkIHgRYlQm7Dc8g16wKfRuM2LKX4d8A/132&invite=%@&clientinfo=com.glodon.constructioncalculators;建工计算器@com.airuan.debu;德布@com.ruiyou.ttsss;天天十三水@com.tencent.tmgp.sgame;王者荣耀@com.qiyi.video;爱奇艺@com.myskin.n1;AppSon1@com.finddreams.baselib;BaseLib@com.ztsoft.gpsposition;GPS手机定位@com.ss.android.ugc.live;火山小视频@com.dls.druler;D尺@com.mt.mtxx.mtxx;美图秀秀@cn.qvni.wechatgroup;微信群@com.sigma_rt.totalcontrol;Total Control@com.funshion.video.player;小米风行播放插件@com.baidu.input_miv6;百度输入法小米版@com.tencent.mm;微信@com.canpule.geniuspiano;e钢琴@com.google.android.marvin.talkback;TalkBack@com.baidu.duersdk.opensdk;语音识别设置@com.tencent.android.qqdownloader;应用宝@com.sskj.flashlight;随手电筒@com.mfashiongallery.emag;小米画报@com.win345.stockmom;Mom机构版@com.tencent.mtt;QQ浏览器@com.tencent.mm.openapi;GenSignature@com.meituo.xiazhuan;瞎转@com.xiaomi.adecom;电商助手@com.youdao.dict;网易有道词典@com.sohu.sohuvideo.miplayer;小米搜狐视频播放器插件@com.UCMobile;UC@com.qiyi.video.sdkplayer;爱奇艺播放器@com.ss.android.ugc.aweme;抖音短视频@com.hongyun.yx;鸿运湖南棋牌@com.google.android.gms;Google Play服务@com.google.android.gsf;Google服务框架@com.tencent.mobileqq;QQ@com.ximalaya.ting.android;喜马拉雅FM@com.xinsheng.yx;鑫胜棋牌@com.baidu.BaiduMap;百度地图@zekitez.com.satellitedirector;卫星主任@com.google.android.gsf.login;Google帐户管理程序@com.xiaomi.apps.videodaily;快视频@com.youba.barcode;二维码扫描@com.google.android.inputmethod.pinyin;谷歌拼音输入法@com.zly.www.simple.test;com.zly.www.simple.test@cn.kuwo.player;酷我音乐@com.smile.gifmaker;快手@cn.yn.zyl.goodsbarcode;商品条形码查询@com.handmark.pulltorefresh.library;com.handmark.pulltorefresh.library@cn.dictcn.android.digitize.sw_gjxdhycd_10012;现代汉语词典@com.pplive.androidsdk.mi;小米PPTV播放器插件@com.miui.video.plugin;小米视频追剧助手@cn.wps.moffice_eng;WPS Office@com.fuqing.yx;福清十三水@&network=WIFI&username=%@&key=%@&phoneinfo=手机IMEI号：%@手机IESI号：null手机型号：MI 5手机品牌：Xiaomi手机号码：null&version=2&accesstoken=7_prhIPKlhictz4_eUKinCUTciDiVrZvD7op0s61cjTLSt4M6WEfxwHMO00P4tMFJbnblyiwooQEQ8rlfXJey53o1Q_vOM_RPamomaeUIQq2E",device,invite,username,key,device];
    
    
    [self postJson:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:[[self class] encodeString:from2] completionHandler:^(id data) {
        
        
        
        if ([data valueForKey:@"msg"] == nil) {
            
            
            if (![self.mKey containsObject:data[@"qqkey"]]) {
                [self.mKey addObject:data[@"qqkey"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:self.mKey forKey:@"XZKEY"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
            
            
            if ([data[@"chai_hongbao"] floatValue] <= 0) {
                [self save_weixin_qq:device iusername:data[@"username"] qq:qq uid:data[@"uid"] qqkey:data[@"qqkey"]];
                
                NSLog(@"login : %@",data);
            }else{
                NSLog(@"已注册！！！ - uid:%@ - username:%@\t(%@-%@)",data[@"uid"],data[@"username"],data[@"qqkey"],key);
            }
            
            
            
        }else{
            NSLog(@"-------msg : %@------\t(%@)",[data valueForKey:@"msg"],key);
            NSLog(@"\n\n\n\n");
        }
        
    }];
    
}






- (void)save_weixin_qq:(NSString *)device iusername:(NSString *)username qq:(NSString *)qq uid:(NSString *)uid qqkey:(NSString *)qqkey{
    
    NSString * from = [NSString stringWithFormat:@"act=save_weixin_qq&network=WIFI&device=%@&savetype=hongbao&username=%@&signature=82024da003020102020420cabb1d300d&version=2&qq=%@&op=qq&uid=%@&qqkey=%@",device,username,qq,uid,qqkey];
    
    [self postJson:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
        
        if ([data[@"code"] intValue] == 1) {
            [self hongbao:device iusername:username uid:uid qqkey:qqkey];
        }
        
    }];
    
}

- (void)hongbao:(NSString *)device iusername:(NSString *)username uid:(NSString *)uid qqkey:(NSString *)qqkey{
    
    NSString * from = [NSString stringWithFormat:@"act=hongbao&network=WIFI&device=%@&username=%@&signature=82024da003020102020420cabb1d300d&version=2&uid=%@&qqkey=%@",device,username,uid,qqkey];
    
    [self postTest:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
        
        [self user:device iusername:username uid:uid qqkey:qqkey];
        self.scuCont ++;
        
        [self.arr addObject:uid];
        
    }];
    
}



- (void)user:(NSString *)device iusername:(NSString *)username uid:(NSString *)uid qqkey:(NSString *)qqkey{
    
    NSString * from = [NSString stringWithFormat:@"act=user&network=WIFI&device=%@&username=%@&signature=82024da003020102020420cabb1d300d&version=2&uid=%@&qqkey=%@",device,username,uid,qqkey];
    
    [self postJson:@"http://xiazhuan.duoshoutuan.com" POST:@"/shell/android.php" dataString:from completionHandler:^(id data) {
        NSLog(@"user : %@",data);
        
        self.total += [data[@"chai_hongbao"] floatValue];
        
        NSString * str;
        for (NSString * uid in self.arr) {
            if (str == nil) {
                str = uid;
            }else{
                str = [NSString stringWithFormat:@"%@\t%@",str,uid];
            }
            
        }
        [self.scuContL performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"已经成功%d个--- 共%.2f元 \n%@",self.scuCont,self.total,str] waitUntilDone:NO];
        
        
    }];
    
}



#pragma mark Tool Methods
+ (NSString *)generateTradeNO {
    
    static int kNumber = 2;
    
    //    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *sourceStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0)); // 此行代码有警告:
    for (int i = 0; i < kNumber; i++) {
        
        unsigned index = rand() % [sourceStr length];
        
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+ (NSString *)generateRand:(int)count {
    
    int kNumber = count;
    
    //    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0)); // 此行代码有警告:
    for (int i = 0; i < kNumber; i++) {
        
        unsigned index = rand() % [sourceStr length];
        
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+(NSString*)encodeString:(NSString*)unencodedString{
    
    if([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0) {
        return[unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
        
        
    }
    NSString*encodedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)unencodedString,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSString *)getZM:(int)a{
    
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz-_";
    
    return [sourceStr substringWithRange:NSMakeRange(a, 1)];
}


#pragma mark -- 网络调用
- (void)postJson:(NSString *)host POST:(NSString *)post dataString:(NSString *)string  completionHandler:(void (^)(id  data))completionHandler{
    //post方法
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",host,post]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
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




- (void)postTest:(NSString *)host POST:(NSString *)post dataString:(NSString *)string  completionHandler:(void (^)(id  data))completionHandler{
    //post方法
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",host,post]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
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



- (void)postDic:(NSString *)host POST:(NSString *)post data:(NSDictionary *)dic  completionHandler:(void (^)(id  data))completionHandler{
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
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //下面的二次转换很重要，因为使用NSJSONSerialization生成的data不能直接传给服务端，服务端必须要根据一个名字来读取数据，下面就是给jsonData格式化并取个名称
    
    NSString *strData = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    
    
    NSString *postData = [[NSString alloc] initWithFormat:@"%@",strData];
    NSData *sendData = [postData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]; //这个sendData才可以发送给服务端
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", [sendData length]];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    //    [request setValue:@"https://whatever.com" forHTTPHeaderField:@"Referer"];
    
    //5.设置请求体
    request.HTTPBody= sendData;
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        //8.解析数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
    
        
        completionHandler(dict);
        
    }];
    
    //7.执行任务
    [dataTask resume];
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
