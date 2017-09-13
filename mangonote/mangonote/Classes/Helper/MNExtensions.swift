//
//  MNExtensions.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/31.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

extension UIView {
    //top
    var top: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = top
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    //left
    var left: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = left
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    //bottom
    var bottom: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = bottom - frame.size.height
            self.frame = frame
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    //right
    var right: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = right - self.frame.size.width
            self.frame = frame
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    //width
    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    //height
    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    //size
    var size: CGSize {
        set {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    //origin
    var origin: CGPoint {
        set {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    //centerX
    var centerX: CGFloat {
        set {
            self.center = CGPoint.init(x: centerX, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    
    //centerY
    var centerY: CGFloat {
        set {
            self.center = CGPoint.init(x: self.center.y, y: centerY)
        }
        get {
            return self.center.y
        }
    }
    
}

