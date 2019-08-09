//
//  ETHcell.m
//  ZZZ
//
//  Created by zxw on 2018/3/8.
//  Copyright © 2018年 tianshikechuang. All rights reserved.
//

#import "ETHcell.h"
#import "httpTool.h"

#import "GetNumber.h"

@interface ETHcell ()

@property(nonatomic, strong) UIButton * codeBtn;
@property(nonatomic, strong) UITextField * code;


@property(nonatomic, strong) UIButton * regbtn;
@property(nonatomic, strong) UITextField * field;

@property(nonatomic, strong) UITextField * sms;
@property(nonatomic, strong) UILabel * message;

@property(nonatomic, strong) UIButton * reRegbtn;

@property(nonatomic, strong) NSString * PHPSESSID;
@property(nonatomic, strong) httpTool * tool;
@property(nonatomic, strong) GetNumber * getTool;



@end

@implementation ETHcell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        self.codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 70, 40)];
        [self.codeBtn addTarget:self action:@selector(GetImg) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.codeBtn];
        [self.codeBtn setTitle:@"图片" forState:UIControlStateNormal];
        [self.codeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.codeBtn setBackgroundColor:[UIColor lightGrayColor]];
        
        UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 70, 40)];
        field.placeholder = @"图片码";
        field.keyboardType = UIKeyboardTypePhonePad;
        [self dealWithTextField:field];
        self.code = field;
        [self addSubview:field];
        
        
        field = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, 120, 40)];
        self.field = field;
        field.userInteractionEnabled = NO;
        field.placeholder = @"手机号";
        [self addSubview:field];
        [self dealWithTextField:field];
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(90, 50, 120, 40)];
        [btn setTitle:@"开始注册" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(GetMobile) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        self.regbtn = btn;
        
        field = [[UITextField alloc] initWithFrame:CGRectMake(220, 5, 100, 40)];
        self.sms = field;
        field.placeholder = @"短信验证码";
        [self addSubview:field];
        [self dealWithTextField:field];
        
        self.message = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 100, 40)];
        _message.text = @"状态信息";
        self.message.font = [UIFont systemFontOfSize:12];
        self.message.numberOfLines = 0;
        [self addSubview:self.message];
        [self.message setUserInteractionEnabled:NO];
        [self.message setBackgroundColor:[UIColor lightGrayColor]];
        
        self.tool = [[httpTool alloc] init];
        self.getTool = [GetNumber initWithHeard:@"【以太坊8】你好，你的验证码是：" footer:@"，请及时验证。" itemid:@"14991"];
        
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(90, 100, 230, 40)];
        [btn setTitle:@"失败修改图片再次注册" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sendReg) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        self.reRegbtn = btn;
        
        
        self.field.hidden = YES;
        self.regbtn.hidden = YES;
        self.sms.hidden = YES;
        self.message.hidden = YES;
        self.reRegbtn.hidden = YES;
        
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)dealWithTextField:(UITextField *)field{
    field.layer.borderWidth = 1;
    field.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    field.layer.cornerRadius = 5;
    field.layer.masksToBounds = YES;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(5,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    field.leftView = leftView;
    field.leftViewMode = UITextFieldViewModeAlways;
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
}








- (void)GetImg{
    
    self.code.text = @"";
    [self.code becomeFirstResponder];
    
    
    [self.tool GetImageAndCookies:@"http://www.ytf188.com/include/getCode.php" completionHandler:^(UIImage *image, id cookies) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.codeBtn setTitle:@"" forState:UIControlStateNormal];
            [self.codeBtn setBackgroundImage:image forState:UIControlStateNormal];
            self.PHPSESSID = [cookies valueForKey:@"Value"];
            [self Toshow];
            NSLog(@"get PHPSESSID : %@",self.PHPSESSID);
        });
        
    }];
}


- (void)GetMobile{
    
    [self endEditing:YES];
    
    self.message.text = @"获取手机号";
    if (self.code.text.length < 4) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写图片的数字码！！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]
         show];
        
        return;
    }
    
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
            self.field.text = dataStr;
            self.message.text = @"发送短信";
            [self sendMsm];
        });
        
    }];
}


- (void)sendMsm{
    
    [self.tool sendMsm:self.field.text completionHandler:^(id data) {
        
        NSLog(@"%s",__func__);
        NSLog(@"%@",data);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.message.text = data;
            if (![data isEqualToString:@"发送短信失败"]) {
                [self getosms:0];
            }
        });
        
    }];
    
}

- (void)getosms:(int)a{
    
    if (a > 20) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@,获取短信验证码失败！",self.field.text] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
        });
        return;
    }
    
    [self.getTool getsmsCompletionHandler:^(id data) {
        
        NSLog(@"%s",__func__);
        NSLog(@"%@",data);
        
        NSString * dataStr = data;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (dataStr.length <= 6) {
                
                self.sms.text = dataStr;
                self.message.text = @"开始注册";
                [self sendReg];
                
            }else{
                if ([dataStr isEqualToString:@"错误:3001"]) {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        int b = a + 1;
                        [self getosms:b];
                        
                    });
                }else{
                    
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@,请联系管理员！！",dataStr] delegate:nil cancelButtonTitle:@"继续" otherButtonTitles:@"取消", nil] show];
                }
                
            }
        });
        
    }];
}



- (void)sendReg{
    [self endEditing:YES];
    
    if (self.field.text.length > 0 && self.sms.text.length>0&& self.code.text.length > 0) {
        
        [self.tool sendReg:self.field.text comMember:self.yaoqingren msg:self.sms.text code:self.code.text PHPSESSID:self.PHPSESSID completionHandler:^(id data) {
            
            NSDictionary * dic = data;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if ([dic[@"state"] intValue] == 1) {
                    self.message.text = @"注册完成";
                    self.code.text = @"";
                    self.sms.text = @"";
                    [self Tohide];
                }else{
                    
                    self.message.text = dic[@"msg"];
                    self.code.text = @"";
                }
            });
            
        }];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填上信息！！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]
         show];
    }
    
    
}





- (void)Toshow{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.field.hidden = NO;
        self.regbtn.hidden = NO;
        self.sms.hidden = NO;
        self.message.hidden = NO;
        self.reRegbtn.hidden = NO;
    });
    
    
}

- (void)Tohide{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.field.hidden = YES;
        self.regbtn.hidden = YES;
        self.sms.hidden = YES;
        self.message.hidden = YES;
        self.reRegbtn.hidden = YES;
        
    });
    
}


@end

