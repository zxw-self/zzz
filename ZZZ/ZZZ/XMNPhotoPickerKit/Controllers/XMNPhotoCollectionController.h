//
//  XMNPhotoCollectionController.h
//  XMNPhotoPickerKitExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XMNAlbumModel;
@interface XMNPhotoCollectionController : UICollectionViewController

/** 具体的相册 */
@property (nonatomic, strong) XMNAlbumModel *album;

/**
 *  根据给定宽度 获取UICollectionViewLayout 实例
 *
 *  @param width collectionView 宽度
 *
 *  @return UICollectionViewLayout实例
 */
+ (UICollectionViewLayout *)photoCollectionViewLayoutWithWidth:(CGFloat)width;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com