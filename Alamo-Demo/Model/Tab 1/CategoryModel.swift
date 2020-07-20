//
//  CategoryModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {
    var category : [DetailCategoryModel]!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        category = [DetailCategoryModel]()
        if let categoryArray = dictionary["categories"] as? [NSDictionary]{
            for dic in categoryArray{
                let value = DetailCategoryModel(fromDictionary: dic)
                category.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        
        if category != nil{
            var dictionaryElements = [NSDictionary]()
            for categoryElement in category {
                dictionaryElements.append(categoryElement.toDictionary())
            }
            dictionary["categories"] = dictionaryElements
        }
        return dictionary
    }
}
