//
//  RecipeBookViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/12/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase

class RecipeBookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblViewRecipeBook: UITableView!
    var obj = [[String:Any]]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("obj.count \(obj.count)")
        return obj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeBookTableViewCell", for: indexPath) as! RecipeBookTableViewCell
        cell.lblRecipeName.text = obj[indexPath.row]["recipe-name"] as? String
        let data = UserDefaults.standard.object(forKey: obj[indexPath.row]["recipe-img"] as! String) as! NSData
        cell.imgRecipe.image = UIImage(data: data as Data)
        //cell.imgRecipe.image = UIImage(named: "edit")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        var email:String!
        if let user = user {
            //let uid = user.uid
            email = user.email
        }
        Firestore.firestore().collection(email).getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    self.obj.append(document.data())
                }
                self.tblViewRecipeBook.reloadData()
            }
          //  print(self.obj[0])
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillappear")
    }
}
