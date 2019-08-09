//
//  XMNAlbumModel.h
//  XMNPhotoPickerKitExample
//  专辑相关的model
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    XMNAlbumTypeCarmeraRoll = 1,
    XMNAlbumTypeAll,
} XMNAlbumType;


@interface XMNAlbumModel : NSObject

#pragma mark - Properties

/** 相册的名称 */
@property (nonatomic, copy, readonly, nonnull)   NSString *name;

/** 照片的数量 */
@property (nonatomic, assign, readonly) NSUInteger count;

/** PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset> */
@property (nonatomic, strong, readonly, nonnull) id fetchResult;

#pragma mark - Methods


+ (XMNAlbumModel * _Nonnull )albumWithResult:(_Nonnull id)result name:( NSString * _Nonnull )name;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com