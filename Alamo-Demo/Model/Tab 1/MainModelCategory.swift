//
//  MainModelCategory.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class MainModelCategory: NSObject {
    var recipe : [SubCategoryModel]!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        recipe = [SubCategoryModel]()
        if let recipesArray = dictionary["recipes"] as? [NSDictionary]{
            for dic in recipesArray{
                let value = SubCategoryModel(fromDictionary: dic)
                recipe.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        
        if recipe != nil{
            var dictionaryElements = [NSDictionary]()
            for recipeElement in recipe {
                dictionaryElements.append(recipeElement.toDictionary())
            }
            dictionary["recipes"] = dictionaryElements
        }
        return dictionary
    }
}
