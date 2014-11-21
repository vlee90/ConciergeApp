//
//  TabBarController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/20/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{
    
    
    class var sharedInstance : TabBarController {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : TabBarController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TabBarController()
        }
        return Static.instance!
    }
    
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        println("TabBarControllerClassWorks")
        return true
    }
}
