//
//  EKSmallPhotoCell.swift
//  notedemo
//
//  Created by HuangZhen on 2017/9/1.
//  Copyright © 2017年 HuangZhen. All rights reserved.
//

import UIKit

class EKSmallPhotoCell: UICollectionViewCell {
    
    var photo: UIImageView?
    var selectBtn: UIButton?
    var selectBlock:(()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        photo = UIImageView.init(frame: self.bounds)
        photo?.contentMode = .scaleAspectFill
        photo?.clipsToBounds = true
        self.addSubview(photo!)
        
        let btnWidth = CGFloat(22)
        selectBtn = UIButton.init(type: .custom)
        selectBtn?.frame = CGRect.init(x: self.frame.size.width - btnWidth - 2, y: 2, width: btnWidth, height: btnWidth)
        selectBtn?.setBackgroundImage(UIImage.init(named: "image_pickerDefault.png"), for: .normal)
        selectBtn?.addTarget(self, action: #selector(EKSmallPhotoCell.didSelected(_:)), for: .touchUpInside)
        self.addSubview(selectBtn!)
    }
    
    func didSelected(_ sender: UIButton) {
        if selectBlock != nil {
            selectBlock!()
        }
    }
}
