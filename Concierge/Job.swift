//
//  Job.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import Foundation

class Job {
    var type: String?
    var time: NSDate?
    var location: String?
    var recurring: Bool?
    
    init(type: String, time: NSDate, location: String, recurring: Bool) {
        self.type = type
        self.time = time
        self.location = location
        self.recurring = recurring
    }
}