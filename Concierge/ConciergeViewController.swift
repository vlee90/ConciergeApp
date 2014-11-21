//
//  ConciergeViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class ConciergeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var workButton: UIButton!
    var workBool: Bool = false
    var timer: NSTimer!
    var networkController = NetworkController.sharedInstance
    var storageController = StorageController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.workButton.setTitle("Work", forState: UIControlState.Normal)
        
        self.view.backgroundColor = tColor1
        
    }
    
    func lookForJob() {
        println("Fired look for Job function")
        self.networkController.GETrequest(kGETRoutes.ConciergeJobs.rawValue, query: nil) { (info, error) -> Void in
            if error != nil {
                println("Error in GET: /conciergeJobs: \(error?.description)")
            }
            else {
                let jobsArray = info.objectForKey("conciergeJobs") as NSArray
                self.storageController.user.conciergeJobs = jobsArray
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func workButtonPressed(sender: UIButton) {
        if self.workBool == false {
            self.networkController.POSTrequest(kPOSTRoutes.ConciergeAvailable.rawValue, query: nil, dictionary: nil, completionFunction: { (postResponse, error) -> Void in
                if error != nil {
                    println(error!.description)
                }
                else {
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "lookForJob", userInfo: nil, repeats: true)
                    self.workButton.backgroundColor = UIColor.redColor()
                    self.workButton.setTitle("Stop", forState: UIControlState.Normal)
                    self.workButton.titleLabel?.backgroundColor = UIColor.redColor()
                    self.workBool = postResponse.objectForKey("conciergeAvailable") as Bool
                }
            })
        } else {
            self.networkController.POSTrequest(kPOSTRoutes.ConciergeUnavailable.rawValue, query: nil, dictionary: nil, completionFunction: { (postResponse, error) -> Void in
                if error != nil {
                    println(error!.description)
                }
                else {
                    self.timer.invalidate()
                    self.workButton.backgroundColor = UIColor.greenColor()
                    self.workButton.setTitle("Work", forState: UIControlState.Normal)
                    self.workButton.titleLabel?.backgroundColor = UIColor.greenColor()
                    self.workBool = postResponse.objectForKey("conciergeAvailable") as Bool
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let toVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ConciergeDetailVC.rawValue) as ConciergeJobDetailViewController
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.storageController.user.conciergeJobs != nil {
            return self.storageController.user.conciergeJobs!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
}
