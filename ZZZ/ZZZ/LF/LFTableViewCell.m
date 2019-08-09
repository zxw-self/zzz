//
//  LFTableViewCell.m
//  ZZZ
//
//  Created by zxw on 2018/3/5.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "LFTableViewCell.h"
//#import "SocketRocketUtility.h"
#import "ScoketTool.h"

#import "GetNumber.h"

// 15874969304
// 15874969304
@interface LFTableViewCell ()<ScoketToolDelegate,UIAlertViewDelegate>

@property(nonatomic, assign) BOOL isUp;
@property(nonatomic, assign) int QianZhuanCont;

@property(nonatomic, assign) BOOL typePHONE;
@property(nonatomic, strong) NSString * heart;
@property(nonatomic, strong) NSArray * crads;

@property(nonatomic, strong) NSString * usn;
@property(nonatomic, strong) NSString * passport;
@property(nonatomic, strong) NSString * point;

@property(nonatomic, strong) NSString * code;

@property(nonatomic, strong) NSMutableDictionary * AllUsers;
@property(nonatomic, strong) NSMutableArray * players;
@property(nonatomic, strong) NSMutableArray * lookers;

@property(nonatomic, strong) ScoketTool * scoketTool;


@property(nonatomic, strong) UILabel * isGame;
@property(nonatomic, strong) UITextField * timerMin;
@property(nonatomic, assign) CGFloat timerf;


@property(nonatomic, strong) GetNumber * getTool;

@end



@implementation LFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        self.AllUsers = [NSMutableDictionary dictionary];
        self.players = [NSMutableArray array];
        self.lookers = [NSMutableArray array];
        
        self.heart = @"42";
        self.code = @"1001";
        self.isUp = NO;
        float width = CGRectGetWidth([UIScreen mainScreen].bounds) - 10.0f;
        
        self.scoketTool = [[ScoketTool alloc] init];
        self.scoketTool.delegate = self;
        self.timerf = 0.001;
        
        //@"【乐发游戏】您的验证码是"
        //@"。如非本人操作，请忽略。"
        self.getTool = [GetNumber initWithHeard:@"【乐发游戏】您的验证码是" footer:@"。如非本人操作，请忽略。" itemid:@"14482"];
        
        for (int a = 0; a < 4; a++) {
            
            if (a == 0) {
                UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(10, a * 40 + 10, width / 2.5 - 10, 35)];
                field.placeholder = @"手机号";
                field.tag = 110 + a;
                
                field.layer.borderWidth = 1;
                field.layer.backgroundColor = [UIColor grayColor].CGColor;
                field.layer.cornerRadius = 5;
                field.layer.masksToBounds = YES;
                UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(5,0,7,26)];
                leftView.backgroundColor = [UIColor clearColor];
                field.leftView = leftView;
                field.leftViewMode = UITextFieldViewModeAlways;
                field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                
                
                field.backgroundColor = [UIColor whiteColor];
                field.textColor = [UIColor grayColor];
                field.keyboardType = UIKeyboardTypePhonePad;
                [self addSubview:field];
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(width / 2.5 + 10.0 , 40 * a + 10, (width/2.5)*0.5 - 10, 35)];
                button.tag = 120 + a;
                [button setTitle:@"获取" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(huoqu) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor grayColor];
                [self addSubview:button];
                
                
                
                field = [[UITextField alloc] initWithFrame:CGRectMake((width / 2.5)*1.5 + 10, a * 40 + 10, (width/2.5)*0.5 - 10, 35)];
                field.placeholder = @"验证码";
                field.tag = 130 + a;
                field.layer.borderWidth = 1;
                field.layer.backgroundColor = [UIColor grayColor].CGColor;
                field.layer.cornerRadius = 5;
                field.layer.masksToBounds = YES;
                UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(5,0,7,26)];
                leftView1.backgroundColor = [UIColor clearColor];
                field.leftView = leftView1;
                field.leftViewMode = UITextFieldViewModeAlways;
                field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                
                field.backgroundColor = [UIColor whiteColor];
                field.textColor = [UIColor grayColor];
                field.keyboardType = UIKeyboardTypePhonePad;
                [self addSubview:field];
                
                
                
                button = [[UIButton alloc] initWithFrame:CGRectMake((width / 2.5)*2.0 + 10, a * 40 + 10, (width/2.5)*0.5 - 10, 35)];
                button.tag = 140 + a;
                [button setTitle:@"登录" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(LOGIN) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor grayColor];
                [self addSubview:button];
                
                
            }
            
            if (a == 1) {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, a * 40 + 10, (width / 3.0)/2.0 - 10, 35)];
                label.tag = 210 + a;
                label.font = [UIFont systemFontOfSize:13];
                label.textColor = [UIColor grayColor];
                [self addSubview:label];
                
                label = [[UILabel alloc] initWithFrame:CGRectMake((width / 3.0)/2.0 + 10, a * 40 + 10, (width / 3.0)/2.0, 35)];
                label.tag = 220 + a;
                label.font = [UIFont systemFontOfSize:13];
                label.textColor = [UIColor grayColor];
                [self addSubview:label];
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((width / 3.0) * 1.0 + 10, a * 40 + 10, (width / 3.0)/2.0 - 10, 35)];
                button.tag = 230 + a;
                [button setTitle:@"上分" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(shangxiafeng) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor grayColor];
                [self addSubview:button];
                button.hidden = YES;
                
                button = [[UIButton alloc] initWithFrame:CGRectMake((width / 3.0) * 1.5 + 10, a * 40 + 10, (width / 3.0)/2.0 - 10, 35)];
                button.tag = 240 + a;
                [button setTitle:@"加入" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(jiaru) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor grayColor];
                [self addSubview:button];
                button.hidden = YES;
                
                button = [[UIButton alloc] initWithFrame:CGRectMake((width / 3.0) * 2.0 + 10, a * 40 + 10, (width / 3.0)/2.0 - 10, 35)];
                button.tag = 250 + a;
                [button setTitle:@"起身" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(qisheng_10018) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor grayColor];
                [self addSubview:button];
                button.hidden = YES;
                
                button = [[UIButton alloc] initWithFrame:CGRectMake((width / 3.0) * 2.5 + 10, a * 40 + 10, (width / 3.0)/2.0 - 10, 35)];
                button.tag = 260 + a;
                [button setTitle:@"坐下" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(zuoxia_10015) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor grayColor];
                [self addSubview:button];
                button.hidden = YES;
                
            }
            
            if (a == 2) {
                
                UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10, a * 40 + 10, (width / 2.5) - 10, 60)];
                textView.font = [UIFont systemFontOfSize:13];
                textView.tag = 310 + a;
                textView.backgroundColor = [UIColor grayColor];
                [self addSubview:textView];
                textView.editable = NO;
                textView.hidden = YES;
                
                UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake((width / 2.5) + 10, a * 40 + 10, (width / 2.5) * 0.5 - 10, 30)];
                self.timerMin = field;
                
                field.placeholder = @"时间";
                field.tag = 330 + a;
                field.layer.borderWidth = 1;
                field.layer.backgroundColor = [UIColor grayColor].CGColor;
                field.layer.cornerRadius = 5;
                field.layer.masksToBounds = YES;
                UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(5,0,7,26)];
                leftView.backgroundColor = [UIColor clearColor];
                field.leftView = leftView;
                field.leftViewMode = UITextFieldViewModeAlways;
                field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                
                field.backgroundColor = [UIColor whiteColor];
                field.textColor = [UIColor grayColor];
                field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                [self addSubview:field];
                field.hidden = YES;
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((width / 2.5) + 10, a * 40 + 40, (width / 2.5) * 0.5 - 10, 30)];
                button.tag = 340 + a;
                [button setTitle:@"设置" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(shezhiTimer) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor = [UIColor grayColor];
                [self addSubview:button];
                button.hidden = YES;
                
                
                
                
                textView = [[UITextView alloc] initWithFrame:CGRectMake((width / 2.5) * 1.5 + 10, a * 40 + 10, (width / 2.5) - 10, 60)];
                textView.font = [UIFont systemFontOfSize:13];
                textView.tag = 320 + a;
                textView.backgroundColor = [UIColor grayColor];
                [self addSubview:textView];
                textView.editable = NO;
                textView.hidden = YES;
                
            }
            
            if (a == 3){
                UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(width/2.0 + 10, 160, width/2.0 - 10, 30)];
                btn.tag = 410 + a;
                [btn setTitle:@"退出" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor grayColor];
                [btn addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                btn.hidden = YES;
                
                
                btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, width/2.0 - 10, 30)];
                btn.tag = 420 + a;
                [btn setTitle:@"换桌" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor grayColor];
                [btn addTarget:self action:@selector(huanzhuo_10021) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                btn.hidden = YES;
                
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, width/2.0 - 10, 30)];
                self.isGame = label;
                label.text = @"正在游戏中。。。";
                label.textColor = [UIColor redColor];
                label.backgroundColor = [UIColor whiteColor];
                self.isGame.hidden = YES;
                [self addSubview:label];
                
            }
            
            
            
            
            
            
        }
        
    }
    
    return self;
}

- (void)Gamebegin{
    self.isGame.text = @"正在游戏中";
    self.isGame.hidden = NO;
}
- (void)Gameover{
    self.isGame.hidden = YES;
}


- (void)jiaru{
    [self endEditing:YES];
    [self.scoketTool SRWebSocketOpen];//打开soket
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isGame.text = @"正在加入";
        self.isGame.hidden = NO;
    });
    
    
}

- (void)tuichu{
    [self.AllUsers removeAllObjects];
    [self dealwithUser];
    {
        NSMutableDictionary * msg = [NSMutableDictionary dictionary];
        msg[@"code"] = @"10202";
        NSArray * arr = @[@"msg",msg];
        NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
        [self.scoketTool sendData:data];
        
        
        msg[@"code"] = @"1002";
        arr = @[@"msg",msg];
        data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
        [self.scoketTool sendData:data];
        
        [self.scoketTool sendData:@"41/game"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isGame.text = @"正在退出";
        self.isGame.hidden = NO;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scoketTool SRWebSocketClose];
    });
}

- (void)huoqu{
    
    [self endEditing:YES];
    UITextField * field = (UITextField *)[self viewWithTag:110];
    
    
    if ([field.text isEqualToString:@"111"]) {
        
        UIView * view = [self viewWithTag:120];
        view.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            view.userInteractionEnabled = YES;
        });
        
        
        [self.getTool getmobileCompletionHandler:^(id data1) {
            
            NSString * dataStr = data1;
            if (dataStr.length != 11) {
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"获取手机号有误！%@",dataStr] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]
                     show];
                });
                return ;
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                field.text = dataStr;
                [self huoqu];
            });
            
        }];
        return;
    }
    
    
    NSMutableDictionary * args = [NSMutableDictionary dictionary];
    args[@"partner"] = @"youxi";
    args[@"mno"] = field.text;
    
    if (field.text.length < 1 || field.text.length != 11) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"号码不对" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]
         show];
        
        return;
    }
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    data[@"api"] = @"SEND_LOGIN_CAPTCHA";
    data[@"args"] = args;
    
    NSDictionary * user = [[NSUserDefaults standardUserDefaults] valueForKey:field.text];
    if (user == nil) {
        
        self.typePHONE = YES;
        [self postDic:@"http://13.114.27.163/" POST:@"/api/v2" data:data completionHandler:^(id data) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NSLog(@"%@",data[@"des"]);
                if ([data[@"code"] intValue] == 0) {
                    
                    if (self.getTool.isTool) {
                        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码已发送，5秒后自动获取" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                        
                    }else{
                        
                        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@\n请查看短信！！",data[@"des"]] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
                    }
                    
                   
                }else{
                    
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:data[@"des"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
                    
                }
                
               
                
            });
            
        }];
        
    }else{
        self.typePHONE = NO;
        
        [self LOGIN];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex != 0) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.getTool getsmsCompletionHandler:^(id data) {
            
            NSString * dataStr = data;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                if (dataStr.length < 6) {
                    
                    UITextField * field2 = (UITextField *)[self viewWithTag:130];
                    field2.text = dataStr;
                    [self LOGIN];
                    
                }else{
                    if ([dataStr isEqualToString:@"错误:3001"]) {
                        
                        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"尚未收到短信,5秒后继续获取验证码么？"] delegate:self cancelButtonTitle:@"继续" otherButtonTitles:@"取消", nil] show];
                    }else{
                        
                        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@,请联系管理员！！",dataStr] delegate:nil cancelButtonTitle:@"继续" otherButtonTitles:@"取消", nil] show];
                    }
                    
                }
            });
            
        }];
    });
}





- (void)LOGIN{
    [self endEditing:YES];
    UITextField * field = (UITextField *)[self viewWithTag:110];
    UITextField * field2 = (UITextField *)[self viewWithTag:130];
    
    NSMutableDictionary * args = [NSMutableDictionary dictionary];
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    if (self.typePHONE && field.text.length == 11 && field2.text.length == 4) {
        
        args[@"hw"] = @"unknow";
        args[@"pwd"] = field2.text;
        args[@"user"] = field.text;
        args[@"os"] = @"Android";
        args[@"platform"] = @"Android";
        args[@"version"] = @"18.2.18.27074";
        args[@"bundle"] = @"fale.fale.app";
        args[@"device_code"] = @"0";
        args[@"type"] = @"PHONE";
        args[@"partner"] = @"youxi";
        
    }else if(self.typePHONE == NO){
        
        NSDictionary * user = [[NSUserDefaults standardUserDefaults] valueForKey:field.text];
        
        args[@"hw"] = @"unknow";
        args[@"os"] = @"Android";
        args[@"platform"] = @"Android";
        args[@"token"] = user[@"token"];
        args[@"version"] = @"18.2.18.27074";
        args[@"bundle"] = @"fale.fale.app";
        args[@"device_code"] = @"0";
        args[@"type"] = @"TOKEN";
        args[@"partner"] = @"youxi";
    }
    
    
    data[@"api"] = @"LOGIN";
    data[@"args"] = args;
    [self postDic:@"http://13.114.27.163/" POST:@"/api/v2" data:data completionHandler:^(id data) {
        
        if ([data[@"code"] intValue] == 0) {
            self.passport = data[@"passport"];
            self.usn = data[@"usn"];
            self.point = data[@"point"];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                [dic setValue:data[@"token"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:field.text];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                UILabel * label = (UILabel *)[self viewWithTag:211];
                label.text = self.usn;
                label = (UILabel *)[self viewWithTag:221];
                label.text = [NSString stringWithFormat:@"￥%.2f",[self.point integerValue]/100.0f];
                
                [self viewWithTag:231].hidden = NO;
                [self viewWithTag:241].hidden = NO;
                [self viewWithTag:251].hidden = NO;
                [self viewWithTag:261].hidden = NO;
                
                [self viewWithTag:312].hidden = NO;
                [self viewWithTag:322].hidden = NO;
                
                [self viewWithTag:332].hidden = NO;
                [self viewWithTag:342].hidden = NO;
                
            });
            
        }
        
    }];
    
    
    
}

- (void)shezhiTimer{
    [self endEditing:YES];
    if (self.timerMin.text.length > 0 && ([self.timerMin.text floatValue] > 0 && [self.timerMin.text floatValue] < 4.5)) {
        self.timerf = [self.timerMin.text floatValue];
    }else{
        self.timerMin.text = [NSString stringWithFormat:@"%.2f",self.timerf];
    }
    
}

- (void)shangxiafeng{
    [self endEditing:YES];
    self.isUp = !self.isUp;
    UIButton * button = (UIButton *)[self viewWithTag:231];
    [button setTitle:self.isUp?@"下分":@"上分" forState:UIControlStateNormal];
    
    
}

- (void)dealwithUser{
    
    [self.players removeAllObjects];
    [self.lookers removeAllObjects];
    
    [self.AllUsers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        
        if ([obj[@"pos"] intValue] >= 0) {
            [self.players addObject:obj];
        }else {
            [self.lookers addObject:obj];
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UITextView * view = (UITextView *)[self viewWithTag:312];
        view.text = @"";
        NSMutableString * str = [NSMutableString stringWithFormat:@""];
        for (NSDictionary * dic in self.players) {
            [str appendFormat:@"%@\t￥%.2f\n",dic[@"usn"],[dic[@"point"] integerValue]/100.0];
        }
        [str appendFormat:@"游戏者"];
        view.text = str;
        view.scrollsToTop = YES;
        
        view = (UITextView *)[self viewWithTag:322];
        view.text = @"";
        str = [NSMutableString stringWithFormat:@""];
        for (NSDictionary * dic in self.lookers) {
            [str appendFormat:@"%@\t￥%.2f\n",dic[@"usn"],[dic[@"point"] integerValue]/100.0];
        }
        [str appendFormat:@"旁观者"];
        view.text = str;
        view.scrollsToTop = YES;
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UILabel * label = (UILabel *)[self viewWithTag:221];
            label.text = [NSString stringWithFormat:@"￥%.2f",[self.point integerValue]/100.0f];
        });
        
    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}




- (void)SRWebSocketDidOpen {
    //在成功后需要做的操作。。。
    [self viewWithTag:413].hidden = NO;
    [self viewWithTag:423].hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isGame.hidden = YES;
    });
}

- (void)SRWebSocketDidClose{
    [self viewWithTag:413].hidden = YES;
    [self viewWithTag:423].hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isGame.hidden = YES;
    });
}

- (void)SRWebSocketDidReceiveMsg:(NSObject *)note {
    
    //收到服务端发送过来的消息
    NSString * message = (NSString *)note;
    NSLog(@"message : %@",message);
    if (message.length < 1) {
        return;
    }
    
    if ([message isEqualToString:@"41/game"]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.scoketTool SRWebSocketClose];
            [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@ 游戏已退出，切换网络重新连接",self.usn] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil]
             show];
            
        });
    }
    
    if ([[message substringToIndex:1] isEqualToString:@"0"]) {
        return;
    }
    
    if ([message isEqualToString:@"40"]) {
        [self.scoketTool sendData:[NSString stringWithFormat:@"%@/game",message]];
        return;
    }
    
    if ([message isEqualToString:@"40/game"]) {
        
        NSMutableDictionary * body = [NSMutableDictionary dictionary];
        body[@"usn"] = self.usn;
        body[@"app"] = @"10040";
        body[@"room"] = @"100401";
        body[@"version"] = @"18.2.18.27074";
        body[@"platform"] = @"Android";
        body[@"name"] = @"fale.fale.app";
        body[@"passport"] = self.passport;
        body[@"code"] = @"0";
        self.usn = body[@"usn"];
        NSMutableDictionary * msg = [NSMutableDictionary dictionary];
        msg[@"code"] = self.code;
        msg[@"body"] = @[body];
        
        NSArray * arr = @[@"msg",msg];
        
        NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
        
        [self.scoketTool sendData:data];
        
        return;
    }
    
    [self messagedealwith:message];
    
    
}

- (void)messagedealwith:(NSString *)message{
    
    
    if (message.length > [NSString stringWithFormat:@"%@/game,",self.heart].length){
        
        NSString * data = [message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@/game,",self.heart] withString:@""];
        
        NSArray * rr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:4] options:NSJSONReadingMutableContainers error:nil];
        
        NSString * msg = [rr lastObject];
        
        NSString *strUrl = [msg stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[strUrl dataUsingEncoding:4] options:NSJSONReadingMutableContainers error:nil];
        
        
        
        NSInteger code = [dic[@"code"] integerValue];
        switch (code) {
                
            case 1004:
            {
                [self.scoketTool sendData:@"41/game"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.scoketTool SRWebSocketClose];
                    
                    self.code = @"1100";
                    [self.scoketTool SRWebSocketOpen];//打开soket
                    
                });
                
            }break;
                
            case 1016: // 未知
            {
                if ([self.code integerValue] == 1100) {
                    [self weizhi_15200];
                    [self weizhi_15032];
                }else{
                    [self weizhi_1312];
                }
            }break;
                
            case 1301: // 未知
            {
                [self weizhi_10001];
                [self weizhi_15032];
            }break;
                
                
            case 20012: // 时间验证
            {
                [self shijian_20013:message];
            }break;
                
            case 10050: // 用户
            {
                [self weizhi_10051];
            }break;
                
                
            case 10010: // 有人加入
            {
                NSArray * bodys = dic[@"body"];
                for (NSDictionary * user in bodys) {
                    self.AllUsers[user[@"usn"]] = user;
               
                    if ([user[@"usn"] isEqualToString:self.usn] ) {
                        if (user[@"cards"]) {
                            NSArray * arr = user[@"cards"];
                            if (arr.count > 1) {
                                self.crads = arr;
                            }
                        }
                        
                    }
                
                }
                [self dealwithUser];
                
            }break;
                
                
                
            case 10011: // 有人离开
            {
                NSArray * bodys = dic[@"body"];
                for (NSDictionary * user in bodys) {
                    [self.AllUsers removeObjectForKey:user[@"usn"]];
                }
                [self dealwithUser];
                
            }break;
                
                
            case 10024: // 有人做下位置
            {
                NSArray * bodys = dic[@"body"];
                for (NSDictionary * user in bodys) {
                    NSDictionary * dic = [self.AllUsers objectForKey:user[@"usn"]];
                    [dic setValue:user[@"pos"] forKey:@"pos"];
                    self.AllUsers[user[@"usn"]] = dic;
                }
                [self dealwithUser];
            }break;
                
                
            case 10025: // 有人起身位置
            {
                NSArray * bodys = dic[@"body"];
                for (NSDictionary * user in bodys) {
                    NSDictionary * dic = [self.AllUsers objectForKey:user[@"usn"]];
                    [dic setValue:@"-1" forKey:@"pos"];
                    self.AllUsers[user[@"usn"]] = dic;
                }
                [self dealwithUser];
                
            }break;
                
                
                
                
                
            case 10100: // 开始发牌
            {
                [self performSelectorOnMainThread:@selector(Gamebegin) withObject:nil waitUntilDone:YES];
                NSDictionary * body = [(NSArray *)dic[@"body"] firstObject];
                self.crads = body[@"cards"];
                self.QianZhuanCont = 0;
                
            }
                break;
                
                
            case 10101: // 抢地主
            {
                
                if (self.isUp) {
                    [self qiandizhu_10104];
                }else{
                    [self buqiandizhu_10102];
//                    if (self.QianZhuanCont < 1) {
//                        self.QianZhuanCont ++;
//                        [self qiandizhu_10104];
//                    }else{
//                        [self buqiandizhu_10102];
//                    }
                }
                
                
            }break;
              
            case 10106: // 呛到地主之后三张排
            {
                NSDictionary * body = [(NSArray *)dic[@"body"] firstObject];
                [self.crads arrayByAddingObjectsFromArray:body[@"cards"]];
                
            }
                break;
                
                
            case 10121: // 结束
            {
                [self performSelectorOnMainThread:@selector(Gameover) withObject:nil waitUntilDone:YES];
                [self jixuyouxi_10136_10051];
            
                
                NSArray * arr = dic[@"body"];
                for (int a = 0; a < 3; a++) {
                    NSDictionary * dic = arr[a+1];
                    NSDictionary * uer = [self.AllUsers valueForKey:dic[@"usn"]];
                    
                    NSInteger point = [uer[@"point"] integerValue] + [dic[@"pointChange"] integerValue];
                    
                    [uer setValue:[NSString stringWithFormat:@"%d",(int)point] forKey:@"point"];
                    self.AllUsers[dic[@"usn"]] = uer;
                    
                    if ([self.usn isEqualToString:dic[@"usn"]]) {
                        self.point = [NSString stringWithFormat:@"%ld",(long)point];
                    }
                    
                    if (point < 1500) {
                        [self tuichu];
                        [self Gameover];
                    }
                    
                }
                [self dealwithUser];
                
            }break;
              
            case 10019:  //起身成功
            {
                
                NSDictionary * dic = [self.AllUsers objectForKey:self.usn];
                [dic setValue:@"-1" forKey:@"pos"];
                self.AllUsers[self.usn] = dic;
                
                [self dealwithUser];
                
                
            }break;
            
            case 1308:  //坐下成功 座位号号
            {
                NSDictionary * body = [(NSArray *)dic[@"body"] firstObject];
                NSDictionary * dic = [self.AllUsers objectForKey:body[@"usn"]];
                [dic setValue:body[@"pos"] forKey:@"pos"];
                self.AllUsers[body[@"usn"]] = dic;
                
                [self dealwithUser];
            }break;
                
            case 10017:  //坐下失败
            {
                NSDictionary * body = [(NSArray *)dic[@"body"] firstObject];
                if ([body[@"75"] intValue] == 75) {
                    
                    // 您选择的位置不是空的，入座失败
                    [self zuoxia_10015_1];
                    [self zuoxia_10015_2];
                    
                }
                NSDictionary * dic = [self.AllUsers objectForKey:self.usn];
                [dic setValue:@"-1" forKey:@"pos"];
                self.AllUsers[self.usn] = dic;
                
                [self dealwithUser];
                
                
            }break;
                
            case 10110: // 轮到出牌
            {
                if (self.isGame.hidden) {
                    [self performSelectorOnMainThread:@selector(Gamebegin) withObject:nil waitUntilDone:YES];
                }
                NSDictionary * body = [(NSArray *)dic[@"body"] firstObject];
                NSString * iD = body[@"id"];
                
                
                if([body[@"option"] intValue] == 1 && [body[@"usn"] isEqualToString:self.usn]){
                    // 压出
                    if (self.isUp) {
                        [self chupai_10111:iD cards:[NSArray arrayWithObject:[self.crads firstObject]]];
                    }else{
                        [self guo_10113:iD];
                    }
                }
                
                if([body[@"option"] intValue] == 0 && [body[@"usn"] isEqualToString:self.usn]){
                    // 自己出
                    [self chupai_10111:iD cards:[NSArray arrayWithObject:[self.crads firstObject]]];
                }
                
            }break;
                
            default:
                break;
        }
        
        
    }
}




- (void)weizhi_1312{
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"1312";
    msg[@"body"] = @[];
    
    NSArray * arr = @[@"msg",msg];
    
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    
    [self.scoketTool sendData:data];
}

- (void)weizhi_10001{
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10001";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
    
}
- (void)weizhi_10051{
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10051";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
    
}

- (void)weizhi_15032{
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"15032";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
    
}
- (void)weizhi_15200{
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"15200";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
    
}




- (void)shijian_20013:(NSString *)message{
    
    NSString * str = [message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"20012"] withString:@"20013"];
    [self.scoketTool sendData:str];
    [self.scoketTool sendData:[NSString stringWithFormat:@"%d",2]];
}
- (void)qisheng_10018{
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10018";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
}
- (void)zuoxia_10015{
    
    NSString * str = @"0";
    NSString * str1 = @"1";
    NSString * str2 = @"2";
    for (NSDictionary * dic in self.players) {
        switch ([dic[@"pos"] integerValue]) {
            case 0:
            {
                str = @"";
            }break;
            case 1:
            {
                str1 = @"";
            }break;
            case 2:
            {
                str2 = @"";
            }break;
                
            default:
                break;
        }
    }
    
    if (str1.length > 0) {
        str = @"1";
    }
    if (str2.length > 0) {
        str = @"2";
    }
    
    NSMutableDictionary * body = [NSMutableDictionary dictionary];
    body[@"pos"] = str;
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10015";
    msg[@"body"] = @[body];
    
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
}
- (void)zuoxia_10015_1{
    
    NSMutableDictionary * body = [NSMutableDictionary dictionary];
    body[@"pos"] = @"1";
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10015";
    msg[@"body"] = @[body];
    
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
}


- (void)zuoxia_10015_2{
    
    NSMutableDictionary * body = [NSMutableDictionary dictionary];
    body[@"pos"] = @"2";
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10015";
    msg[@"body"] = @[body];
    
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
}



- (void)huanzhuo_10021{
    
    [self.AllUsers removeAllObjects];
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10021";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
}



- (void)buqiandizhu_10102{ //
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10102";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
}
- (void)qiandizhu_10104{ //
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10104";
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    [self.scoketTool sendData:data];
}

- (void)yangpai_10124:(NSString *)cards{
    
    NSMutableDictionary * body = [NSMutableDictionary dictionary];
    body[@"cards"] = @[@([cards intValue]),@([cards intValue])];
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10124";
    msg[@"body"] = @[body];
    
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    
    [self.scoketTool sendData:data];
}

- (void)chupai_10111:(NSString *)Id cards:(NSArray *)cards{
    [self tuoguan:Id];
//    NSMutableArray * arr1 = [NSMutableArray array];
//    [arr1 addObject:[NSString stringWithFormat:@"%@",[cards firstObject]]];
//
//
////    [self yangpai_10124:[arr1 firstObject]];
//
//    NSMutableDictionary * body = [NSMutableDictionary dictionary];
//    body[@"id"] = Id;
//    body[@"cards"] = @[@([[arr1 firstObject] intValue])];
//    body[@"tag"] = @"1";
//
//    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
//    msg[@"code"] = @"10111";
//    msg[@"body"] = @[body];
//
//    NSArray * arr = @[@"msg",msg];
//    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
////    NSLog(@"chupai_10111 : %@",data);
//    [self.scoketTool sendData:data];
}
- (void)guo_10113:(NSString *)Id{
    
    NSMutableDictionary * body = [NSMutableDictionary dictionary];
    body[@"id"] = Id;
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10113";
    msg[@"body"] = @[body];
    
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timerf * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scoketTool sendData:data];
    });
    
}

- (void)tuoguan:(NSString *)Id{
    
    NSMutableDictionary * body = [NSMutableDictionary dictionary];
    body[@"id"] = Id;
    
    NSMutableDictionary * msg = [NSMutableDictionary dictionary];
    msg[@"code"] = @"10111";
    msg[@"body"] = @[body];
    
    NSArray * arr = @[@"msg",msg];
    NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
    
    [self.scoketTool sendData:data];
    
}






- (void)jixuyouxi_10136_10051{  // 10121结束一盘
    {
        NSMutableDictionary * msg = [NSMutableDictionary dictionary];
        msg[@"code"] = @"10136";
        NSArray * arr = @[@"msg",msg];
        NSString * data = [NSString stringWithFormat:@"%@/game,%@",self.heart,[self toString:arr]];
        [self.scoketTool sendData:data];
    }
    [self weizhi_10051];
    
    [self zuoxia_10015];
    
    
    
}






- (NSString *)toString:(id)arr{
    
    NSMutableString * string = [NSMutableString string];
    
    if ([arr isKindOfClass:[NSString class]]) {
        [string appendString:arr];
    }else if ([arr isKindOfClass:[NSArray class]]){
        [string appendString:[self arrToString:arr]];
    }else if ([arr isKindOfClass:[NSDictionary class]]){
        [string appendString:[self dicToString:arr]];
    }
    
    return string;
}

- (NSString *)dicToString:(NSDictionary *)dic{
    NSMutableString * string = [NSMutableString string];
    [string appendString:@"{"];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            [string appendString:@"\\"];
            [string appendString:@"\""];
            [string appendString:key];
            [string appendString:@"\\"];
            [string appendString:@"\""];
            
            [string appendString:@":"];
            
            [string appendString:@"\\"];
            [string appendString:@"\""];
            [string appendString:obj];
            [string appendString:@"\\"];
            [string appendString:@"\""];
            
        }else if ([obj isKindOfClass:[NSArray class]]){
            
            [string appendString:@"\\"];
            [string appendString:@"\""];
            [string appendString:key];
            [string appendString:@"\\"];
            [string appendString:@"\""];
            
            [string appendString:@":"];
            
            [string appendString:[self arrToString:obj]];
            
            
            
            
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            
            
            [string appendString:@"\\"];
            [string appendString:@"\""];
            [string appendString:key];
            [string appendString:@"\\"];
            [string appendString:@"\""];
            
            [string appendString:@":"];
            
            [string appendString:[self dicToString:obj]];
            
            
        }
        
        [string appendString:@","];
    }];
    
    [string replaceCharactersInRange:NSMakeRange(string.length - 1, 1) withString:@"}"];
    
    
    return string;
}

- (NSString *)arrToString:(NSArray *)arr{
    NSMutableString * string = [NSMutableString string];
    [string appendString:@"["];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            
            [string appendString:@"\""];
            [string appendString:obj];
            [string appendString:@"\""];
            
            
        }else if ([obj isKindOfClass:[NSArray class]]){
            
            [string appendString:@"\""];
            [string appendString:[self arrToString:obj]];
            [string appendString:@"\""];
            
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            
            if (arr.count == 1) {
                [string appendString:[self dicToString:obj]];
            }else{
                [string appendString:@"\""];
                [string appendString:[self dicToString:obj]];
                [string appendString:@"\""];
            }
        }else if ([obj isKindOfClass:[NSNumber class]]){
            [string appendString:[NSString stringWithFormat:@"%@",obj]];
        }
        
        [string appendString:@","];
        
    }];
    
    if (arr.count > 0) {
        [string replaceCharactersInRange:NSMakeRange(string.length - 1, 1) withString:@"]"];
    }else{
        [string appendString:@"]"];
    }
    
    
    return string;
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
