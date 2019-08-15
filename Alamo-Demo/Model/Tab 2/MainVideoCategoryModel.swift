//
//  MainVideoCategoryModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class MainVideoCategoryModel: NSObject {
    var message : String!
    var pageSizeLimit : [Int]!
    var perpage : Int!
    var responsecode : Int!
    var result : [VideoCategoryModel]!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        message = dictionary["message"] as? String
        pageSizeLimit = dictionary["pageSizeLimit"] as? [Int]
        perpage = dictionary["per-page"] as? Int
        responsecode = dictionary["response-code"] as? Int
        result = [VideoCategoryModel]()
        if let resultArray = dictionary["result"] as? [NSDictionary]{
            for dic in resultArray{
                let value = VideoCategoryModel(fromDictionary: dic)
                result.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary{
        let dictionary = NSMutableDictionary()
        if message != nil{
            dictionary["message"] = message
        }
        if pageSizeLimit != nil{
            dictionary["pageSizeLimit"] = pageSizeLimit
        }
        if perpage != nil{
            dictionary["per-page"] = perpage
        }
        if responsecode != nil{
            dictionary["response-code"] = responsecode
        }
        if result != nil{
            var dictionaryElements = [NSDictionary]()
            for resultElement in result {
                dictionaryElements.append(resultElement.toDictionary())
            }
            dictionary["result"] = dictionaryElements
        }
        return dictionary
    }
}


