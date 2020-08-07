//
//  RecipeModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
class RecipeModel {
    var recipeName: String!
    var recipeType: String!
    var recipeImage: String!
    var ingredients: [String]!
    var procedure: [String]!
    
    init(fromDictionary dictionary: NSDictionary) {
        recipeName = dictionary["recipe-name"] as? String
        recipeType = dictionary["recipe-type"] as? String
        recipeImage = dictionary["recipe-img"] as? String
        ingredients = dictionary["ingredients"] as? [String]
        procedure = dictionary["procedure"] as? [String]
    }
}
