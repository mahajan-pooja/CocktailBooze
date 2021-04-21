import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFieldConfPassword: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var signUpUIView: UIView!
    @IBOutlet weak var passError: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var successMsg: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!

    @IBAction func btnCancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnSignUpAction(_ sender: Any) {
        guard let password = txtFieldPassword.text else { return print("Password Empty") }
        guard let email = txtFieldEmail.text else { return print("Email Empty") }
        let confPass = txtFieldConfPassword.text
        if confPass != password {
            passError.isHidden = false
        } else {
            passError.isHidden = true
            Auth.auth().createUser(withEmail: email, password: password) { authResult, _ in
                if (authResult?.user.email) != nil {
                    KeychainWrapper.standard.set(email, forKey: "user-email")
                    KeychainWrapper.standard.set(self.txtFieldName.text!, forKey: "user-name")

                    self.successMsg.isHidden = false
                    self.btnSignIn.isHidden = false
                    self.txtFieldName.text = ""
                    self.txtFieldPassword.text = ""
                    self.txtFieldConfPassword.text = ""
                    self.txtFieldEmail.text = ""
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        signUpUIView.layer.shadowColor = UIColor.red.cgColor
        signUpUIView.layer.shadowOpacity = 0.5
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
