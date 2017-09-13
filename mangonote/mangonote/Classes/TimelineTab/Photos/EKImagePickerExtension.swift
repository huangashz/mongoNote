//
//  EKImagePickerExtension.swift
//  notedemo
//
//  Created by HuangZhen on 2017/8/29.
//  Copyright © 2017年 HuangZhen. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
    
    @discardableResult
    mutating func removeSafe(at index: Int) -> Bool {
        if (0..<count).contains(index) {
            self.remove(at: index)
            return true
        }
        return false
    }
}
