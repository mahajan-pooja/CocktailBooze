//
//  VideoCategoryModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class VideoCategoryModel: NSObject {
    var url : String!
    var productId : String!
    var productName : String!
    var image : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        url = dictionary["video_url"] as? String
        image = dictionary["image"] as? String
        productId = dictionary["product_id"] as? String
        productName = dictionary["product_name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        if url != nil{
            dictionary["video_url"] = url
        }
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
