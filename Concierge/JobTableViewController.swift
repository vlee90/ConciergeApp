//
//  JobTableViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class JobTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var tabbarcontroller = TabBarController.sharedInstance
    var networkController = NetworkController.sharedInstance
    var storageController = StorageController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.backgroundColor = tColor1
    }
    
    
    override func viewDidAppear(animated: Bool) {
        // Used so profileView doesn't continuatelly reload itself.
        if self.networkController.numberOfJWTChecks == 0 {
            self.checkForJWT()
        }
    }
    
    
    func checkForJWT() {
        self.networkController.numberOfJWTChecks++
        //  Checks if token is saved in user default
        if let token = NSUserDefaults.standardUserDefaults().valueForKey(kTokenKey) as? String {
            //  TRUE: Check if token matches token in database.
            self.networkController.token = token
            self.networkController.GETrequest(kGETRoutes.UserInfo.rawValue, query: nil, completionFunction: { (info, error) -> Void in
                if error != nil {
                    println(error!.description)
                }
                else {
                    self.storageController.user = User()
                    self.populateUserInformation(self.storageController.user!, info: info)
                    self.storageController.user?.jwtToken = token
                    self.storageController.user = self.storageController.user!
                    let conciegreVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ConciergeNavCrtl.rawValue) as UINavigationController
                    var profileVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ProfileVC.rawValue) as ProfileViewController
                    let jobNavC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.JobNavCrtl.rawValue) as UINavigationController
                    let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.SettingVC.rawValue) as SettingsViewController
                    var concierge = info.objectForKey("concierge") as Bool
                    if concierge == true {
                        let viewControllerArray = [jobNavC, profileVC, conciegreVC, settingVC]
                        self.tabbarcontroller.setViewControllers(viewControllerArray, animated: false)
                        self.presentViewController(self.tabbarcontroller, animated: false, completion: nil)
                    }
                    else {
                        let viewControllerArray = [jobNavC, profileVC, settingVC]
                        self.tabbarcontroller
                            .setViewControllers(viewControllerArray, animated: false)
                        self.presentViewController(self.tabbarcontroller, animated: false, completion: nil)
                    }
                }
            })
        }
        else {
            let signUpVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.SignUpVC.rawValue) as SignUpViewController
            signUpVC.modalInPopover = true
            self.presentViewController(signUpVC, animated: true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel.text = "TEST Job"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let toVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.JobDetailVC.rawValue) as JobDetailViewController
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    func populateUserInformation(user: User, info: NSDictionary) {
        user.id = info.objectForKey("_id") as? String
        user.confirmationCode = info.objectForKey("confirmationCode") as? String
        user.username = info.objectForKey("username") as? String
        user.phone = info.objectForKey("phone") as? String
        user.confirmed = info.objectForKey("confirmed") as Bool
        user.concierge = info.objectForKey("concierge") as Bool
        user.jobs = info.objectForKey("jobs") as? Array
        user.conciergeJobs = info.objectForKey("conciergeJobs") as? Array
        let nameDict = info.objectForKey("name") as NSDictionary
        user.first = nameDict.objectForKey("first") as? String
        user.last = nameDict.objectForKey("last") as? String
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
