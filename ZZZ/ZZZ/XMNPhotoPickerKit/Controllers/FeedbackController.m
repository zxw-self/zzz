//
//  FeedbackController.m
//  TouGuApp
//
//  Created by tianshikechuang on 16/6/21.
//  Copyright © 2016年 tianshikechuang. All rights reserved.
//

#import "FeedbackController.h"
#import "TextView.h"
#import "ScrollView.h"
//#import "UIButton+Block.h"
#import "XMNPhotoPickerKit.h"
#import "XMNPhotoCollectionController.h"
#import "XMNPhotoPreviewController.h"
#import "XMNAssetCell.h"
//#import "AccountTool.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define BaseUrl         @"http://xy1101.com/Api/"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface FeedbackController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
}
@property(nonatomic, strong) TextView * textView;
@property(nonatomic, strong) ScrollView * scrollView;
@property(nonatomic, weak) UIButton * rigth;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSArray * arr;

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textView];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton * rightItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    self.rigth = rightItem;
    rightItem.userInteractionEnabled=NO;
    rightItem.selected = YES;
    [rightItem setTitle:@"提交" forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [rightItem addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    
    
    [self addcollcionView];
    
}

- (TextView *)textView{
    if (!_textView) {
        _textView = [[TextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.maxCount = 500;
        _textView.placeholder = @"请输入您的宝贵建议...";
        __block typeof(self) weakSelf = self;
        [_textView setEditBlock:^(NSString *str) {
            if (str.length < 1) {
                weakSelf.rigth.userInteractionEnabled = NO;
                weakSelf.rigth.selected = YES;
            }else{
                weakSelf.rigth.userInteractionEnabled = YES;
                weakSelf.rigth.selected = NO;
            }
            
            
        }];
        
        [self.view addSubview:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _textView;
}



- (void)addcollcionView{
    
    //
    UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (KScreenWidth - 70)/3;
    fl.itemSize = CGSizeMake(width, width);
    fl.minimumLineSpacing = 5;
    fl.minimumInteritemSpacing = 5;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(25, 160, KScreenWidth - 50, KScreenWidth - 50) collectionViewLayout:fl];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellWithReuseId"];
    
    
    [self.view addSubview:self.collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    NSLog(@"%@ -- %ld",self.images,self.images.count);
    
    return self.images.count>=9?self.images.count:self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellWithReuseId" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:cell.bounds];
    imageview.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    imageview.clipsToBounds = YES;
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.images.count < 9) {
        if (indexPath.row == self.images.count) {
            
            // 这里设置加号按钮的图片
            imageview.image = [UIImage imageNamed:@"icon_29.png"];
            [cell.contentView addSubview:imageview];
            
            return cell;
        }else{
            imageview.image = self.images[indexPath.row];
            [cell.contentView addSubview:imageview];
        }
    }else{
        imageview.image = self.images[indexPath.row];
        [cell.contentView addSubview:imageview];
    }
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.images.count) {
        
        //1.初始化一个XMNPhotoPickerController
        NSInteger maxCount = 9 - self.images.count;
        
        XMNPhotoPickerController *photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:maxCount delegate:nil];
        
        //3..设置选择完照片的block 回调
        __weak typeof(self) wSelf = self;
        [photoPickerC setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
            __weak typeof(*&self) self = wSelf;
            NSMutableArray * totol = [NSMutableArray arrayWithArray:self.arr];
            [totol addObjectsFromArray:assets];
            self.arr = totol;
            NSMutableArray * arr = [NSMutableArray array];
            for (XMNAssetModel * model in totol) {
                [arr addObject:model.thumbnail];
            }
            self.images = arr;
            
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.collectionView reloadData];
        }];
        
        [self presentViewController:photoPickerC animated:YES completion:nil];
    }else{
        
        NSInteger index = self.images.count >= 9 ? indexPath.row : indexPath.row - 1;
        index = indexPath.row;
        XMNPhotoPreviewController *previewC = [[XMNPhotoPreviewController alloc] initWithCollectionViewLayout:[XMNPhotoPreviewController photoPreviewViewLayoutWithSize:[UIScreen mainScreen].bounds.size]];
        previewC.assets = self.arr;
        previewC.selectedAssets = [NSMutableArray arrayWithArray:self.arr];
        previewC.currentIndex = index;
        previewC.maxCount = self.arr.count;
        
        [previewC setDidFinishPreviewBlock:^(NSArray<XMNAssetModel *> *selectedAssets) {
            self.arr = selectedAssets;
            NSMutableArray * arr = [NSMutableArray array];
            for (XMNAssetModel * model in selectedAssets) {
                [arr addObject:model.thumbnail];
            }
            self.images = arr;
            [self.collectionView reloadData];
        }];
        __block typeof(previewC) blockP = previewC;
        [previewC setDidFinishPickingBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *selectedAssets) {
            
            self.arr = selectedAssets;
            NSMutableArray * arr = [NSMutableArray array];
            for (XMNAssetModel * model in selectedAssets) {
                [arr addObject:model.thumbnail];
            }
            self.images = arr;
            
            [blockP.navigationController popViewControllerAnimated:YES];
            
            [self.collectionView reloadData];
        }];
        [self.navigationController pushViewController:previewC animated:YES];
        
    }
    
    
    
    
    
    
    
    
    
    
    
}




- (void)rightItemAction:(UIButton *)sender{
    
//    [MBProgressHUD showMessage:@""];
    
    
    NSData * data;
    if (self.images.count > 0) {
        UIImage * image = [self.images firstObject];
        data = UIImageJPEGRepresentation(image, 0.6);
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    docDir = [docDir stringByAppendingPathComponent:@"saveIcon.jpg"];
    BOOL isW = [data writeToFile:docDir atomically:YES];
    if (!isW) {
        
//        [MBProgressHUD showError:@"图片上传失败！"];
        return;
    }
    
    
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"message"] = self.textView.text;
//    dic[@"user_id"] = [NSString stringWithFormat:@"%@",[AccountTool account].user_id];
//    dic[@"auth_key"] = [AccountTool account].auth_key;
 
    
//    [MBProgressHUD hideHUD];
    NSString *url = [NSString stringWithFormat:@"%@Center/user_feedback", BaseUrl];

    
//    [MBProgressHUD showMessage:@""];
    
//    [[[HttpTool alloc] init] upLoad:url params:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//        [self.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            NSData * data = UIImageJPEGRepresentation(obj, 0.6);
//
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            NSString *docDir = [paths objectAtIndex:0];
//            docDir = [docDir stringByAppendingPathComponent:@"saveIcon.jpg"];
//            BOOL isW = [data writeToFile:docDir atomically:YES];
//            if (!isW) {
//
//                [MBProgressHUD showError:@"图片上传失败！"];
//                return;
//            }
//
//            NSURL *url = [NSURL fileURLWithPath:docDir];
//
//            //name是传输的文件的类型
//            if (idx == 0) {
//                [formData appendPartWithFileURL:url name:@"image" fileName:@"saveIcon.jpg" mimeType:@"image/jpg" error:nil];
//            }else{
//                [formData appendPartWithFileURL:url name:[NSString stringWithFormat:@"image%d",idx] fileName:@"saveIcon.jpg" mimeType:@"image/jpg" error:nil];
//            }
//
//
//
//        }];
//
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //        [MBProgressHUD hideHUD];
//        //        if (uploadProgress.totalUnitCount <= 0 || uploadProgress.completedUnitCount <= 0) {
//        //            [MBProgressHUD showMessage:@"0.00％"];
//        //        }else{
//        //            CGFloat pro = ((float)uploadProgress.completedUnitCount) / uploadProgress.totalUnitCount;
//        //            [MBProgressHUD showMessage:[NSString stringWithFormat:@"%.2f％",pro*100.00]];
//        //        }
//        //        NSLog(@"总大小：%lld,当前大小:%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
//        //
//        //        [MBProgressHUD hideHUD];
//    } sssuccess:^(id responseObject) {
//        [MBProgressHUD hideHUD];
//
//        [MBProgressHUD showSuccess:@"信息反馈成功"];
//        self.textView.text = @"";
//        self.rigth.userInteractionEnabled = NO;
//
//    } failure:^(NSError *error) {
//        NSString *msg = @"信息反馈失败";
//        NSString *errorMsg =  error.userInfo[NSLocalizedDescriptionKey];
//        if (errorMsg.length) {
//            msg = [NSString stringWithFormat:@"%@,%@",msg,errorMsg];
//        }
//        [MBProgressHUD showError:msg];
//    }];
    
}



















- (void)addButton{
    ScrollView * scrollV = [[ScrollView alloc] initWithFrame:CGRectMake(0, 224, KScreenWidth, 80)];
    self.scrollView = scrollV;
    
    scrollV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollV];
    
    __block typeof(scrollV) weakScrollV = scrollV;
    [scrollV setButBlock:^{
        //1.初始化一个XMNPhotoPickerController
        NSInteger maxCount = 1 - weakScrollV.arr.count;
//        if (maxCount == 0) {
//            [self showAlertWithMessage:@"您已经选够9张图片了!!!"];
//            return ;
//        }
        
        XMNPhotoPickerController *photoPickerC = [[XMNPhotoPickerController alloc] initWithMaxCount:maxCount delegate:nil];
        
        //3..设置选择完照片的block 回调
//        __weak typeof(self) wSelf = self;
        [photoPickerC setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
//            __weak typeof(*&self) self = wSelf;
            NSMutableArray * totol = [NSMutableArray arrayWithArray:weakScrollV.arr];
            [totol addObjectsFromArray:assets];
            weakScrollV.arr = totol;
            NSMutableArray * arr = [NSMutableArray array];
            for (XMNAssetModel * model in totol) {
                [arr addObject:model.thumbnail];
            }
            weakScrollV.contentViewArr = arr;
        
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:photoPickerC animated:YES completion:nil];
    }];
    
    [scrollV setImgBlock:^(NSInteger index) {
        XMNPhotoPreviewController *previewC = [[XMNPhotoPreviewController alloc] initWithCollectionViewLayout:[XMNPhotoPreviewController photoPreviewViewLayoutWithSize:[UIScreen mainScreen].bounds.size]];
        previewC.assets = weakScrollV.arr;
        previewC.selectedAssets = [NSMutableArray arrayWithArray:weakScrollV.arr];
        previewC.currentIndex = index;
        previewC.maxCount = weakScrollV.arr.count;
        
        [previewC setDidFinishPreviewBlock:^(NSArray<XMNAssetModel *> *selectedAssets) {
            weakScrollV.arr = selectedAssets;
            NSMutableArray * arr = [NSMutableArray array];
            for (XMNAssetModel * model in selectedAssets) {
                [arr addObject:model.thumbnail];
            }
            weakScrollV.contentViewArr = arr;
        }];
        __block typeof(previewC) blockP = previewC;
        [previewC setDidFinishPickingBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *selectedAssets) {
            
            weakScrollV.arr = selectedAssets;
            NSMutableArray * arr = [NSMutableArray array];
            for (XMNAssetModel * model in selectedAssets) {
                [arr addObject:model.thumbnail];
            }
            weakScrollV.contentViewArr = arr;
            
            [blockP.navigationController popViewControllerAnimated:YES];
        }];
        [self.navigationController pushViewController:previewC animated:YES];
    }];
    
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
- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params
 {
    // 文件上传
    NSURL *url = [NSURL URLWithString:[BaseUrl stringByAppendingPathComponent:@"Center/user_feedback"]];
     
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
             
             if (dict && [[dict objectForKey:@"status"] intValue] == 1) {
//                  HUD(@"提交成功");
                 [self.navigationController popViewControllerAnimated:YES];
                 
             }else{
//                  HUD(@"提交失败");
             }
             
         } else {
//             HUD(@"提交失败");
         }
     }];
}


@end
