//
//  EKImagePcikerDelegate.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/9/14.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

public protocol EKImagePcikerDelegate: NSObjectProtocol {
    func imagePickerDidFinished(photos: [UIImage])
}
