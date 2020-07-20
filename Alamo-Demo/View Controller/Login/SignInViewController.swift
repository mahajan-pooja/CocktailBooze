//
//  SignInViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/28/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import LocalAuthentication

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var signInUIView: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func faceIdAuthAction(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return print(error)
        }
        
        let reason = "Face ID authentication"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthorized, error in
            guard isAuthorized == true else {
                return print(error)
            }
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let secondViewController: TabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                secondViewController.modalPresentationStyle = .fullScreen
                self.present(secondViewController, animated: true, completion: nil)
            }
            
        }
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
    
    @IBAction func btnSignInAction(_ sender: Any) {
        let email = txtFieldEmail.text!
        let password = txtFieldPassword.text!
        
        if(email != "" && password != ""){
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                self!.lblError.isHidden = true
                KeychainWrapper.standard.set(email, forKey: "user-email")
                UserDefaults.standard.set(email, forKey: "userEmail")
                
                let secondViewController: TabBarController = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                secondViewController.modalPresentationStyle = .fullScreen
                self?.present(secondViewController, animated: true, completion: nil)
            }
        }else{
            lblError.isHidden = false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillLayoutSubviews() {
        signInUIView.layer.shadowColor = UIColor.red.cgColor
        signInUIView.layer.shadowOpacity = 0.5
        signInUIView.layer.shadowOffset = CGSize.zero
        signInUIView.layer.shadowRadius = 3
        signInUIView.layer.cornerRadius = 20
        
        btnSignIn.layer.shadowColor = UIColor.gray.cgColor
        btnSignIn.layer.shadowOpacity = 0.5
        btnSignIn.layer.shadowOffset = CGSize.zero
        btnSignIn.layer.shadowRadius = 3
        btnSignIn.layer.cornerRadius = 20
    }
}
