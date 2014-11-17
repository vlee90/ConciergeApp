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
        let conciegreVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.ConciergeVC.rawValue) as ConciergeViewController
        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.ProfileVC.rawValue) as ProfileViewController
        let jobNavC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.JobNavCrtl.rawValue) as UINavigationController
        let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.SettingVC.rawValue) as SettingsViewController
        
        if false {
            self.viewControllerArray = [conciegreVC, profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
        else {
            self.viewControllerArray = [profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
        
        
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        println("Login button pressed")
        self.presentViewController(self.tabbarController, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
