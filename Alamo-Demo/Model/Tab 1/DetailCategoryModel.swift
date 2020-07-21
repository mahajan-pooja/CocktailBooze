//
//  DetailCategoryModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class DetailCategoryModel: NSObject {
    var categoryId: String!
    var categoryName: String!
    var categoryType: String!
    var image: String!

    init(fromDictionary dictionary: NSDictionary) {
        categoryId = dictionary["cat_id"] as? String
        categoryName = dictionary["cat_name"] as? String
        categoryType = dictionary["cat_type"] as? String
        image = dictionary["image"] as? String
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if categoryId != nil {
            dictionary["cat_id"] = categoryId
        }
        if categoryName != nil {
            dictionary["cat_name"] = categoryName
        }
        if categoryType != nil {
            dictionary["cat_type"] = categoryType
        }
        if image != nil {
            dictionary["image"] = image
        }
        return dictionary
    }
}
