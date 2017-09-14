//
//  MNEditorViewController.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/30.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

class MNEditorViewController: MNBaseViewController, EKImagePcikerDelegate {
    
    var editor: MNEditor?
    var editToolbar: MNEditToolBar?
    
    override func loadView() {
        super.loadView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initEditor()
        initToolbar()
        // Do any additional setup after loading the view.
        /*
            test
         NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
         
         NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
         textAttachment.image = [UIImage imageNamed:@"111"]; //要添加的图片
         
         NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment] ;
         
         [string insertAttributedString:textAttachmentString atIndex:_textView.selectedRange.location];//index为用户指定要插入图片的位置
         _textView.attributedText = string;
         */
//        let testStr: NSMutableString = NSMutableString.init(string: editor?.textView?.attributedText)
        let textAtt = NSTextAttachment()
        textAtt.image = UIImage.init(named: "camera.png")
        let string = NSAttributedString.init(attachment: textAtt)
        editor?.textView?.attributedText = string
        
    }
    
    func initEditor() {
        editor = MNEditor()
        view.addSubview(editor!.textView!)
    }
    
    func initToolbar() {
        editToolbar = MNEditToolBar.init(frame: CGRect.init(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 40))
        view.addSubview(editToolbar!)
        
        editToolbar?.selectBlock = {
            index in
            switch index {
            case 0:
                //选取相册照片
                self.editor?.textView?.resignFirstResponder()
                let imagePickerController = EKImagePickerViewController()
                imagePickerController.delegate = self
                let imagePickerNavController = MNNavigationController.init(rootViewController: imagePickerController)
                self.navigationController?.present(imagePickerNavController, animated: true, completion: {
                    
                })
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
    }
    
    func showToolbar(positonY: CGFloat) {
        UIView.animate(withDuration: 0.25) { 
            self.editToolbar?.frame = CGRect.init(x: 0, y: positonY - 40, width: self.view.frame.size.width, height: 40)
        }
    }
    
    func hideToolbar() {
        UIView.animate(withDuration: 0.25) {
            self.editToolbar?.frame = CGRect.init(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 40)
        }
    }

    // MARK: - Keyboard Notification
    func keyboardWillShow(notification: Notification) {
        let userinfo: NSDictionary = notification.userInfo! as NSDictionary
        let nsValue = userinfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRec = nsValue.cgRectValue
        let height = keyboardRec.size.height
        UIView.animate(withDuration: 0.25) { 
            self.editor?.textView?.frame = CGRect.init(x: 0, y: self.editor!.textView!.frame.origin.y, width: self.editor!.textView!.frame.size.width, height: self.view.frame.size.height - height - 50 - self.editToolbar!.frame.size.height)
        }
        self.showToolbar(positonY: view.frame.size.height - height)
    }
    
    func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25) { 
            self.editor?.textView?.frame = CGRect.init(x: 0, y: self.editor!.textView!.frame.origin.y, width: self.editor!.textView!.frame.size.width, height: self.view.frame.size.height)
        }
        self.hideToolbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - EKImagePcikerDelegate
    
    func imagePickerDidFinished(photos: [UIImage]) {
        if photos.count > 0 {
            
        }
        self.editor?.textView?.becomeFirstResponder()
    }
    
     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
