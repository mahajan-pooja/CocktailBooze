//
//  MainCaterogy.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class SubCategoryModel: NSObject {
    var image : String!
    var productId : String!
    var productName : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        image = dictionary["image"] as? String
        productId = dictionary["product_id"] as? String
        productName = dictionary["product_name"] as? String
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        if image != nil{
            dictionary["image"] = image
        }
        if productId != nil{
            dictionary["product_id"] = productId
        }
        if productName != nil{
            dictionary["product_name"] = productName
        }
        return dictionary
    }
}


