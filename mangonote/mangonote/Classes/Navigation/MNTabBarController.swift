//
//  MNTabBarController.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/29.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

class MNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllChildVC()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAllChildVC() {
        let timelineVC = MNTimelineViewController()
        timelineVC.navigationItem.title = "Timeline"
        let timelineNavi : MNNavigationController = MNNavigationController.init(rootViewController:timelineVC)
        timelineNavi.tabBarItem.title = "Timeline"
        self.viewControllers = [timelineNavi]
        
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
