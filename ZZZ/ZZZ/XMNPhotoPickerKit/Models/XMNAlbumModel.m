//
//  XMNAlbumModel.m
//  XMNPhotoPickerKitExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNAlbumModel.h"

#import "XMNPhotoPickerDefines.h"

#import <Photos/PHFetchResult.h>
#import <AssetsLibrary/ALAssetsGroup.h>

@interface XMNAlbumModel ()

/** 相册的名称 */
@property (nonatomic, copy)   NSString *name;

/** 照片的数量 */
@property (nonatomic, assign) NSUInteger count;

/** PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset> */
@property (nonatomic, strong) id fetchResult;

@end

@implementation XMNAlbumModel

#pragma mark - Methods

+ (XMNAlbumModel *)albumWithResult:(id)result name:(NSString *)name {
    XMNAlbumModel *model = [[XMNAlbumModel alloc] init];
    model.fetchResult = result;
    model.name = [self _albumNameWithOriginName:name];
    if ([result isKindOfClass:[PHFetchResult class]]) {
        PHFetchResult *fetchResult = (PHFetchResult *)result;
        model.count = fetchResult.count;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    } else if ([result isKindOfClass:[ALAssetsGroup class]]) {
        ALAssetsGroup *gruop = (ALAssetsGroup *)result;
        model.count = [gruop numberOfAssets];
#pragma clang diagnostic pop
    }
    return model;
}

+ (NSString *)_albumNameWithOriginName:(NSString *)name {
    if (iOS8Later) {
        NSString *newName;
        if ([name containsString:@"Roll"])         newName = @"相机胶卷";
        else if ([name containsString:@"Stream"])  newName = @"我的照片流";
        else if ([name containsString:@"Added"])   newName = @"最近添加";
        else if ([name containsString:@"Selfies"]) newName = @"自拍";
        else if ([name containsString:@"shots"])   newName = @"截屏";
        else if ([name containsString:@"Videos"])  newName = @"视频";
        else newName = name;
        return newName;
    } else {
        return name;
    }
}


#pragma mark - Getters

- (NSString *)description {
    return [NSString stringWithFormat:@"\n-----album desc start--\nalbum :%@ have %ld photos \nresult :%@\n-----album desc end----",self.name,self.count,self.fetchResult];
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com