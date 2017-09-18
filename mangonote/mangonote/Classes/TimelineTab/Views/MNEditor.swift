//
//  MNEditor.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/31.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

protocol MNEditorDelegate {
    func contentTextDidChanged()
}

let textFont = CGFloat(17)

class MNEditor: NSObject,UIScrollViewDelegate, UITextViewDelegate {
    
    var delegate: MNEditorDelegate?

    var textView: UITextView?
    
    override init() {
        super.init()
        initTextView()
    }
    
    func initTextView() {
        let rect = CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: APP_SCREEN_HEIGHT)
        textView = UITextView.init(frame: rect)
        textView?.delegate = self
        textView?.isScrollEnabled = true
        textView?.font = UIFont.systemFont(ofSize: textFont)
//        textView?.backgroundColor = .green
        textView?.textContainerInset = UIEdgeInsetsMake(14, 14, 20, 14)
    }
    
    // MARK: - UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
            self.updateCursorPosition(textView)
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCursorPosition(textView)
        delegate?.contentTextDidChanged()
    }
    
    func updateCursorPosition(_ textView: UITextView) {
//        var posion: CGFloat
//        
//        if textView.selectedTextRange != nil {
//            posion = textView.caretRect(for: textView.selectedTextRange!.start).origin.y
//        }else{
//            posion = 0
//        }
//        let curRowFrame = CGRect.init(x: 0, y: posion, width: containerView!.frame.size.width, height: textFont)
//        let convertRect = containerView?.convert(curRowFrame, from: textView)
//        containerView?.scrollRectToVisible(convertRect!, animated: true)
    }
    
    // MARK: - UIScrollowViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        textView?.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        textView?.resignFirstResponder()
        textView?.isScrollEnabled = true
    }
}
