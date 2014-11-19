//
//  LogInViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var tabbarController = UITabBarController()
    var viewControllerArray: Array<UIViewController>!
    
    var networkController = NetworkController.sharedInstance
    var alertController = AlertController.sharedInstance
    var validationController = ValidationController.sharedInstance
    
    var textFieldArray: [UITextField]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllersForTabBarController()
        self.setUpKeyboard()
        self.textFieldArray = [self.emailTextField, self.passwordTextField]
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        if self.validationController.checkForCompletelyFilledOutTextFields(self.textFieldArray!) == true {
            if self.validationController.validateEmail(self.emailTextField.text) == true {
                // POST Login information
                self.presentViewController(self.tabbarController, animated: true, completion: nil)
            }
            else {
                let emailNotValidAlert = self.alertController.emailNotValid()
                self.presentViewController(emailNotValidAlert, animated: true, completion: nil)
            }
        }
        else {
            let unfilledFieldsAlert = self.alertController.fieldsLeftUnFilled()
            self.presentViewController(unfilledFieldsAlert, animated: true, completion: nil)
        }
    }

    
    func setViewControllersForTabBarController() {
        let conciegreVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ConciergeNavCrtl.rawValue) as UINavigationController
        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ProfileVC.rawValue) as ProfileViewController
        let jobNavC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.JobNavCrtl.rawValue) as UINavigationController
        let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.SettingVC.rawValue) as SettingsViewController
        if true {
            self.viewControllerArray = [conciegreVC, profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
        else {
            self.viewControllerArray = [profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.delegate = self
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func setUpKeyboard() {
        self.passwordTextField.keyboardType = UIKeyboardType.Default
        self.emailTextField.keyboardType = UIKeyboardType.EmailAddress
        
        self.passwordTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        self.emailTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        
        self.passwordTextField.autocorrectionType = UITextAutocorrectionType.No
        self.emailTextField.autocorrectionType = UITextAutocorrectionType.No
        
        self.passwordTextField.secureTextEntry = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
