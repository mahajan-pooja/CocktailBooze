//
//  RecipeViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/21/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase
//import FirebaseFirestore
import SwiftKeychainWrapper
import Alamofire

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recipe: String!
    var obj = [String:Any]()
    var ref: DocumentReference!
    var recipeImage: String!
    var recipeName: String!
    var recipeType: String!
    var ingredients = [String]()
    var procedure = [String]()
    var favoritesArray: [String] = []
    
    @IBOutlet weak var procedureTblviewHeight: NSLayoutConstraint!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var procedureTableView: UITableView!
    @IBOutlet weak var ingredientsTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recipeImgView: UIImageView!
    @IBOutlet weak var lblRecipeType: UILabel!
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBAction func btnAddFavoritesAction(_ sender: Any) {
        if(self.favoritesArray.contains(self.recipeName)){
            let user = Auth.auth().currentUser
            var email:String!
            
            if let user = user {
                email = user.email
            }else{
                email = KeychainWrapper.standard.string(forKey: "user-email")
            }
            ref = Firestore.firestore().collection("RecipeCollection").document(email)
            
            // Atomically add a new region to the "regions" array field.
            ref.updateData([
                "regions": FieldValue.arrayRemove([recipeName])
                ])
            self.btnFavorite.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }else{
            let user = Auth.auth().currentUser
            var email:String!
            
            if let user = user {
                email = user.email
            }else{
                email = KeychainWrapper.standard.string(forKey: "user-email")
            }
            ref = Firestore.firestore().collection("RecipeCollection").document(email)
            
            // Atomically add a new region to the "regions" array field.
            ref.updateData([
                "regions": FieldValue.arrayUnion([recipeName])
                ])
            self.btnFavorite.setBackgroundImage(UIImage(named: "like (1)"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblRecipeName.text = recipeName
        self.lblRecipeType.text = recipeType
        if(recipeImage != "") {
            let url: URL = URL(string: recipeImage)!
            self.recipeImgView.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
                ( image, error, cacheType, imageUrl) in
                if image != nil{
                    self.recipeImgView.clipsToBounds = true
                    self.recipeImgView.backgroundColor = .white
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getRecipe()
        Firestore.firestore().collection("RecipeCollection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.favoritesArray = document.data()["regions"]! as! [String]
                }
                if(self.favoritesArray.contains(self.recipeName)){
                    self.btnFavorite.setBackgroundImage(UIImage(named: "like (1)"), for: .normal)
                }else{
                    self.btnFavorite.setBackgroundImage(UIImage(named: "like"), for: .normal)
                }
            }
        }
    }
    
    func getRecipe(){
        Alamofire.request("https://mahajan-pooja.github.io/cocktail-booz-api/greentini.json").responseJSON(completionHandler: {(response) in
            if response.result.isSuccess {
                let model: RecipeDetailModel = RecipeDetailModel.init(fromDictionary: response.result.value as! NSDictionary)
                self.ingredients.removeAll()
                self.procedure.removeAll()
                self.ingredients = model.ingredients
                self.procedure = model.procedure
                self.ingredientsTableView.reloadData()
                self.ingredientsTblViewHeight.constant = CGFloat(self.ingredients.count * 70)
                self.procedureTableView.reloadData()
                self.procedureTblviewHeight.constant = CGFloat(self.procedure.count * 70)
            }else{
                print("failure error")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == ingredientsTableView){
            return ingredients.count
        }else{
            return procedure.count
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(tableView == ingredientsTableView){
            return 70
        }else{
            return 70
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == ingredientsTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
            cell.lblIngredients.text = ingredients[indexPath.row]
            cell.containerUIView.layer.shadowColor = UIColor.red.cgColor
            cell.containerUIView.layer.shadowOpacity = 0.5
            cell.containerUIView.layer.shadowOffset = CGSize.zero
            cell.containerUIView.layer.shadowRadius = 1.5
            cell.containerUIView.layer.masksToBounds = false
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProcedureTableCell", for: indexPath) as! ProcedureTableCell
            cell.lblProcedure.text = procedure[indexPath.row]
            cell.containerUIView.layer.shadowColor = UIColor.red.cgColor
            cell.containerUIView.layer.shadowOpacity = 0.5
            cell.containerUIView.layer.shadowOffset = CGSize.zero
            cell.containerUIView.layer.shadowRadius = 1.5
            cell.containerUIView.layer.masksToBounds = false
            return cell
        }
    }
}
