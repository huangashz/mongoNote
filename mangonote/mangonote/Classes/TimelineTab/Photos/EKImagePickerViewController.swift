//
//  EKImagePickerViewController.swift
//  notedemo
//
//  Created by HuangZhen on 2017/8/23.
//  Copyright © 2017年 HuangZhen. All rights reserved.
//

import UIKit

let cellSpace = CGFloat(5)
let countInRow = CGFloat(4)
let statusBarHeight = CGFloat(20)
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

let EKPhotoReuseIdentifier = "EKPhotoCell"

class EKImagePickerViewController: MNBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: EKImagePcikerDelegate?
    
    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView?
    var pickerContext :EKImagePickerContext?
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = MNColors.bg1()
        let backButtonItem = UIBarButtonItem.init(title: "取消", style: .done, target: self, action: #selector(dismissController))
        self.navigationItem.rightBarButtonItem = backButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        pickerContext = EKImagePickerContext.init(helper: EKImagePickerHelper())
        setUpLayout()
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: statusBarHeight, width: screenWidth, height: screenHeight - statusBarHeight), collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        collectionView!.register(EKSmallPhotoCell.self, forCellWithReuseIdentifier: EKPhotoReuseIdentifier)
        // Do any additional setup after loading the view.
        view.addSubview(collectionView!)
    }
    

    func setUpLayout() {
        let cellWidth = (screenWidth - cellSpace * (countInRow + 1))/countInRow
        layout.sectionInset = UIEdgeInsetsMake(cellSpace, cellSpace, cellSpace, cellSpace);
        layout.minimumLineSpacing = cellSpace
        layout.minimumInteritemSpacing = cellSpace
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize.init(width: cellWidth, height: cellWidth)
    }
    
    func dismissController() {
        self.dismiss(animated: true) {
            self.delegate?.imagePickerDidFinished(photos: [])
        }
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = pickerContext?.getPikcerImagesNumber(ablumIndex: section) else {
            return 0
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.pickerContext?.getPhotoCell(collectionView, ablumIndex: indexPath.section, cellForItemAtIndexPath: indexPath) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: EKPhotoReuseIdentifier, for: indexPath)
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = (screenWidth - 5*(countInRow - 1))/countInRow
//        return layout.itemSize = CGSize.init(width: cellWidth, height: cellWidth)
//    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
