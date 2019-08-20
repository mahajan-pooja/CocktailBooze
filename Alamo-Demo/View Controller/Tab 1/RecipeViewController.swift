//
//  RecipeViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/21/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Firebase

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var procedureTableView: UITableView!
    
    @IBOutlet weak var recipeImgView: UIImageView!
    @IBOutlet weak var lblRecipeType: UILabel!
    @IBOutlet weak var lblRecipeName: UILabel!
    let section = ["Ingredients", "Recipe"]
    var recipe: String!
    var obj = [String:Any]()
    let items = [["Gin", "Lemon Juice", "Raspberry", "Blueberry","Mint Leaves","Ice"], ["add raspberry, mint leaves, lemon", "crush raspberrymint leaveslemon, lemon", "add sugar syrup, ice, gin","shake well","strain into the old fashioned glass","garnish with lemon spiral"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        lblRecipeName.text = "Singapore Sling"
        lblRecipeType.text = "Medium (18%)"
        recipeImgView.image = UIImage(named: "cocktail")
        
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerText = UILabel()
        headerText.textAlignment = .center
        headerText.text = self.section[section]
        headerText.textColor = UIColor(red: 70/255, green: 20/255, blue: 72/255, alpha: 1)
        headerText.font = UIFont.init(name: "Noteworthy-bold", size: 20)
        
        return headerText
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
        cell.lblIngredients.text = self.items[indexPath.section][indexPath.row]
        return cell
    }
}
