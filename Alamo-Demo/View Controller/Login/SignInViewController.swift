//
//  SignInViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/28/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var signInUIView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SignUpViewController: SignUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        SignUpViewController.modalPresentationStyle = .fullScreen
        self.present(SignUpViewController, animated: true, completion: nil)
    }
    @IBAction func btnForgotAction(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Password Reset", message: "Enter registered Email Id to get password reset link.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            // textField.text = "Some default text"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let email = textField!.text
            Auth.auth().sendPasswordReset(withEmail: email!) { error in
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var btnSignIn: UIButton!
    @IBAction func btnSignInAction(_ sender: Any) {
        var email = txtFieldEmail.text!
        var password = txtFieldPassword.text!
        
         email = "pooja@test.com"
         password = "Abc123"
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            KeychainWrapper.standard.set(email, forKey: "user-email")
            UserDefaults.standard.set(email, forKey: "userEmail")
            
            let secondViewController: TabBarController = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            secondViewController.modalPresentationStyle = .fullScreen
            self?.present(secondViewController, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
