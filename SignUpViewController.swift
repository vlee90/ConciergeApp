//
//  SignUpViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/16/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var passwordImageView: UIImageView!
    
    var networkController = NetworkController.sharedInstance
    var alertController = AlertController.sharedInstance
    var validationController = ValidationController.sharedInstance
    
    var textFieldArray: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpKeyboard()
        self.textFieldArray = [self.phoneNumberTextField, self.emailTextField, self.passwordTextField, self.firstNameTextField, self.lastNameTextField]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
        // Tier 1: Checks if all fields are filled out.
        if self.validationController.checkForCompletelyFilledOutTextFields(self.textFieldArray) == false {
            let fieldsNotFilledAlert = self.alertController.fieldsLeftUnFilled()
            self.presentViewController(fieldsNotFilledAlert, animated: true, completion: nil)
        }
        else {
            // Tier 2: Checks if email and phone number are valid
            if self.validationController.validateEmail(self.emailTextField.text) == true && self.validationController.validatePhoneNumber(self.phoneNumberTextField.text) == true{
                var loginDictionary: NSMutableDictionary = [
                    "username" : self.emailTextField.text,
                    "password" : self.passwordTextField.text,
                    "phone" : self.phoneNumberTextField.text,
                    "name" : [
                        "first" : self.firstNameTextField.text,
                        "last" : self.lastNameTextField.text
                    ]
                ]
                println(loginDictionary)
                // POST User SignUp Info
                let toVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllerIdenifiers.ConfirmationVC.rawValue) as ConfirmationViewController
                self.presentViewController(toVC, animated: true, completion: nil)
            }
            else {
                let notValidAlert = self.alertController.phoneAndEmailNotValid()
                self.presentViewController(notValidAlert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func loginButtonPressed(sender: UIButton) {
        // Segue to Login-VC via storyboard.
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
        self.phoneNumberTextField.keyboardType = UIKeyboardType.PhonePad
        self.emailTextField.keyboardType = UIKeyboardType.EmailAddress
        self.passwordTextField.keyboardType = UIKeyboardType.Default
        self.passwordTextField.secureTextEntry = true
        self.firstNameTextField.keyboardType = UIKeyboardType.Default
        self.lastNameTextField.keyboardType = UIKeyboardType.Default
        
        self.passwordTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        self.lastNameTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        self.firstNameTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        self.emailTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        self.phoneNumberTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        
        self.firstNameTextField.autocorrectionType = UITextAutocorrectionType.No
        self.lastNameTextField.autocorrectionType = UITextAutocorrectionType.No
        self.emailTextField.autocorrectionType = UITextAutocorrectionType.No
        self.phoneNumberTextField.autocorrectionType = UITextAutocorrectionType.No
        self.passwordTextField.autocorrectionType = UITextAutocorrectionType.No
    }
}
