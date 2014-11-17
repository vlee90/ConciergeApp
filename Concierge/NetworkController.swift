//
//  NetworkController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import Foundation

class NetworkController {
    class var sharedInstance : NetworkController {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : NetworkController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = NetworkController()
        }
        return Static.instance!
    }
}