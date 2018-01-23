//
//  MNEditToolBar.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/31.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

class MNEditToolBar: UIView {

    let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: 0.5))
    var selectBlock:((_ index: NSInteger)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        line.backgroundColor = MNColors.bg4()
        self.backgroundColor = MNColors.bg1()
        self.addSubview(line)
        for i in 0..<4 {
            let height = self.frame.size.height
            let width = height
            let space = (APP_SCREEN_WIDTH - 4*height)/5
            
            let button = UIButton.init(type: .custom)
            button.tag = i;
            button.frame = CGRect.init(x: space + CGFloat(i) * (width + space), y: 0, width: width, height: height)
            button.addTarget(self, action: #selector(MNEditToolBar.buttonClicked(_:)), for: .touchUpInside)
            button.setImage(image(index: i), for: .normal)
            button.contentMode = .scaleAspectFill
            button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
            self.addSubview(button)
        }
    }
    
    func buttonClicked(_ button: UIButton) {
        if nil != selectBlock {
            selectBlock!(button.tag)
        }
    }

    func image(index: NSInteger) -> UIImage? {
        var image: UIImage?
        switch index {
        case 0:
            image = UIImage.init(named: "pic.png")
            break
        case 1:
            image = UIImage.init(named: "camera.png")
            break
        case 2:
            image = UIImage.init(named: "map.png")
            break
        case 3:
            image = UIImage.init(named: "mic.png")
            break
        default:
            break
        }
        return image
    }
}
