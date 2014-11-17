//
//  User.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class User {
    var name: String!
    var number: String!
    var email: String!
    var profileImage: UIImage?
    
    var concierge: Bool = false
    var confirmed: Bool = false
    var jwtToken: String?
    var timeZone: String?
    
    var jobArray: Array<Job>?
    
}