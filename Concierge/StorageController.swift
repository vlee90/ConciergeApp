//
//  StorageController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/20/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class StorageController {
    
    var user = User()
    var dateFormatter = NSDateFormatter()
    
    class var sharedInstance : StorageController {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : StorageController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = StorageController()
        }
        return Static.instance!
    }
    
    
}
