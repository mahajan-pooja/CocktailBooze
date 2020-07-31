//
//  RecipeDetailModel.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class RecipeDetailModel: NSObject {
    var ingredients: [String]!
    var procedure: [String]!

    init(fromDictionary dictionary: NSDictionary) {
        ingredients = (dictionary["ingredients"] as? Array)!
        procedure = (dictionary["procedure"] as? Array)!
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if ingredients != nil {
            dictionary["ingredients"] = ingredients
        }
        if procedure != nil {
            dictionary["procedure"] = procedure
        }
        return dictionary
    }
}
