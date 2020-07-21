//
//  RecipeDetailVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 8/19/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class RecipeDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recipeName: String!
    var recipeType: String!
    var recipeImage: String!
    var obj = [String: Any]()
    var ingredients = [String]()
    var procedure = [String]()

    @IBOutlet weak var imgRecipeIcon: UIImageView!
    @IBOutlet weak var lblRecipeType: UILabel!
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var tblProcedureHeight: NSLayoutConstraint!
    @IBOutlet weak var tblIngreHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewProcedure: UITableView!
    @IBOutlet weak var tblViewIngredients: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        let user = Auth.auth().currentUser
        var email: String!

        if let user = user {
            email = user.email
        } else {
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }
        
        Firestore.firestore().collection(email).getDocuments() { (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.documentID == self.recipeName {
                        self.obj = document.data()
                        let model: RecipeDetailModel = RecipeDetailModel.init(fromDictionary: self.obj as NSDictionary)

                        self.ingredients = model.ingredients
                        self.procedure = model.procedure
                        self.lblRecipeName.text = self.recipeName
                        self.lblRecipeType.text = self.recipeType

                        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                        let imageRef = Storage.storage().reference().child("images/\(self.recipeImage!)")
                        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if let error = error {
                                print("error \(error)")
                            } else {
                                // Data for "images/island.jpg" is returned
                                let image = UIImage(data: data!)
                                self.imgRecipeIcon.image = image
                            }
                        }

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
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblViewIngredients {
            return 60
        } else {
            return 100
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewIngredients {
            return ingredients.count
        } else {
            return procedure.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewIngredients {
            let cell:IngredientsCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
            cell.lblIngredients.text = ingredients[indexPath.row]

            cell.containerUIView.layer.shadowColor = UIColor.red.cgColor
            cell.containerUIView.layer.shadowOpacity = 0.5
            cell.containerUIView.layer.shadowOffset = CGSize.zero
            cell.containerUIView.layer.shadowRadius = 1.5
            cell.containerUIView.layer.masksToBounds = false

            return cell
        } else {
            let cell:ProcedureCell = tableView.dequeueReusableCell(withIdentifier: "ProcedureCell", for: indexPath) as! ProcedureCell
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
