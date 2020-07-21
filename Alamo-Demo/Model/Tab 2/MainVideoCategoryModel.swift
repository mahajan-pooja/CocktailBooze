//
//  MainVideoCategoryModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class MainVideoCategoryModel: NSObject {
    var message: String!
    var pageSizeLimit: [Int]!
    var perpage: Int!
    var responsecode: Int!
    var result: [VideoCategoryModel]!

    init(fromDictionary dictionary: NSDictionary) {
        message = dictionary["message"] as? String
        pageSizeLimit = dictionary["pageSizeLimit"] as? [Int]
        perpage = dictionary["per-page"] as? Int
        responsecode = dictionary["response-code"] as? Int
        result = [VideoCategoryModel]()
        if let resultArray = dictionary["result"] as? [NSDictionary] {
            for dic in resultArray {
                let value = VideoCategoryModel(fromDictionary: dic)
                result.append(value)
            }
        }
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if message != nil {
            dictionary["message"] = message
        }
        if pageSizeLimit != nil {
            dictionary["pageSizeLimit"] = pageSizeLimit
        }
        if perpage != nil {
            dictionary["per-page"] = perpage
        }
        if responsecode != nil {
            dictionary["response-code"] = responsecode
        }
        if result != nil {
            var dictionaryElements = [NSDictionary]()
            for resultElement in result {
                dictionaryElements.append(resultElement.toDictionary())
            }
            dictionary["result"] = dictionaryElements
        }
        return dictionary
    }
}
