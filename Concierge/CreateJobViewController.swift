//
//  CreateJobViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/18/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class CreateJobViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var recurringSwitch: UISwitch!
    @IBOutlet weak var createJobButton: UIButton!
    @IBOutlet weak var weatherSwitch: UISwitch!
    
    @IBOutlet weak var wakeUpLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var recurringLabel: UILabel!
    
    
    let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    var storageController = StorageController.sharedInstance
    var networkController = NetworkController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.datePicker.date)
        self.storageController.dateFormatter.dateFormat = self.dateFormat
        self.storageController.dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
//                self.view.backgroundColor = tColor1
    }
    
    @IBAction func createJobButtonPressed(sender: UIButton) {
        if self.datePicker?.date != nil {
            //POST JOB
            println(self.datePicker?.date)
            let selectedDate = self.datePicker.date
            let formatedDate = self.storageController.dateFormatter.stringFromDate(selectedDate)
            println(formatedDate)
            let postDict = ["jobDate" : "\(formatedDate)", "recurring" : self.recurringSwitch.on]
            self.networkController.POSTrequest(kPOSTRoutes.Jobs.rawValue, query: nil, dictionary: postDict, completionFunction: { (postResponse, error) -> Void in
                if error != nil {
                    println("createJobButtonPressed Error: \(error?.description)")
                }
                else {
                    var newJob = Job()
                    self.populateJobProperties(newJob, info: postResponse)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
        }

    }
    
    func populateJobProperties(newJob: Job, info: NSDictionary) {
        let responseDate = info.objectForKey("jobDate") as String
        let responseID = info.objectForKey("_id") as String
        let responseOptions = info.objectForKey("optionsList") as NSArray
        let responseParent = info.objectForKey("parent") as String
        let responseRecurring = info.objectForKey("recurring") as Bool
        let responseParentNumber = info.objectForKey("parentNumber") as String
        let responseNameDict = info.objectForKey("parentName") as NSDictionary
        let responseFirst = responseNameDict.objectForKey("first") as String
        let responseLast = responseNameDict.objectForKey("last") as String
        var newJob = Job(jobDate: responseDate, recurring: responseRecurring)
        newJob._id = responseID
        newJob.optionsList = responseOptions
        newJob.parent = responseParent
        newJob.parentNumber = responseParentNumber
        newJob.first = responseFirst
        newJob.last = responseLast
    }
}
