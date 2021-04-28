//
//  RecipeDetailsViewModel.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/28/21.
//  Copyright © 2021 Pooja Mahajan. All rights reserved.
//

import Foundation

protocol RecipeDetailsDelegate: class {
    func loadRecipeDetails()
}

class RecipeDetailsViewModel: NSObject {
    weak var delegate: RecipeDetailsDelegate?
    
    var recipeDetails: [String: Any] = [:] {
        didSet {
            delegate?.loadRecipeDetails()
        }
    }
    
    func getRecipeDetails(selectedRecipe: RecipeModel) {
        FirebaseClient.getRecipeDetails(selectedRecipe: selectedRecipe) { result in
            switch result {
            case .success(let recipeDetails):
                self.recipeDetails = recipeDetails
            case .failure(let error):
                print(error)
            }
        }
    }
}
