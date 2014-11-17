//
//  LogInViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    var tabbarController = UITabBarController()
    var viewControllerArray: Array<UIViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllersForTabBarController()
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        self.presentViewController(self.tabbarController, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewControllersForTabBarController() {
        let conciegreVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.ConciergeNavCrtl.rawValue) as UINavigationController
        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.ProfileVC.rawValue) as ProfileViewController
        let jobNavC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.JobNavCrtl.rawValue) as UINavigationController
        let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.SettingVC.rawValue) as SettingsViewController
        if true {
            self.viewControllerArray = [conciegreVC, profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
        else {
            self.viewControllerArray = [profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
    }
}
