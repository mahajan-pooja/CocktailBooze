import UIKit
import Firebase
import SwiftKeychainWrapper

class AccountViewController: UIViewController {
    @IBOutlet weak var btnWineHub: UIButton!
    @IBOutlet weak var btnBeerHub: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnMyFavorites: UIButton!

    @IBAction func btnSignoutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.set("", forKey: "userEmail")
            if let signInViewController = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
                signInViewController.modalPresentationStyle = .fullScreen
                self.present(signInViewController, animated: true, completion: nil)
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        Common.setButtonShadow(button: btnMyFavorites)
        Common.setButtonShadow(button: btnBeerHub)
        Common.setButtonShadow(button: btnWineHub)
        Common.setButtonShadow(button: btnSignOut)

        lblName.text = KeychainWrapper.standard.string(forKey: "user-name")
        lblEmail.text = KeychainWrapper.standard.string(forKey: "user-email")
    }
}
