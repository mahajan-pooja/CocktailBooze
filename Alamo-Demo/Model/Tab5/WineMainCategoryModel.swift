//
//  WineMainCategoryModel.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class WineMainCategoryModel: NSObject {
    var wineCategory : [WineCategoryModel]!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        wineCategory = [WineCategoryModel]()
        if let wineCategoryArray = dictionary["wines"] as? [NSDictionary]{
            for dic in wineCategoryArray{
                let value = WineCategoryModel(fromDictionary: dic)
                wineCategory.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        
        if wineCategory != nil{
            var dictionaryElements = [NSDictionary]()
            for recipeElement in wineCategory {
                dictionaryElements.append(recipeElement.toDictionary())
            }
            dictionary["wines"] = dictionaryElements
        }
        return dictionary
    }
}
