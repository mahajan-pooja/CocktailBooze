//
//  WineModel.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class WineModel: NSObject {
    var image : String!
    var id : String!
    var name : String!
    var category: String!
    var desc: String!
    var descExtra: String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        image = dictionary["image"] as? String
        id = dictionary["id"] as? String
        name = dictionary["name"] as? String
        category = dictionary["category"] as? String
        desc = dictionary["desc"] as? String
        descExtra = dictionary["desc-extra"] as? String
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        if image != nil{
            dictionary["image"] = image
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if category != nil{
           dictionary["category"] = category
       }
        if desc != nil{
             dictionary["desc"] = desc
         }
         if descExtra != nil{
            dictionary["desc-extra"] = descExtra
        }
        return dictionary
    }
}
