//
//  MainModelCategory.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class MainModelCategory: NSObject {
    var recipe: [SubCategoryModel]!

    init(fromDictionary dictionary: NSDictionary) {
        recipe = [SubCategoryModel]()
        if let recipesArray = dictionary["recipes"] as? [NSDictionary] {
            for dic in recipesArray {
                let value = SubCategoryModel(fromDictionary: dic)
                recipe.append(value)
            }
        }
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        
        if recipe != nil {
            var dictionaryElements = [NSDictionary]()
            for recipeElement in recipe {
                dictionaryElements.append(recipeElement.toDictionary())
            }
            dictionary["recipes"] = dictionaryElements
        }
        return dictionary
    }
}
