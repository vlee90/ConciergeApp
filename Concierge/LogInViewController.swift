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
    
    var networkController = NetworkController()
    var alertController = AlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllersForTabBarController()
        self.setUpKeyboard()
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        if self.checkForFilledOutFields() == true {
            if self.validateEmail(self.emailTextField.text) == true {
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
        let conciegreVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.ConciergeNavCrtl.rawValue) as UINavigationController
        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.ProfileVC.rawValue) as ProfileViewController
        let jobNavC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.JobNavCrtl.rawValue) as UINavigationController
        let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.SettingVC.rawValue) as SettingsViewController
        if true {
            self.viewControllerArray = [conciegreVC, profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
        else {
            self.viewControllerArray = [profileVC, jobNavC, settingVC]
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
    }
    
    func checkForFilledOutFields() -> Bool{
        if self.emailTextField.text != "" && self.passwordTextField.text != "" {
            return true
        }
        else {
            return false
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
    
    func validateEmail(email: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        var emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result = emailTest!.evaluateWithObject(email)
        return result
    }
    
    
}
