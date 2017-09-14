//
//  MNNavigationController.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/29.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

class MNNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationBar.isTranslucent = false
//        self.navigationBar.backgroundColor = .clear
        UINavigationBar.appearance().tintColor = MNColors.bg1()
//        self.navigationBar.clipsToBounds = true

        let fakeNavi = UIView.init(frame: CGRect.init(x: 0, y: 0, width: APP_SCREEN_WIDTH, height: 64))
        fakeNavi.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.view.insertSubview(fakeNavi, belowSubview: self.navigationBar)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
