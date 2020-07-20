//
//  WineCategoryModel.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class WineCategoryModel: NSObject {
    var wine : [WineModel]!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        wine = [WineModel]()
        if let wineArray = dictionary["wines-sub"] as? [NSDictionary]{
            for dic in wineArray{
                let value = WineModel(fromDictionary: dic)
                wine.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        
        if wine != nil{
            var dictionaryElements = [NSDictionary]()
            for recipeElement in wine {
                dictionaryElements.append(recipeElement.toDictionary())
            }
            dictionary["wines-sub"] = dictionaryElements
        }
        return dictionary
    }
}
