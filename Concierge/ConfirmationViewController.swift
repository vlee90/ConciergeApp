//
//  ConfirmationViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var confirmationTextField: UITextField!
    var tabbarController = UITabBarController()
    var viewControllerArray: Array<UIViewController>!
    var networkController = NetworkController.sharedInstance
    var alertController = AlertController.sharedInstance
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllersForTabBarController()
        self.view.backgroundColor = tColor1
        self.confirmationTextField.keyboardType = UIKeyboardType.NumberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func confirmButtonPressed(sender: UIButton) {
        let postDict = ["confirmationCode" : "\(self.confirmationTextField.text)"]
        self.networkController.POSTrequest(kPOSTRoutes.Confirm.rawValue, query: nil, dictionary: postDict) { (postResponse, error) -> Void in
            // POST Confirmation Check
            if error != nil {
                println(error?.description)
            }
            else {
                // ConfirmationCheck
                // PostResponse is the entire userObject
                self.setRemainingUserProperties(self.user!, postDictionary: postResponse)
                if self.user!.confirmed == true {
                    self.user!.confirmationCode = self.confirmationTextField.text
                    self.presentViewController(self.tabbarController, animated: true, completion: nil)
                }
                else {
                    let confirmationNotValidAlert = self.alertController.confirmationNotValid()
                    self.presentViewController(confirmationNotValidAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func setViewControllersForTabBarController() {
        let conciegreVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ConciergeNavCrtl.rawValue) as UINavigationController
        var profileVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ProfileVC.rawValue) as ProfileViewController
        let jobNavC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.JobNavCrtl.rawValue) as UINavigationController
        let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.SettingVC.rawValue) as SettingsViewController
            self.viewControllerArray = [jobNavC, profileVC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
    }
    
    func setRemainingUserProperties(user: User, postDictionary: NSDictionary) {
        user.id = postDictionary.valueForKey("_id") as? String
        user.confirmed = postDictionary.valueForKey("confirmed") as Bool
        user.jobs = postDictionary.valueForKey("jobs") as? Array
        user.conciergeJobs = postDictionary.valueForKey("conciergeJobs") as? Array
        
    }
}
