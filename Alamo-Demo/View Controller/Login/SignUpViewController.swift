//
//  SignUpViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/28/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtFieldConfPassword: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var signUpUIView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
    }
    
    @IBOutlet weak var btnSignUp: UIButton!
   
    override func viewWillLayoutSubviews() {
        signUpUIView.layer.shadowColor = UIColor.gray.cgColor
        signUpUIView.layer.shadowOpacity = 1
        signUpUIView.layer.shadowOffset = CGSize.zero
        signUpUIView.layer.shadowRadius = 5
        signUpUIView.layer.cornerRadius = 20
        
        btnSignUp.layer.shadowColor = UIColor.gray.cgColor
        btnSignUp.layer.shadowOpacity = 1
        btnSignUp.layer.shadowOffset = CGSize.zero
        btnSignUp.layer.shadowRadius = 5
        btnSignUp.layer.cornerRadius = 20
    }

}
