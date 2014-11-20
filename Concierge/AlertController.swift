//
//  AlertController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/18/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class AlertController: UIViewController {
    
    private let cancelAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Cancel, handler: nil)
    var networkController = NetworkController.sharedInstance
    
    class var sharedInstance : AlertController {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : AlertController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = AlertController()
        }
        return Static.instance!
    }
    
    func phoneAndEmailNotValid() -> UIAlertController {
        let alertController = UIAlertController(title: "Attention", message: "Your phone number and/or email is not valid. Please type in valid information.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(self.cancelAction)
        return alertController
    }
    
    func fieldsLeftUnFilled() -> UIAlertController {
        let alertController = UIAlertController(title: "Attention", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(self.cancelAction)
        return alertController
    }
    
    func confirmationNotValid() -> UIAlertController {
        let alertController = UIAlertController(title: "Attention", message: "Confirmation code is incorrect", preferredStyle: UIAlertControllerStyle.Alert)
        let resendCode = UIAlertAction(title: "Resend Confirmation Code", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.networkController.POSTrequest(kPOSTRoutes.ResendConfirmation.rawValue, query: nil, dictionary: nil, completionFunction: { (postResponse, error) -> Void in
                if error != nil {
                    println(error!.description)
                }
                // Should get another confirmation code via SMS on phone.
            })
        }
        let tryAgainAction = UIAlertAction(title: "Try code again", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(resendCode)
        alertController.addAction(tryAgainAction)
        return alertController
    }
    
    func emailNotValid() -> UIAlertController {
        let alertController = UIAlertController(title: "Attention", message: "Your email is not valid. Please type in a valid email.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(self.cancelAction)
        return alertController
    }
    
    func notValidPassword() -> UIAlertController {
        let alertController = UIAlertController(title: "Attention", message: "Invalid password. Must be a minimum of 8 characters long, contain at least one uppercase letter, at least one lower case letter, and at least one number", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(self.cancelAction)
        return alertController
    }
    
}