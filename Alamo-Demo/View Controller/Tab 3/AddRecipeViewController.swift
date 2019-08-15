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

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblViewAddProcedure: UITableView!
    @IBOutlet weak var tblViewAddIngredient: UITableView!
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
        
        cell.txtFieldIngredient.tag = indexPath.row+1
       
        return cell
        
        }else{
    
            let cell:ProcedureTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProcedureTableViewCell", for: indexPath) as! ProcedureTableViewCell
    
          //  cell.txtFieldIngredient.tag = indexPath.row+1
    
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
                ingredientCount = ingredientCount - 1
            }else{
                procedureCount = procedureCount - 1
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    let imagePicker = UIImagePickerController()
    
    var ref: DocumentReference!
    var imageName: String!
    var ingredientCount: Int = 3
    var procedureCount: Int = 3
    
    @IBAction func btnAddRecipeAction(_ sender: Any) {
        addRecipe()
        saveToJsonFile()
    }
    @IBOutlet weak var btnAddIngredients: UIButton!
    @IBOutlet weak var addRecipeSection: UIStackView!
    @IBOutlet weak var addProcedureUIView: UIView!
    @IBOutlet weak var btnAddProcedure: UIButton!
    @IBOutlet weak var ingredientsUIView: UIView!
    @IBOutlet weak var lblProcedure: UILabel!
    @IBOutlet weak var txtfRecipeName: UITextField!
    @IBOutlet weak var imgCocktail: UIImageView!
    @IBOutlet weak var txtfProcedure: UITextField!
    @IBOutlet weak var txtfType: UITextField!
    
    @IBAction func btnAddIngredient(_ sender: Any) {
        ingredientCount = ingredientCount + 1
        print("ingredientCount \(ingredientCount)")
        tblViewAddIngredient.reloadData()
    }
    
    @IBAction func btAddProcedureAction(_ sender: Any) {
        addProcedureUIView.frame.size.height = addProcedureUIView.frame.size.height + 40
        let txtField: UITextField = UITextField(frame: CGRect(x: 10, y: addProcedureUIView.frame.size.height-40, width: 300.00, height: 30.00))
        txtField.backgroundColor = UIColor.white
        txtField.font =  UIFont(name: txtField.font!.fontName, size: 15)
        txtField.layer.cornerRadius = 5
        txtField.placeholder = " Procedure"
        self.addProcedureUIView.addSubview(txtField)
        addRecipeSection.frame.origin.y = addRecipeSection.frame.origin.y + 40
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker,animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //ref = Firestore.firestore().collection("RecipeCollection").document("Recipe")
        imagePicker.delegate = self
        btnAddProcedure.layer.cornerRadius = 15
        btnAddIngredients.layer.cornerRadius = 15
        //ref = Database.database().reference().child("recipes")
    }
    
    func addRecipe(){
        let user = Auth.auth().currentUser
        var email:String!
        if let user = user {
            //let uid = user.uid
            email = user.email
            print("email - \(email!)")
        }
        
//        var ingredientsArray: [String] = []
//        for i in 1...ingredientCount{
//            if let theTextField = self.view.viewWithTag(i) as? UITextField {
//                ingredientsArray.append(theTextField.text!)
//                print(theTextField.text!)
//            }
//        }
//
//        var procedureArray: [String] = []
//        for i in 1...procedureCount{
//            if let theTextField = self.view.viewWithTag(i) as? UITextField {
//                procedureArray.append(theTextField.text!)
//                print(theTextField.text!)
//            }
//        }
        
                var ingredientsArray: [String] = []
                for i in 1...ingredientCount{
                    let indexPath = IndexPath.init(row: i-1, section: 0) // Obviously with the correct row/sec
                    let itemCell = tblViewAddIngredient.cellForRow(at: indexPath) as! IngredientsAddTableViewCell  // your tableview must be an IBOutlet on your view controller
                    ingredientsArray.append(itemCell.txtFieldIngredient.text!)
                }
        
                var procedureArray: [String] = []
                for i in 1...procedureCount{
                    
                    let indexPath = IndexPath.init(row: i-1, section: 0) // Obviously with the correct row/sec
                    let itemCell = tblViewAddProcedure.cellForRow(at: indexPath) as! ProcedureTableViewCell  // your tableview must be an IBOutlet on your view controller
                    procedureArray.append(itemCell.txtFieldProcedure.text!)
                }
        
        
        
        
//        print("procedureArray \(procedureArray.count)")
        let data: [String:Any] = ["recipe-name":txtfRecipeName.text!, "recipe-type":txtfType.text!, "recipe-img":imageName, "ingredients":ingredientsArray, "procedure": procedureArray]
        ref = Firestore.firestore().collection(email).document(txtfRecipeName.text!)
        ref.setData(data){ (error) in
            if error != nil {
                print("Error")
            }else{
                print("Done")
            }
        }
    }
    func saveToJsonFile() {
        // Get the url of Persons.json in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("Recipes.json")
        let data: [String:Any] = ["recipe-name":txtfRecipeName.text!, "recipe-type":txtfType.text!, "recipe-img":imageName]
        //let personArray =  [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]
        
        // Transform array into data and save it into file
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            try jsonData.write(to: fileUrl, options: [])
        } catch {
            print(error)
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
