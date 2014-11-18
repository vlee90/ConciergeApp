//
//  ProfileViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/16/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var changeInformationButton: UIButton!
    var changeMode: Bool = false
    
    
    @IBAction func changeInformationButtonPressed(sender: UIButton) {
        if self.changeMode == false {
            self.changeInformationButton.backgroundColor = UIColor.redColor()
            self.changeInformationButton.setTitle("Save", forState: UIControlState.Normal)
            self.changeInformationButton.titleLabel?.backgroundColor = UIColor.redColor()
            self.setTextFieldsEnabled(true)
            self.changeMode = true
        } else {
            self.changeInformationButton.backgroundColor = UIColor.greenColor()
            self.changeInformationButton.setTitle("Change Information", forState: UIControlState.Normal)
            self.changeInformationButton.titleLabel?.backgroundColor = UIColor.greenColor()
            self.setTextFieldsEnabled(false)
            self.changeMode = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTextFieldsEnabled(false)
        self.passwordTextField.secureTextEntry = true

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTextFieldsEnabled(enabled: Bool) {
        self.firstNameTextField.enabled = enabled
        self.lastNameTextField.enabled = enabled
        self.phoneNumberTextField.enabled = enabled
        self.emailTextField.enabled = enabled
        self.passwordTextField.enabled = enabled
    }
}
