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
    
    
    
    @IBAction func createJobButtonPressed(sender: UIButton) {
        // POST Job info
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.datePicker.date)
        datePicker.addTarget(self, action: "timeChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.recurringSwitch.addTarget(self, action: "recurringSwitched:", forControlEvents: UIControlEvents.ValueChanged)
    }
    

    
    func timeChanged(action: UIControlEvents) {
        println(self.datePicker.date)
    }
    
    func recurringSwitched(action: UIControlEvents) {
        println(self.recurringSwitch.on)
    }
}
