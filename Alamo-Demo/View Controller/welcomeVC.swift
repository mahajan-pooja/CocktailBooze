//
//  WelcomeVC.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/25/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class WelcomeVC: UIViewController {

    @IBOutlet weak var UIViewContainer: UIView!
    @IBOutlet weak var btnFaceID: UIButton!
    @IBOutlet weak var btnTouchID: UIButton!
    @IBOutlet weak var logoUIView: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBAction func btnSignUpAction(_ sender: Any) {
        let signUpViewController = Constants.storyBoard.instantiateViewController(withIdentifier: "SignUpViewController")
        if let signUpViewController = signUpViewController as? SignUpViewController {
            signUpViewController.modalPresentationStyle = .fullScreen
            self.present(signUpViewController, animated: true, completion: nil)
        }
    }

    @IBAction func btnSignInAction(_ sender: Any) {
        let signInViewController = Constants.storyBoard.instantiateViewController(withIdentifier: "SignInViewController")
        if let signInViewController = signInViewController as? SignInViewController {
            signInViewController.modalPresentationStyle = .fullScreen
            self.present(signInViewController, animated: true, completion: nil)
        }
    }
    
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
            DispatchQueue.main.async {
                let secondViewController: TabBarController = Constants.storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                self.present(secondViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentType = LAContext().biometricType
        if currentType == .touchID {
            btnTouchID.isHidden = false
            btnFaceID.isHidden = true
        } else {
            btnTouchID.isHidden = true
            btnFaceID.isHidden = false
        }

        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = UIViewContainer.frame.size
        gradientLayer.colors =
            [UIColor(red: 1, green: 0.8745, blue: 0.4431, alpha: 1.0).cgColor,UIColor(red: 1, green: 0.8745, blue: 0.4431, alpha: 1.0).cgColor]
        UIViewContainer.layer.insertSublayer(gradientLayer, at: 0)
        UIViewContainer.layer.cornerRadius = UIViewContainer.frame.height/20
    }

    @IBAction func btnTouchIdAction(_ sender: Any) {
        let context = LAContext()
        var error: NSError?

        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: { (success, error) in
                    if success {
                        //self.showAlertController("Touch ID Authentication Succeeded")
                        DispatchQueue.main.async {
                            let secondViewController = Constants.storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                            if let secondViewController = secondViewController as? TabBarController {
                                self.present(secondViewController, animated: true, completion: nil)
                            }
                        }
                    } else {
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
extension UIView {
    func addGradientLayer(with colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber] = [0.0, 1.0], frame: CGRect = CGRect.zero) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors

        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        gradientLayer.locations = locations
        gradientLayer.frame = frame

        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
