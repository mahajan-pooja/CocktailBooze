//
//  AccountViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/3/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth
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
            let signInViewController: SignInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            signInViewController.modalPresentationStyle = .fullScreen
            self.present(signInViewController, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        btnSignOut.layer.shadowColor = UIColor.gray.cgColor
        btnSignOut.layer.shadowOpacity = 0.5
        btnSignOut.layer.shadowOffset = CGSize.zero
        btnSignOut.layer.shadowRadius = 5
        btnSignOut.layer.cornerRadius = btnSignOut.frame.height/2

        btnMyFavorites.layer.shadowColor = UIColor.gray.cgColor
        btnMyFavorites.layer.shadowOpacity = 0.5
        btnMyFavorites.layer.shadowOffset = CGSize.zero
        btnMyFavorites.layer.shadowRadius = 5
        btnMyFavorites.layer.cornerRadius = btnMyFavorites.frame.height/2

        btnWineHub.layer.shadowColor = UIColor.gray.cgColor
        btnWineHub.layer.shadowOpacity = 0.5
        btnWineHub.layer.shadowOffset = CGSize.zero
        btnWineHub.layer.shadowRadius = 5
        btnWineHub.layer.cornerRadius = btnWineHub.frame.height/2

        btnBeerHub.layer.shadowColor = UIColor.gray.cgColor
        btnBeerHub.layer.shadowOpacity = 0.5
        btnBeerHub.layer.shadowOffset = CGSize.zero
        btnBeerHub.layer.shadowRadius = 5
        btnBeerHub.layer.cornerRadius = btnBeerHub.frame.height/2

        lblName.text = KeychainWrapper.standard.string(forKey: "user-name")
        lblEmail.text = KeychainWrapper.standard.string(forKey: "user-email")
    }
}
