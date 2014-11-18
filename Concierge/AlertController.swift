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
    
    func signUpNotValidAlert() -> UIAlertController {
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
           //POST to text code again.
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
    
}