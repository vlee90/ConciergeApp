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
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var changeInformationButton: UIButton!
    @IBOutlet weak var switchConciergeStatusButton: UIButton!
    
    var validationController = ValidationController.sharedInstance
    var alertController = AlertController.sharedInstance
    var networkController = NetworkController.sharedInstance
    var storageController = StorageController.sharedInstance
    
    var changeMode: Bool = false
    var userConciergeMode: Bool = false
    var textFieldArray: [UITextField]!
    var viewControllerArray: [UIViewController]!
    var tabbarController = TabBarController.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.storageController.user != nil {
            self.populateTextFields(self.storageController.user!)
            self.userConciergeMode = self.storageController.user!.concierge
        }
        
        self.setTextFieldsEnabled(false)
        self.textFieldArray = [self.firstNameTextField, self.lastNameTextField, self.emailTextField, self.phoneNumberTextField]
        
        self.profileImageView.userInteractionEnabled = true
        let profileImagePress = UITapGestureRecognizer(target: self, action: "profileImagePressed:")
        self.profileImageView.addGestureRecognizer(profileImagePress)
        self.switchConciergeStatusButton.enabled = false
        
        self.view.backgroundColor = tColor1

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPasswordButtonPressed(sender: UIButton) {
        let postDict = ["username" : self.storageController.user!.username!]
        self.networkController.POSTrequest(kPOSTRoutes.ResetPassword.rawValue, query: nil, dictionary: postDict, completionFunction: { (postResponse, error) -> Void in
            if error != nil {
                println("Error: POST /passwordReset: \(error?.description)")
            }
            else {
                println(postResponse)
            }
        })
    }
    
    @IBAction func changeInformationButtonPressed(sender: UIButton) {
        if self.changeMode == false {
            self.changeInformationButton.backgroundColor = UIColor.redColor()
            self.changeInformationButton.setTitle("Save", forState: UIControlState.Normal)
            self.changeInformationButton.titleLabel?.backgroundColor = UIColor.redColor()
            self.setTextFieldsEnabled(true)
            self.switchConciergeStatusButton.enabled = true
            self.changeMode = true
        } else {
            if self.validationController.checkForCompletelyFilledOutTextFields(self.textFieldArray) == true {
                if self.validationController.validateEmail(self.emailTextField.text) == true && self.validationController.validatePhoneNumber(self.phoneNumberTextField.text) == true {
                    //PUT USERNAME PUT PHONE
                    let userNamePostDict = ["username" : self.emailTextField.text]
                    let phonePostDict = ["phone" : self.phoneNumberTextField.text]
                    self.networkController.PUTrequest(kPUTRoutes.ChangePhone.rawValue, query: nil, dictionary: phonePostDict, completionFunction: { (postResponse, error) -> Void in
                        if error != nil {
                            println("Error: PUT /changePhone: \(error?.description)")
                        }
                        else {
                            println("Save new phoneNumber success")
                            self.networkController.PUTrequest(kPUTRoutes.ChangeUsername.rawValue, query: nil, dictionary: userNamePostDict, completionFunction: { (postResponse, error) -> Void in
                                if error != nil {
                                    println("Error: PUT /changeUsername: \(error?.description)")
                                }
                                else {
                                    println("Save new username/email success")
                                    if self.userConciergeMode == true {
                                        self.networkController.POSTrequest(kPOSTRoutes.UserToConcierge.rawValue, query: nil, dictionary: nil, completionFunction: { (postResponse, error) -> Void in
                                            if error != nil {
                                                println("Error on userToConcierge: \(error?.description)")
                                            }
                                            else {
                                                self.storageController.user?.concierge = postResponse.objectForKey("concierge") as Bool
                                                self.storageController.user?.username = self.emailTextField.text
                                                self.storageController.user?.phone = self.phoneNumberTextField.text
                                                self.populateTextFields(self.storageController.user!)
                                                // Should move to Confirm view and reconfirm. Error occurs when this happens though
                                                //                                    self.presentViewController(ConfirmationViewController(), animated: true, completion: nil)
                                                self.changeInformationButton.backgroundColor = UIColor.greenColor()
                                                self.changeInformationButton.setTitle("Change Information", forState: UIControlState.Normal)
                                                self.changeInformationButton.titleLabel?.backgroundColor = UIColor.greenColor()
                                                self.setTextFieldsEnabled(false)
                                                self.switchConciergeStatusButton.enabled = false
                                                self.setViewControllersForTabBarController()
                                                self.changeMode = false
                                            }
                                        })
                                    }
                                    else {
                                        self.networkController.POSTrequest(kPOSTRoutes.ConciergeToUser.rawValue, query: nil, dictionary: nil, completionFunction: { (postResponse, error) -> Void in
                                            if error != nil {
                                                println("Error on userToConcierge: \(error?.description)")
                                            }
                                            else {
                                                self.storageController.user?.concierge = postResponse.objectForKey("concierge") as Bool
                                                self.storageController.user?.username = self.emailTextField.text
                                                self.storageController.user?.phone = self.phoneNumberTextField.text
                                                self.populateTextFields(self.storageController.user!)
                                                // Should move to Confirm view and reconfirm. Error occurs when this happens though
                                                //                                    self.presentViewController(ConfirmationViewController(), animated: true, completion: nil)
                                                self.changeInformationButton.backgroundColor = UIColor.greenColor()
                                                self.changeInformationButton.setTitle("Change Information", forState: UIControlState.Normal)
                                                self.changeInformationButton.titleLabel?.backgroundColor = UIColor.greenColor()
                                                self.setTextFieldsEnabled(false)
                                                self.switchConciergeStatusButton.enabled = false
                                                self.setViewControllersForTabBarController()
                                                self.changeMode = false
                                            }
                                        })
                                    }
                                }
                            })
                        }
                    })
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
    
    @IBAction func switchConciergeStatusButtonPressed (sender: UIButton) {
        if self.changeMode == true {
            self.switchConciergeStatusButton.enabled = true
            if self.userConciergeMode == true {
                self.switchConciergeStatusButton.setTitle("Client", forState: UIControlState.Normal)
                self.userConciergeMode = false
            }
            else {
                self.switchConciergeStatusButton.setTitle("Concierge", forState: UIControlState.Normal)
                self.userConciergeMode = true
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
//        self.firstNameTextField.enabled = enabled
//        self.lastNameTextField.enabled = enabled
        self.phoneNumberTextField.enabled = enabled
        self.emailTextField.enabled = enabled
    }
    
    
    func setViewControllersForTabBarController() {
        let conciegreVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ConciergeNavCrtl.rawValue) as UINavigationController
        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.ProfileVC.rawValue) as ProfileViewController
        let jobNavC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.JobNavCrtl.rawValue) as UINavigationController
        let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier(kViewControllerIdenifiers.SettingVC.rawValue) as SettingsViewController
        if self.userConciergeMode == true {
            self.viewControllerArray = [conciegreVC, profileVC, jobNavC, settingVC]
            self.tabbarController.selectedIndex = 1
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
        else {
            self.viewControllerArray = [profileVC, jobNavC, settingVC]
            self.tabbarController.selectedIndex = 0
            self.tabbarController.setViewControllers(self.viewControllerArray, animated: true)
        }
    }
    
    func populateTextFields(user: User) {
        self.firstNameTextField.text = user.first!
        self.lastNameTextField.text = user.last!
        self.phoneNumberTextField.text = user.phone!
        self.emailTextField.text = user.username!
        if self.storageController.user?.concierge == true {
            self.switchConciergeStatusButton.setTitle("Concierge", forState: UIControlState.Normal)
        }
        else {
            self.switchConciergeStatusButton.setTitle("Client", forState: UIControlState.Normal)
        }
        
    }
}
