//
//  MNBaseViewController.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/30.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

class MNBaseViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view.backgroundColor = MNColors.bg1()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = MNColors.bg1()
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = "返回"
        self.navigationItem.backBarButtonItem = backButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
