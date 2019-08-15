//
//  DetailCategoryModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/8/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class DetailCategoryModel: NSObject {
    var cat_id : String!
    var cat_name : String!
    var cat_type : String!
    var image: String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        cat_id = dictionary["cat_id"] as? String
        cat_name = dictionary["cat_name"] as? String
        cat_type = dictionary["cat_type"] as? String
        image = dictionary["image"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        if cat_id != nil{
            dictionary["cat_id"] = cat_id
        }
        if cat_name != nil{
            dictionary["cat_name"] = cat_name
        }
        if cat_type != nil{
            dictionary["cat_type"] = cat_type
        }
        if image != nil{
            dictionary["image"] = image
        }
        return dictionary
    }
}
