//
//  SignInViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/28/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var signInUIView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBOutlet weak var btnSignIn: UIButton!
    @IBAction func btnSignInAction(_ sender: Any) {
    }
    
    override func viewWillLayoutSubviews() {
        signInUIView.layer.shadowColor = UIColor.gray.cgColor
        signInUIView.layer.shadowOpacity = 1
        signInUIView.layer.shadowOffset = CGSize.zero
        signInUIView.layer.shadowRadius = 5
        signInUIView.layer.cornerRadius = 20
        
        btnSignIn.layer.shadowColor = UIColor.gray.cgColor
        btnSignIn.layer.shadowOpacity = 1
        btnSignIn.layer.shadowOffset = CGSize.zero
        btnSignIn.layer.shadowRadius = 5
        btnSignIn.layer.cornerRadius = 20
    }

}
