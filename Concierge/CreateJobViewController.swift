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
    
    var date: NSDate?
    var type: String?
    var location: String?
    var recurringBool: Bool!
    var dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.datePicker.date)
        dateFormatter.set
        //        self.view.backgroundColor = tColor1
    }
    
    @IBAction func createJobButtonPressed(sender: UIButton) {
//        if self.date != nil {
//            var newJob = Job(time: self.date!, recurring: self.recurringBool)
//            //POST JOB
//        }
        println(self.datePicker.date)
        println(self.recurringSwitch.on)
    }
    
    
//    POST /jobs
//    (input JWT header and..)
//    {
//    "jobDate": "2014-12-12T01:32:21.196Z",
//    "recurring": "true"
//    }
//    "jobDate": "2014-11-22 05:00:13 +0000"

    

    
    func timeChanged(action: UIControlEvents) {
        println(self.datePicker.date)
    }
    
    func recurringSwitched(action: UIControlEvents) {
        println(self.recurringSwitch.on)
        
    }
//    @IBAction func recurringSwtiched(sender: UISwitch) {
//    }
//    @IBAction func weatherSwitched(sender: UISwitch) {
//    }
}
