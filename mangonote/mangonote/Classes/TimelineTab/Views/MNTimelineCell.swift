 //
//  MNTimelineCell.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/30.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit
import SnapKit

class MNTimelineCell: UICollectionViewCell {
    
    lazy var dateLabel = UILabel()
    lazy var abstract = UILabel()
    lazy var imageView = UIImageView()
    lazy var line = UIView()
    
    var hasImage = false
    var _cellHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        self.backgroundColor = MNColors.bg1()

        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = MNColors.bg3()
        dateLabel.textAlignment = .right
        
        line.backgroundColor = MNColors.White90()
        
        abstract.font = UIFont.systemFont(ofSize: 18)
        abstract.textColor = UIColor.black
        abstract.textAlignment = .left
        abstract.numberOfLines = 0
        abstract.lineBreakMode = .byTruncatingTail
        
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(dateLabel)
        self.addSubview(line)
        self.addSubview(abstract)
        self.addSubview(imageView)
        
        let dateStr = "8888/88/88"
        let dateStrSize = dateStr.sizeWithFont(dateLabel.font)
        dateLabel.snp.makeConstraints { (make) in
            make.width.equalTo(dateStrSize.width)
            make.height.equalTo(20)
            make.top.equalTo(14)
            make.right.equalTo(-14)
        }
        
        line.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.size.width - 28)
            make.height.equalTo(0.5)
            make.top.equalTo(14 + 20 + 14)
            make.left.equalTo(14)
        }
        
    }
    
    func updateContent(info : MNNote) {
        hasImage = info.hasImage
        let dateStr = String.stringForDate(info.createAt)
        dateLabel.text = dateStr
        abstract.text = info.title
        
        let textWidth = self.frame.size.width - 28
        abstract.snp.remakeConstraints { (make) in
            make.width.equalTo(textWidth)
            make.height.equalTo(info.textHeight)
            make.top.equalTo(line.bottom + 14)
            make.left.equalTo(14)
        }
        
        let imageWidth = self.frame.size.width - 28
        let imageHeight = info.hasImage ? 0 : 120
        imageView.snp.remakeConstraints { (make) in
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageHeight)
            make.top.equalTo(abstract.bottom + 5)
            make.left.equalTo(14)
        }
    }
    
}
