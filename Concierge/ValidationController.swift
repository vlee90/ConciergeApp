//
//  ValidationController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/18/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class ValidationController {
    
    class var sharedInstance : ValidationController {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : ValidationController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ValidationController()
        }
        return Static.instance!
    }
    
    
    func validateEmail(email: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        var emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result = emailTest!.evaluateWithObject(email)
        return result
    }
    
    func validatePhoneNumber(number: String) -> Bool {
        let phoneNumberRegex = "\\d{10}"
        var phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let result = phoneNumberTest!.evaluateWithObject(number)
        return result
    }
    
    func checkForCompletelyFilledOutTextFields(textFields: [UITextField]) -> Bool{
        var emptyCount = 0
        for textField in textFields {
            if textField.text == "" {
                emptyCount++
            }
        }
        if emptyCount == 0 {
            return true
        }
        else {
            return false
        }
    }
}
