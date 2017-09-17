//
//  MNNote.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/9/15.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import RealmSwift

class MNNote: Object {
    //data
    dynamic var createAt = Date()
    dynamic var imageData = NSData()
    dynamic var content = ""
    dynamic var title = ""
    dynamic var id = 1
    
    //UI
    dynamic var hasImage = false
    dynamic var cellHeight: CGFloat = 0
    dynamic var imageHeight: CGFloat = 0
    dynamic var textHeight: CGFloat = 0
    
    func updateUIInfo() {
        let textWidth = APP_SCREEN_WIDTH - 28
        textHeight = title.heightWithConstrainedWidth(width: textWidth, font: UIFont.systemFont(ofSize: 18))
        textHeight = textHeight > 80 ? 80 : textHeight
        imageHeight = hasImage ? 80 : 0
        cellHeight = CGFloat(81 + textHeight + imageHeight)
    }
}
