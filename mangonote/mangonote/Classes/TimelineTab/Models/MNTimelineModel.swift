//
//  MNTimelineModel.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/9/15.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit
import RealmSwift

let numberOfNotesInPage = 20


class MNTimelineModel: NSObject {
    
    private var list : Results<MNNote>!
    var curPage = 1
    var noMore = false
    
    func fetch() {
        list = mnRealm.objects(MNNote.self).sorted(byKeyPath: "createAt", ascending: false)
    }
    
    func numbersOfNotes() -> NSInteger {
        return list.count
    }
    
    func noteAtIndex(_ index: NSInteger) -> MNNote {
        return list[index]
    }
    
    func loadMore() {
        curPage += 1
        
        
    }
    
}
