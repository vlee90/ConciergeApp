//
//  SignUpViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/16/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signUpTableView: UITableView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
    }
    @IBAction func loginButtonPressed(sender: UIButton) {
    }
}
