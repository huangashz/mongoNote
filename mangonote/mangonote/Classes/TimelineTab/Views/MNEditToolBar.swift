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
            let width = APP_SCREEN_WIDTH/4.0
            let button = UIButton.init(type: .custom)
            button.tag = i;
            button.frame = CGRect.init(x: CGFloat(i) * width, y: 0, width: width, height: self.frame.size.height)
            button.addTarget(self, action: #selector(MNEditToolBar.buttonClicked(_:)), for: .touchUpInside)
            button.setImage(image(index: i), for: .normal)
            button.imageEdgeInsets = UIEdgeInsetsMake(10, 35, 10, 35)
            self.addSubview(button)
        }
    }
    
    func buttonClicked(_ button: UIButton) {
        switch button.tag {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
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
