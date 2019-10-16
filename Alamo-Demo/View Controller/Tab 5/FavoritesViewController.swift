//
//  FavoritesViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 8/27/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tblViewFavorites: UITableView!
    var favoritesArray: [String] = []
    var ref: DocumentReference!
//    @IBAction func btnRemoveFavoritesAction(_ sender: Any) {
//
//        let user = Auth.auth().currentUser
//        var email:String!
//
//        if let user = user {
//            email = user.email
//            print("email - \(email!)")
//        }else{
//
//            email = KeychainWrapper.standard.string(forKey: "user-email")
//        }
//        //print("favorites => \(lblRecipeName.text) \(email)")
//        ref = Firestore.firestore().collection("RecipeCollection").document(email)
//
//
//
////        ref.updateData([
////            "regions": FieldValue.arrayRemove(["east_coast"])
////            ])
//
//
//
//    }
    
    @objc func btnRemoveFavoritesAction(sender: UIButton) {
        let data = favoritesArray[sender.tag]
        
        let user = Auth.auth().currentUser
        var email:String!
        
        if let user = user {
            email = user.email
            print("email - \(email!)")
        }else{
            
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }
        //print("favorites => \(lblRecipeName.text) \(email)")
        ref = Firestore.firestore().collection("RecipeCollection").document(email)
        
        ref.updateData([
            "regions": FieldValue.arrayRemove([data])
        ])
        getFavorites()
        self.tblViewFavorites.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        containerUIView.layer.shadowColor = UIColor.gray.cgColor
//        containerUIView.layer.shadowOpacity = 0.8
//        containerUIView.layer.shadowOffset = CGSize.zero
//        containerUIView.layer.shadowRadius = 2
//        containerUIView.layer.cornerRadius = containerUIView.frame.height/15
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 223.0/255.0, blue: 113.0/255.0, alpha: 1.0)

    }
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }
    func getFavorites(){
        //navigationController?.setNavigationBarHidden(true, animated: animated)
        let user = Auth.auth().currentUser
        
        //        var email:String!
        //        if let user = user {
        //            //let uid = user.uid
        //            email = user.email
        //            print("emailid = \(email)")
        //        }else{
        //
        //            email = KeychainWrapper.standard.string(forKey: "user-email")
        //            //print("Retrieved passwork is: \(retrievedPassword!)")
        //        }
        Firestore.firestore().collection("RecipeCollection").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // self.obj.removeAll()
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    // self.obj.append(document.data())
                    self.favoritesArray = document.data()["regions"]! as! [String]
                    print("document.data() => \(document.data()["regions"]!)")
                }
                self.tblViewFavorites.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("favoritesArray.count \(favoritesArray.count)")
        return favoritesArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        cell.lblFavoriteName.text = favoritesArray[indexPath.row]
        
        cell.btnRemoveFevorites.tag = indexPath.row
        cell.btnRemoveFevorites.addTarget(self, action: #selector(btnRemoveFavoritesAction(sender:)), for: .touchUpInside)
        
        cell.containerUIView.layer.shadowColor = UIColor.gray.cgColor
        cell.containerUIView.layer.shadowOpacity = 0.8
        cell.containerUIView.layer.shadowOffset = CGSize.zero
        cell.containerUIView.layer.shadowRadius = 2
        cell.containerUIView.layer.cornerRadius = cell.containerUIView.frame.height/15
        
        return cell
    }
  

}
