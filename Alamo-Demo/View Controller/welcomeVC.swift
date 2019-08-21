//
//  welcomeVC.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/25/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class welcomeVC: UIViewController {

    @IBOutlet weak var btnFaceID: UIButton!
    @IBAction func btnFaceIDAction(_ sender: Any) {
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
            print("success")
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let secondViewController: TabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                self.present(secondViewController, animated: true, completion: nil)
            }
            
        }
    }
    @IBOutlet weak var btnTouchID: UIButton!
    @IBOutlet weak var logoUIView: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentType = LAContext().biometricType
        if(currentType == .touchID){
            btnTouchID.isHidden = false
            btnFaceID.isHidden = true
        }else{
            btnTouchID.isHidden = true
            btnFaceID.isHidden = false
        }
        print("currentType - \(currentType)")
    }
    @IBAction func btnTouchIdAction(_ sender: Any) {
        // 1
        let context = LAContext()
        var error: NSError?
        
        // 2
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success, error) in
                    // 4
                    if success {
                        //self.showAlertController("Touch ID Authentication Succeeded")
                        DispatchQueue.main.async {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let secondViewController: TabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                            self.present(secondViewController, animated: true, completion: nil)
                        }
                    }
                    else {
                        self.showAlertController("Touch ID Authentication Failed")
                    }
            })
        }
            // 5
        else {
            showAlertController("Touch ID not available")
        }
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
    
    func showAlertController(_ message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillLayoutSubviews() {
        logoUIView.layer.shadowColor = UIColor.black.cgColor
        logoUIView.layer.shadowOpacity = 1
        logoUIView.layer.shadowOffset = CGSize.zero
        logoUIView.layer.shadowRadius = 10
        
        btnSignIn.layer.shadowColor = UIColor.black.cgColor
        btnSignIn.layer.shadowOpacity = 1
        btnSignIn.layer.shadowOffset = CGSize.zero
        btnSignIn.layer.shadowRadius = 10
        
        btnSignUp.layer.shadowColor = UIColor.black.cgColor
        btnSignUp.layer.shadowOpacity = 1
        btnSignUp.layer.shadowOffset = CGSize.zero
        btnSignUp.layer.shadowRadius = 10
    }
}
extension LAContext {
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }
    
    var biometricType: BiometricType {
        var error: NSError?
        
        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            // Capture these recoverable error thru Crashlytics
            return .none
        }
        
        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            }
        } else {
            return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
    }
}
