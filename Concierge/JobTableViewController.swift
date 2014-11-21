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
    
    var tabbarcontroller = UITabBarController()
    var networkController = NetworkController.sharedInstance
    
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
            self.networkController.GETrequest(kPOSTRoutes.Concierge.rawValue, query: nil, completionFunction: { (info, error) -> Void in
                if error != nil {
                    println(error!.description)
                }
                else {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
