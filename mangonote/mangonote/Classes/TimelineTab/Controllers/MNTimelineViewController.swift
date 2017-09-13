//
//  MNTimelineViewController.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/29.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

let reuseId = "collectionViewCellReuseId"

class MNTimelineViewController: MNBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView?
    
    var collectionViewLayout = MNCollectionViewFlowLayout()

    override func loadView() {
        super.loadView()
        view.backgroundColor = MNColors.bg4()
        self.navigationItem.title = "芒果便签"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        initCollectionView()
    }
    
    func initCollectionView() {
        if nil == collectionView {
            collectionViewLayout.itemSize = CGSize(width: APP_SCREEN_WIDTH, height: 160)
            collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.vertical//设置垂直显示
            collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)//设置边距
            collectionViewLayout.minimumLineSpacing = 10.0 //每个相邻的layout的上下间隔
            let rect = CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: APP_SCREEN_HEIGHT)
            collectionView = UICollectionView.init(frame: rect, collectionViewLayout: collectionViewLayout)
            collectionView?.backgroundColor = MNColors.bg4()
            collectionView?.register(MNTimelineCell.classForCoder(), forCellWithReuseIdentifier: reuseId)
            collectionView?.dataSource = self
            collectionView?.delegate = self
            self.view.addSubview(collectionView!)
        }
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
        
        return 20;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:MNTimelineCell  = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath as IndexPath) as! MNTimelineCell
        
        cell.backgroundColor = self.randomColor()
        
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row%2 == 0 ? CGSize(width: APP_SCREEN_WIDTH, height: 160) : CGSize(width: APP_SCREEN_WIDTH, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        MNNavigationController.init(rootViewController: MNEditorViewController()
        navigationController?.pushViewController(MNEditorViewController(), animated: true)
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
