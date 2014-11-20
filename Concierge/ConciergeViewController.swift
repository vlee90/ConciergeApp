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
    var networkController = NetworkController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.workButton.setTitle("Work", forState: UIControlState.Normal)
        
        self.view.backgroundColor = tColor1
        
    }
    
    @IBAction func workButtonPressed(sender: UIButton) {
        if self.workBool == false {
            self.networkController.POSTrequest(kPOSTRoutes.ConciergeAvailable.rawValue, query: nil, dictionary: nil, completionFunction: { (postResponse, error) -> Void in
                if error != nil {
                    println(error!.description)
                }
                else {
                    println(postResponse)
                    self.workButton.backgroundColor = UIColor.redColor()
                    self.workButton.setTitle("Stop", forState: UIControlState.Normal)
                    self.workButton.titleLabel?.backgroundColor = UIColor.redColor()
                    self.workBool = true
                }
            })
        } else {
            self.networkController.POSTrequest(kPOSTRoutes.ConciergeUnavailable.rawValue, query: nil, dictionary: nil, completionFunction: { (postResponse, error) -> Void in
                if error != nil {
                    println(error!.description)
                }
                else {
                    println(postResponse)
                    self.workButton.backgroundColor = UIColor.greenColor()
                    self.workButton.setTitle("Work", forState: UIControlState.Normal)
                    self.workButton.titleLabel?.backgroundColor = UIColor.greenColor()
                    self.workBool = false
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let toVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ConciergeDetailVC.rawValue) as ConciergeJobDetailViewController
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
}
