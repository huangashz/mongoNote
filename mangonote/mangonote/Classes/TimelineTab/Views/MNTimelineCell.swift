 //
//  MNTimelineCell.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/30.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit
import SnapKit

class MNTimelineCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    lazy var dateLabel = UILabel()
    lazy var abstract = UILabel()
    lazy var imageView = UIImageView()
    lazy var line = UIView()
    lazy var containerView = UIView()
    lazy var deleteBtn = UIButton()
    
    var panGesture : UIPanGestureRecognizer?
    var hasImage = false
    
    var editMode = false
    var positionX : CGFloat = 0
    let gap = CGFloat(-100)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        addPanGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        self.backgroundColor = MNColors.White95()
        containerView.backgroundColor = MNColors.bg1()

        deleteBtn.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        deleteBtn.setImage(UIImage.init(named: "delete.png"), for: .normal)
        deleteBtn.clipsToBounds = true
        deleteBtn.layer.cornerRadius = 20
        deleteBtn.backgroundColor = MNColors.bg1()
        deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
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
        
        containerView.addSubview(dateLabel)
        containerView.addSubview(line)
        containerView.addSubview(abstract)
        containerView.addSubview(imageView)
        self.addSubview(containerView)
        self.insertSubview(deleteBtn, belowSubview: containerView)
        
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
        
        deleteBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.right.equalTo(-30)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }
    
    private func addPanGesture() {
        panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handlePanGesture(recognizer:)))
        panGesture?.delegate = self
        containerView.addGestureRecognizer(panGesture!)
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
            make.top.equalTo(line.snp.bottom).offset(14)
            make.left.equalTo(14)
        }
        
        let imageWidth = self.frame.size.width - 28
        let imageHeight = info.hasImage ? 0 : 120
        imageView.snp.remakeConstraints { (make) in
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageHeight)
            make.top.equalTo(abstract.snp.bottom).offset(5)
            make.left.equalTo(14)
        }
    }
    
    //MARK : - handlePanGesture
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let position = recognizer.translation(in: containerView)
        
        if recognizer.state == .began {
            
        }else if recognizer.state == .changed {
            if position.x < 0 || (editMode && position.x + positionX < 0) {//向左滑 或者正在编辑
                containerView.transform = CGAffineTransform(translationX: position.x + positionX , y: 0)
            }
        }else {
            if position.x < gap {
                positionX = gap
                showEditor()
            }else {
                positionX = 0
                hideEditor()
            }
        }
    }
    
    func showEditor() {
         editMode = true
        UIView.animate(withDuration: 0.25, animations: {
            self.containerView.transform = CGAffineTransform(translationX: self.gap , y: 0)
        })
    }
    
    func hideEditor() {
        editMode = false
        UIView.animate(withDuration: 0.25, animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0 , y: 0)
        })
    }

    func deleteItem() {
        
    }
    
    //MARK: - GestureDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((panGesture!.velocity(in: panGesture!.view)).x) > abs((panGesture!.velocity(in: panGesture!.view)).y)
    }
    
}
