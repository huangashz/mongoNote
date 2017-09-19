//
//  MNTimelineViewController.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/29.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

let MNShouldEndEditingNotification = "MNShouldEndEditingNotification"
let reuseId = "collectionViewCellReuseId"

class MNTimelineViewController: MNBaseViewController, MNEditorDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView?
//    var collectionViewLayout = MNCollectionViewFlowLayout()
    var collectionViewLayout = UICollectionViewFlowLayout()
    var model = MNTimelineModel()
    var editorViewController : MNEditorViewController?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = MNColors.White90()
        self.navigationItem.title = "芒果便签"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(createNewNote))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ///add test data
//        try! mnRealm.write {
//            mnRealm.deleteAll()
//        }
//        for _ in 0..<8 {
//            let note = MNNote()
//            note.createAt = Date()
//            note.title = "一篇日记,如果没有过多的语法润泽，那么也是一篇不好的文章，对于散文，大家都很喜欢，喜欢朱自清的洒脱，李清照的温柔，李白我欲成仙的潇洒，杜甫那深入人心，扎人心骨的刀子。"
//            note.updateUIInfo()
//            try! mnRealm.write {
//                mnRealm.add(note)
//            }
//        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notifyAllCellsEndEditing()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.fetch()
        initCollectionView()
    }
    
    func initCollectionView() {
        if nil == collectionView {
            collectionViewLayout.itemSize = CGSize(width: APP_SCREEN_WIDTH, height: 160)
            collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.vertical//设置垂直显示
            collectionViewLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)//设置边距
            collectionViewLayout.minimumLineSpacing = 10.0 //每个相邻的layout的上下间隔
            let rect = CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: APP_SCREEN_HEIGHT)
            collectionView = UICollectionView.init(frame: rect, collectionViewLayout: collectionViewLayout)
            collectionView?.backgroundColor = MNColors.White95()
            collectionView?.register(MNTimelineCell.classForCoder(), forCellWithReuseIdentifier: reuseId)
            collectionView?.dataSource = self
            collectionView?.delegate = self
            collectionView?.alwaysBounceVertical = true
            self.view.addSubview(collectionView!)
        }
    }

    func createNewNote() {
        pushEditorViewController(model: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return model.numbersOfNotes();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:MNTimelineCell  = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath as IndexPath) as! MNTimelineCell
        let noteInfo = model.noteAtIndex(indexPath.row)
        cell.updateContent(info: noteInfo)
        cell.deleteBlock = {
            collectionView.performBatchUpdates({
                try! mnRealm.write {
                    //从数据库中删除
                    mnRealm.delete(noteInfo)
                }
                self.model.fetch()
                collectionView.deleteItems(at: [indexPath])
            }, completion: { (completed) in
                if completed {
                    collectionView.reloadData()
                }
            })
         }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noteInfo = model.noteAtIndex(indexPath.row)
        return CGSize.init(width: APP_SCREEN_WIDTH, height: noteInfo.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MNTimelineCell
        if cell.editMode {
            cell.hideEditor()
            return
        }
        pushEditorViewController(model: model.noteAtIndex(indexPath.row))
    }

    func pushEditorViewController(model: MNNote?) {
        let editorVC = MNEditorViewController()
        editorVC.model = model
        editorVC.editor.delegate = self
        editorViewController = editorVC
        navigationController?.pushViewController(editorVC, animated: true)
    }
    
    //MARK: - MNEditorDelegate
    func contentTextDidChanged() {
        editorViewController?.saveNote()
        model.fetch()
        collectionView?.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        collectionView?.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.notifyAllCellsEndEditing()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func notifyAllCellsEndEditing() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MNShouldEndEditingNotification), object: nil)
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
