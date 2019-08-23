//
//  RecipeBookViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/12/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

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
        if(obj[indexPath.row]["recipe-img"] != nil){
            print("obj[indexPath.row][recipeimg] \(obj[indexPath.row]["recipe-img"]) ")
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            let imageRef = Storage.storage().reference().child("images/\(obj[indexPath.row]["recipe-img"]!)")
            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {

                    print("error \(error)")
                    // Uh-oh, an error occurred!
                } else {
                    // Data for "images/island.jpg" is returned
                    let image = UIImage(data: data!)
                    print("IMAGEEE = \(image)")
                    cell.imgRecipe.image = image
                }
            }
           // let data = UserDefaults.standard.object(forKey: obj[indexPath.row]["recipe-img"] as! String) as! NSData
           // cell.imgRecipe.image = UIImage(data: data as Data)
        }else{
            cell.imgRecipe.image = UIImage(named: "cocktail")
        }
        //cell.imgRecipe.image = UIImage(named: "edit")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(obj[indexPath.row]["recipe-name"]!)")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecipeDetailVC") as! RecipeDetailVC
        vc.recipe = obj[indexPath.row]["recipe-name"]! as! String
        self.navigationController?.pushViewController(vc, animated: true)
       
    }

    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        tableView.subviews.forEach { subview in
            print("YourTableViewController: \(String(describing: type(of: subview)))")
            if (String(describing: type(of: subview)) == "UISwipeActionPullView") {
                if (String(describing: type(of: subview.subviews[0])) == "UISwipeActionStandardButton") {
                    var deleteBtnFrame = subview.subviews[0].frame
                    deleteBtnFrame.origin.y = 15
                    deleteBtnFrame.size.height = 140
                
                    
                    // Subview in this case is the whole edit View
                    subview.frame.origin.y =  subview.frame.origin.y - 3
                    subview.frame.origin.x =  subview.frame.origin.x - 20
                    subview.frame.size.height = 140
                    subview.subviews[0].frame = deleteBtnFrame
                    subview.backgroundColor = UIColor.white
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let user = Auth.auth().currentUser
            var email:String!
            if let user = user {
                //let uid = user.uid
                email = user.email
            }
            let document = obj[indexPath.row]["recipe-name"] as? String
            Firestore.firestore().collection(email).document(document!).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            obj.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
//        tblViewRecipeBook.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        let user = Auth.auth().currentUser
        var password:String!
        var email:String!
        if let user = user {
            //let uid = user.uid
            email = user.email
            print("emailid = \(email)")
        }else{
            password = KeychainWrapper.standard.string(forKey: "user-password")
            email = KeychainWrapper.standard.string(forKey: "user-email")
            //print("Retrieved passwork is: \(retrievedPassword!)")
        }
        Firestore.firestore().collection(email).getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.obj.removeAll()
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    self.obj.append(document.data())
                }
                self.tblViewRecipeBook.reloadData()
            }
        }
    }
}
