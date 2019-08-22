//
//  AddRecipeViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/2/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import SwiftKeychainWrapper

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var btnAddRecipe: UIButton!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblProcedureHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewAddProcedure: UITableView!
    @IBOutlet weak var tblViewAddIngredient: UITableView!
    @IBOutlet weak var tblIngredientHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAddIngredients: UIButton!
    @IBOutlet weak var addRecipeSection: UIStackView!
    @IBOutlet weak var addProcedureUIView: UIView!
    @IBOutlet weak var btnAddProcedure: UIButton!
    @IBOutlet weak var ingredientsUIView: UIView!
    @IBOutlet weak var lblProcedure: UILabel!
    @IBOutlet weak var txtfRecipeName: UITextField!
    @IBOutlet weak var imgCocktail: UIImageView!
    @IBOutlet weak var txtfType: UITextField!
    
    let imagePicker = UIImagePickerController()
    var ref: DocumentReference!
    var imageName: String!
    var ingredientCount: Int = 1
    var procedureCount: Int = 1
    
    @IBAction func btnAddRecipeAction(_ sender: Any) {
        addRecipe()
    }
    @IBAction func btnAddIngredient(_ sender: Any) {
        ingredientCount = ingredientCount + 1
        tblIngredientHeight.constant = tblIngredientHeight.constant+50
        mainViewHeight.constant = mainViewHeight.constant+50
        tblViewAddIngredient.reloadData()
    }
    
    @IBAction func btAddProcedureAction(_ sender: Any) {
        procedureCount = procedureCount + 1
        tblProcedureHeight.constant = tblProcedureHeight.constant+50
        mainViewHeight.constant = mainViewHeight.constant+50
        tblViewAddProcedure.reloadData()
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker,animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        btnAddProcedure.layer.cornerRadius = 15
        btnAddIngredients.layer.cornerRadius = 15
        btnAddRecipe.layer.cornerRadius = 15
        
        ingredientsUIView.layer.cornerRadius = ingredientsUIView.frame.width/15
        addProcedureUIView.layer.cornerRadius = addProcedureUIView.frame.width/15
//        tblViewAddProcedure.layer.cornerRadius = tblViewAddProcedure.frame.width/15
//        tblViewAddIngredient.layer.cornerRadius = tblViewAddIngredient.frame.width/15
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblViewAddIngredient){
            return ingredientCount
        }else{
            return procedureCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblViewAddIngredient){
            let cell:IngredientsAddTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsAddTableViewCell", for: indexPath) as! IngredientsAddTableViewCell
            //tags starts from 1
            cell.txtFieldIngredient.tag = indexPath.row+1
            return cell
        }else{
            let cell:ProcedureTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProcedureTableViewCell", for: indexPath) as! ProcedureTableViewCell
            //tags starts from 51
            cell.txtFieldProcedure.tag = indexPath.row+1+50
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            if(tableView == tblViewAddIngredient){
                tblIngredientHeight.constant = tblIngredientHeight.constant-50
                mainViewHeight.constant = mainViewHeight.constant-50
                ingredientCount = ingredientCount - 1
            }else{
                tblProcedureHeight.constant = tblProcedureHeight.constant-50
                mainViewHeight.constant = mainViewHeight.constant-50
                procedureCount = procedureCount - 1
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func addRecipe(){
        let user = Auth.auth().currentUser
        var email:String!
        var password: String!
        if let user = user {
            email = user.email
            print("email - \(email!)")
        }else{
            password = KeychainWrapper.standard.string(forKey: "user-password")
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }
        
        var ingredientsArray: [String] = []
        for i in 1...ingredientCount{
            if let theTextField = self.view.viewWithTag(i) as? UITextField {
                ingredientsArray.append(theTextField.text!)
                print(theTextField.text!)
            }
        }

        var procedureArray: [String] = []
        for i in 1...procedureCount{
            if let theTextField = self.view.viewWithTag(i+50) as? UITextField {
                procedureArray.append(theTextField.text!)
                print(theTextField.text!)
            }
        }
        
        if(txtfRecipeName.text! != "" && txtfType.text! != "" && imageName != "" && imageName != nil && ingredientsArray != nil && procedureArray != nil){
            //save data on firebase
            let data: [String:Any] = ["recipe-name":txtfRecipeName.text!, "recipe-type":txtfType.text!, "recipe-img":imageName, "ingredients":ingredientsArray, "procedure": procedureArray]
            ref = Firestore.firestore().collection(email).document(txtfRecipeName.text!)
            ref.setData(data){ (error) in
                if error != nil {
                    print("Error")
                }else{
                    let alert = UIAlertController(title: "Success", message: "Recipe Added Successfully!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.tabBarController?.selectedIndex = 3
                    
                    print("Done")
                }
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let randomInt = Int.random(in: 0..<100000)
        let imgName = "img\(randomInt)"
        imageName = imgName
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage{
                imgCocktail.contentMode = .scaleAspectFit
            let imageData: NSData = pickedImage.pngData()! as NSData
            UserDefaults.standard.set(imageData, forKey: imgName)
            }
        
        let data = UserDefaults.standard.object(forKey: imgName) as! NSData
        imgCocktail.image = UIImage(data: data as Data)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
