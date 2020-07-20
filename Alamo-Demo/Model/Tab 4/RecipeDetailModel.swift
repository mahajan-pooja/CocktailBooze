//
//  RecipeDetailModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class RecipeDetailModel: NSObject {
    var ingredients = [String]()
    var procedure = [String]()
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        ingredients = (dictionary["ingredients"] as? Array)!
        procedure = (dictionary["procedure"] as? Array)!
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        if ingredients != nil{
            dictionary["ingredients"] = ingredients
        }
        if procedure != nil{
            dictionary["procedure"] = procedure
        }
        
        return dictionary
    }
}
