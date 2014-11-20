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
    
    
    @IBAction func createJobButtonPressed(sender: UIButton) {
//        if self.date != nil && self.type != nil && self.location != nil {
//            var newJob = Job(type: self.type!, time: self.date!, location: self.location!, recurring: self.recurringBool)
            // POST Job info
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.datePicker.date)
        
//        self.view.backgroundColor = tColor1
    }
    

    
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
