//
//  AccountViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/3/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class AccountViewController: UIViewController {
    var ref: DocumentReference!
    
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
            let SignInViewController: SignInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            SignInViewController.modalPresentationStyle = .fullScreen
            self.present(SignInViewController, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
//        let docRef = Firestore.firestore().collection("RecipeCollection").document("rum")
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
//        Firestore.firestore().collection("RecipeCollection").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }

        
//        let user = Auth.auth().currentUser
//        if let user = user {
////            let uid = user.uid
//            let email = user.email
//            lblEmail.text = email
//        }
       // retrieveFromJsonFile()
    }
    
//    func retrieveFromJsonFile() {
//        // Get the url of Persons.json in document directory
//        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//        let fileUrl = documentsDirectoryUrl.appendingPathComponent("Recipes.json")
//        
//        // Read data from .json file and transform data into an array
//        do {
//            let data = try Data(contentsOf: fileUrl, options: [])
//            guard let recipeArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return }
//            print("recipe - \(recipeArray)")
//        } catch {
//            print(error)
//        }
//    }
}
