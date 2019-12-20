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

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    let type = ["Mild","Smooth","Strong","Hard","Non-Alcoholic"]
    var ingredientsArray: [String] = []
    var procedureArray: [String] = []
    let imagePicker = UIImagePickerController()
    var ref: DocumentReference!
    var imageName: String!
    var ingredientCount: Int = 1
    var procedureCount: Int = 1
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imgUIView: UIView!
    @IBOutlet weak var nameTypeUIView: UIView!
    @IBOutlet weak var MainScrollView: UIScrollView!
    @IBOutlet weak var btnAddRecipe: UIButton!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblProcedureHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewAddProcedure: UITableView!
    @IBOutlet weak var tblViewAddIngredient: UITableView!
    @IBOutlet weak var tblIngredientHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAddIngredients: UIButton!
    @IBOutlet weak var addProcedureUIView: UIView!
    @IBOutlet weak var btnAddProcedure: UIButton!
    @IBOutlet weak var ingredientsUIView: UIView!
    @IBOutlet weak var lblProcedure: UILabel!
    @IBOutlet weak var txtfRecipeName: UITextField!
    @IBOutlet weak var imgCocktail: UIImageView!

    @IBAction func btnCancelAction(_ sender: Any) {
        resetForm()
    }
    
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        btnAddProcedure.layer.cornerRadius = 15
        btnAddIngredients.layer.cornerRadius = 15
        btnAddRecipe.layer.cornerRadius = btnAddRecipe.frame.height/2
    
        pickerView.setValue(UIColor.purple, forKeyPath: "textColor")
        
        ingredientsUIView.layer.cornerRadius = ingredientsUIView.frame.width/15
        addProcedureUIView.layer.cornerRadius = addProcedureUIView.frame.width/15
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgCocktail.isUserInteractionEnabled = true
        imgCocktail.addGestureRecognizer(tapGestureRecognizer)
        
        addProcedureUIView.layer.shadowColor = UIColor.red.cgColor
        addProcedureUIView.layer.shadowOpacity = 0.5
        addProcedureUIView.layer.shadowOffset = CGSize.zero
        addProcedureUIView.layer.shadowRadius = 1.5
        
        ingredientsUIView.layer.shadowColor = UIColor.red.cgColor
        ingredientsUIView.layer.shadowOpacity = 0.5
        ingredientsUIView.layer.shadowOffset = CGSize.zero
        ingredientsUIView.layer.shadowRadius = 1.5
        
        nameTypeUIView.layer.shadowColor = UIColor.red.cgColor
        nameTypeUIView.layer.shadowOpacity = 0.5
        nameTypeUIView.layer.shadowOffset = CGSize.zero
        nameTypeUIView.layer.shadowRadius = 1.5
        
        imgUIView.layer.shadowColor = UIColor.red.cgColor
        imgUIView.layer.shadowOpacity = 0.5
        imgUIView.layer.shadowOffset = CGSize.zero
        imgUIView.layer.shadowRadius = 1.5
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        pickerView.selectRow(2, inComponent: 0, animated: true)
    }
    
    func addRecipe(){
        let user = Auth.auth().currentUser
        var email:String!
        
        if let user = user {
            email = user.email
        }else{
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }
        
        for i in 1...ingredientCount{
            if let theTextField = self.view.viewWithTag(i) as? UITextField {
                ingredientsArray.append(theTextField.text!)
                print(theTextField.text!)
            }
        }

        for i in 1...procedureCount{
            if let theTextField = self.view.viewWithTag(i+50) as? UITextField {
                procedureArray.append(theTextField.text!)
                print(theTextField.text!)
            }
        }
        var selectedValue = pickerView.selectedRow(inComponent: 0)
        if(txtfRecipeName.text! != "" && imageName != "" && imageName != nil && ingredientsArray != nil && procedureArray != nil){
            //save data on firebase
            let data: [String:Any] = ["recipe-name":txtfRecipeName.text!, "recipe-type":type[selectedValue], "recipe-img":imageName, "ingredients":ingredientsArray, "procedure": procedureArray]
            ref = Firestore.firestore().collection(email).document(txtfRecipeName.text!)
            ref.setData(data){ (error) in
                if error != nil {
                    print("Error")
                }else{
                    let alert = UIAlertController(title: "Success", message: "Recipe Added Successfully!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                    self.tabBarController?.selectedIndex = 3

                    self.resetForm()

                    print("Done")
                }
            }
        }else{
            print("Please add all information.")
        }
    }
    
    func resetForm(){
        self.tblIngredientHeight.constant = 150
        self.tblProcedureHeight.constant = 150
        
        ingredientsArray.removeAll()
        procedureArray.removeAll()
        
        self.ingredientCount = 1
        self.tblViewAddIngredient.reloadData()
        self.procedureCount = 1
        self.tblViewAddProcedure.reloadData()
        
        for i in 1...50{
            if let theTextField = self.view.viewWithTag(i) as? UITextField {
                theTextField.text = ""
            }
        }
        for i in 51...100{
            if let theTextField = self.view.viewWithTag(i) as? UITextField {
                theTextField.text = ""
            }
        }
        
        self.txtfRecipeName.text = ""
        self.imgCocktail.image = UIImage(named: "cocktail")
        MainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        let randomInt = Int.random(in: 0..<100000)
        let imgName = "img\(randomInt)"
        imageName = imgName
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        var data = Data()
            data = pickedImage.jpegData(compressionQuality:0.8)!
        
            let imageRef = Storage.storage().reference().child("images/\(imageName!)")
            
            _ = imageRef.putData(data, metadata: nil){ (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                
            }
            imgCocktail.image = UIImage(data: data as Data)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
