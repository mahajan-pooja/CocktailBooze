//
//  RecipeDetailVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 8/19/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class RecipeDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imgRecipeIcon: UIImageView!
    @IBOutlet weak var lblRecipeType: UILabel!
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var tblProcedureHeight: NSLayoutConstraint!
    @IBOutlet weak var tblIngreHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewProcedure: UITableView!
    @IBOutlet weak var tblViewIngredients: UITableView!
    var recipe: String!
    var obj = [String:Any]()
    var ingredients = [String]()
    var procedure = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        let user = Auth.auth().currentUser
        var email:String!
        var password:String!
        if let user = user {
            //let uid = user.uid
            email = user.email
        }else{
            password = KeychainWrapper.standard.string(forKey: "user-password")
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }

        Firestore.firestore().collection(email).getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(document.documentID == self.recipe){
                        self.obj = document.data()
                        let model: RecipeDetailModel = RecipeDetailModel.init(fromDictionary: self.obj as NSDictionary)
        
                        self.ingredients = model.ingredients
                        self.procedure = model.procedure
                        self.lblRecipeName.text = model.recipe_name
                        self.lblRecipeType.text = model.recipe_type
                        
                        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                        let imageRef = Storage.storage().reference().child("images/\(model.recipe_img!)")
                        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if let error = error {
                                
                                print("error \(error)")
                                // Uh-oh, an error occurred!
                            } else {
                                // Data for "images/island.jpg" is returned
                                let image = UIImage(data: data!)
                                print("IMAGEEE = \(image)")
                                self.imgRecipeIcon.image = image
                            }
                        }
                        
                        
                        
//                        let data = UserDefaults.standard.object(forKey: model.recipe_img as! String) as! NSData
//                        self.imgRecipeIcon.image = UIImage(data: data as Data)
//                        if(model.recipe_img != "") {
//                            let url: URL = URL(string: model.recipe_img)!
//                            self.imgRecipeIcon.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
//                                ( image, error, cacheType, imageUrl) in
//                                if image != nil{
//                                    self.imgRecipeIcon.clipsToBounds = true
//                                    self.imgRecipeIcon.backgroundColor = .white
//                                }
//                            })
//                        }
                        
                        self.tblViewProcedure.reloadData()
                        self.tblViewIngredients.reloadData()
                        
                        self.tblIngreHeight.constant = CGFloat(self.ingredients.count * 60)
                        self.tblProcedureHeight.constant = CGFloat(self.procedure.count * 100)
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == tblViewIngredients){
            return 60
        }else{
            return 100
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblViewIngredients){
            return ingredients.count
        }else{
            return procedure.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblViewIngredients){
            let cell:IngredientsCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
            cell.lblIngredients.text = ingredients[indexPath.row]
            return cell
        }else{
            let cell:ProcedureCell = tableView.dequeueReusableCell(withIdentifier: "ProcedureCell", for: indexPath) as! ProcedureCell
            cell.lblProcedure.text = procedure[indexPath.row]
            return cell
        }
    }
}
