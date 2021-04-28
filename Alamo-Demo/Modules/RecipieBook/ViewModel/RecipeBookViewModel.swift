//
//  RecipeBookViewModel.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/28/21.
//  Copyright © 2021 Pooja Mahajan. All rights reserved.
//

import Foundation

protocol RecipeBookDelegate: class {
    func loadRecipes()
}

class RecipeBookViewModel: NSObject {
    weak var delegate: RecipeBookDelegate?
    var downloadedRecipes: [[String: Any]] = [] {
        didSet {
            delegate?.loadRecipes()
        }
    }
    
    func getRecipes() {
        FirebaseClient.getRecipes { result in
            switch result {
            case .success(let recipies):
                self.downloadedRecipes = recipies
            case .failure(let error):
                print(error)
            }
        }
    }
}
