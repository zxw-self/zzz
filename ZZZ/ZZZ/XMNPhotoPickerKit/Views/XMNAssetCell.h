//
//  XMNAssetCell.h
//  XMNPhotoPickerKitExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMNAssetModel;
@interface XMNAssetCell : UICollectionViewCell

/**
 *  按钮点击后的回调
 *  返回按钮的状态是否会被更改
 */
@property (nonatomic, copy, nullable)   BOOL(^willChangeSelectedStateBlock)(XMNAssetModel * _Nonnull asset);

/**
 *  当按钮selected状态改变后,回调
 */
@property (nonatomic, copy, nullable)   void(^didChangeSelectedStateBlock)(BOOL selected, XMNAssetModel * _Nonnull asset);

@property (nonatomic, copy, nullable)   void(^didSendAsset)(XMNAssetModel * _Nonnull asset, CGRect frame);


/**
 *  具体的资源model
 */
@property (nonatomic, strong, readonly, nonnull) XMNAssetModel *asset;

/**
 *  XMNPhotoCollectionController 中配置collectionView的cell
 *
 *  @param item 具体的AssetModel
 */
- (void)configCellWithItem:(XMNAssetModel * _Nonnull )item;

/**
 *  XMNPhotoPicker 中配置collectionView的cell
 *
 *  @param item 具体的AssetModel
 */
- (void)configPreviewCellWithItem:(XMNAssetModel * _Nonnull )item;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com