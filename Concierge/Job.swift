//
//  Job.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import Foundation

class Job {
    var jobDate: String?
    var recurring: Bool?
    var _id: String?
    var parentNumber: String?
    var parent: String?
    var optionsList: NSArray?
    var first: String?
    var last: String?
    
    init() {
        
    }
    
    
    init(jobDate: String, recurring: Bool) {
        self.jobDate = jobDate
        self.recurring = recurring
    }
}