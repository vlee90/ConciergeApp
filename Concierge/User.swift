//
//  User.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class User {
    var username: String!
    var password: String!
    var phone: String!
    var first: String!
    var last: String!
    var profileImage: UIImage?
    
    var concierge: Bool = false
    var confirmed: Bool = false
    var jwtToken: String?
    var jobArray: Array<Job>?
    
    init(username: String, password: String, phone: String, first: String, last: String, jwtToken: String) {
        self.username = username
        self.password = password
        self.phone = phone
        self.first = first
        self.last = last
        self.jwtToken = jwtToken
    }
}