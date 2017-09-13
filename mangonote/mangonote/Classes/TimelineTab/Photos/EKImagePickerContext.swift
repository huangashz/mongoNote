//
//  EKImagePickerContext.swift
//  notedemo
//
//  Created by HuangZhen on 2017/9/11.
//  Copyright © 2017年 HuangZhen. All rights reserved.
//

import UIKit
import Photos

class EKImagePickerContext: NSObject {
    private var imagePickerHelper: EKImagePickerHelper?
    
    init(helper: EKImagePickerHelper) {
        super.init()
        imagePickerHelper = helper
    }
    
    //MARK: Public Methods
    func getPikcerImagesNumber(ablumIndex: Int) -> Int {
        guard let count = imagePickerHelper?.getAblumCount(ablumIndex) else {
            return 0
        }
        return count
    }
    
    func getPhotoCell(_ collectionView: UICollectionView, ablumIndex: Int, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EKPhotoReuseIdentifier, for: indexPath) as! EKSmallPhotoCell
        //加载图片
        var photoIndexPath = indexPath.row
        weak var weakCell = cell
        if let photoAsset = self.imagePickerHelper?.getPHAsset(ablumIndex, photoIndex: photoIndexPath) {
            self.imagePickerHelper?.getPhotoDefalutSize(ablumIndex, photoIndex: photoIndexPath, resultHandler: { (image, infoDic) in
                weakCell?.photo?.image = image
            })
            //改变状态
            if let photoIndex = imagePickerHelper?.index(ofSelect: photoAsset) {
//                weakCell?.selectNumBt.isSelected = true
//                cell.selectNumBt.setTitle("\(photoIndex+1)", for: .selected)
            }else {
//                weakCell?.selectNumBt.isSelected = false
//                cell.selectNumBt.setTitle("", for: .normal)
            }
            setPickerSelectBlock(cell: cell, photoAsset: photoAsset, ablumIndex: ablumIndex, photoIndex: photoIndexPath)
        }
        return cell
    }
    
    private func setPickerSelectBlock(cell: EKSmallPhotoCell, photoAsset: PHAsset, ablumIndex: Int, photoIndex: Int) {
        weak var weakCell = cell
        //判断selectCV是需要加入还是删除
        cell.selectBlock = { [weak self] () in
        }
    }
    
}
