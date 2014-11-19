//
//  ProfileViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/16/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, ImageDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var changeInformationButton: UIButton!
    
    var validationController = ValidationController.sharedInstance
    var alertController = AlertController.sharedInstance
    
    var changeMode: Bool = false
    var textFieldArray: [UITextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTextFieldsEnabled(false)
        self.passwordTextField.secureTextEntry = true
        self.textFieldArray = [self.firstNameTextField, self.lastNameTextField, self.emailTextField, self.phoneNumberTextField, self.passwordTextField]
        
        self.profileImageView.userInteractionEnabled = true
        let profileImagePress = UITapGestureRecognizer(target: self, action: "profileImagePressed:")
        self.profileImageView.addGestureRecognizer(profileImagePress)
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeInformationButtonPressed(sender: UIButton) {
        if self.changeMode == false {
            self.changeInformationButton.backgroundColor = UIColor.redColor()
            self.changeInformationButton.setTitle("Save", forState: UIControlState.Normal)
            self.changeInformationButton.titleLabel?.backgroundColor = UIColor.redColor()
            self.setTextFieldsEnabled(true)
            self.profileImageView.highlighted = true
            self.changeMode = true
        } else {
            //POST Save
            if self.validationController.checkForCompletelyFilledOutTextFields(self.textFieldArray) == true {
                if self.validationController.validateEmail(self.emailTextField.text) == true && self.validationController.validatePhoneNumber(self.phoneNumberTextField.text) == true {
                    self.changeInformationButton.backgroundColor = UIColor.greenColor()
                    self.changeInformationButton.setTitle("Change Information", forState: UIControlState.Normal)
                    self.changeInformationButton.titleLabel?.backgroundColor = UIColor.greenColor()
                    self.setTextFieldsEnabled(false)
                    self.profileImageView.highlighted = false
                    self.changeMode = false
                }
                else {
                    let invalidEmailAlert = self.alertController.phoneAndEmailNotValid()
                    self.presentViewController(invalidEmailAlert, animated: true, completion: nil)
                }
            }
            else {
                let unfilledFieldsAlert = self.alertController.fieldsLeftUnFilled()
                self.presentViewController(unfilledFieldsAlert, animated: true, completion: nil)
            }
        }
    }
    
    func profileImagePressed(gesture: UIGestureRecognizer) {
        if self.changeMode == true {
            let toVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.GalleryVC.rawValue) as PhotoFrameworkViewController
            toVC.imageDelegate = self
            self.presentViewController(toVC, animated: true, completion: nil)
        }
    }
    
    func transferImage(image: UIImage) {
        self.profileImageView.image = image
        //POST IMAGE
    }
    
    func setTextFieldsEnabled(enabled: Bool) {
        self.firstNameTextField.enabled = enabled
        self.lastNameTextField.enabled = enabled
        self.phoneNumberTextField.enabled = enabled
        self.emailTextField.enabled = enabled
        self.passwordTextField.enabled = enabled
    }
}
