//
//  RecipeDetailModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class RecipeDetailModel: NSObject {
    var recipe_name : String!
    //var pageSizeLimit : [Int]!
    var recipe_type : String!
    var recipe_img : String!
    var ingredients = [String]()
    var procedure = [String]()
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        recipe_name = dictionary["recipe-name"] as? String
        recipe_type = dictionary["recipe-type"] as? String
        recipe_img = dictionary["recipe-img"] as? String
        ingredients = (dictionary["ingredients"] as? Array)!
        procedure = (dictionary["procedure"] as? Array)!
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        if recipe_name != nil{
            dictionary["recipe-name"] = recipe_name
        }
        if recipe_type != nil{
            dictionary["recipe-type"] = recipe_type
        }
        if recipe_img != nil{
            dictionary["recipe-img"] = recipe_img
        }
        if ingredients != nil{
            dictionary["ingredients"] = ingredients
        }
        if procedure != nil{
            dictionary["procedure"] = procedure
        }

        return dictionary
    }
}



