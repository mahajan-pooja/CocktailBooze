//
//  RecipeViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/21/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var lblIngredients: UILabel!
    @IBOutlet weak var recipeImgView: UIImageView!
    @IBOutlet weak var lblRecipeType: UILabel!
    @IBOutlet weak var lblRecipeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblRecipeName.text = "Singapore Sling"
        lblRecipeType.text = "Medium (18%)"
        lblIngredients.text = "Ingredients"
        recipeImgView.image = UIImage(named: "food_img")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
     //Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
        cell.lblIngredients.text = "3oz Ginger Beer"
        return cell
    }
    
}
