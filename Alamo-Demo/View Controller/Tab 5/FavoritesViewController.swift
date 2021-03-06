//
//  FavoritesViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 8/27/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblViewFavorites: UITableView!
    var favoritesArray: [String] = []
    var ref: DocumentReference!

    @objc func btnRemoveFavoritesAction(sender: UIButton) {
        let data = favoritesArray[sender.tag]

        let user = Auth.auth().currentUser
        var email: String!

        if let user = user {
            email = user.email
        } else {
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }
        ref = Firestore.firestore().collection("RecipeCollection").document(email)

        ref.updateData([
            "regions": FieldValue.arrayRemove([data])
        ])
        getFavorites()
        self.tblViewFavorites.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 223.0/255.0, blue: 113.0/255.0, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }

    func getFavorites() {
        Firestore.firestore().collection("RecipeCollection").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.favoritesArray = document.data()["regions"]! as! [String]
                }
                self.tblViewFavorites.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath)
        
        if let favoritesTableViewCell = cell as? FavoritesTableViewCell {
            favoritesTableViewCell.lblFavoriteName.text = favoritesArray[indexPath.row]
            favoritesTableViewCell.btnRemoveFevorites.tag = indexPath.row
            favoritesTableViewCell.btnRemoveFevorites.addTarget(self, action: #selector(btnRemoveFavoritesAction(sender:)), for: .touchUpInside)
            favoritesTableViewCell.containerUIView.layer.shadowColor = UIColor.red.cgColor
            favoritesTableViewCell.containerUIView.layer.shadowOpacity = 0.5
            favoritesTableViewCell.containerUIView.layer.shadowOffset = CGSize.zero
            favoritesTableViewCell.containerUIView.layer.shadowRadius = 1.5
            favoritesTableViewCell.containerUIView.layer.cornerRadius = favoritesTableViewCell.containerUIView.frame.height / 15

            return cell
        }
        return UITableViewCell()
    }
}
