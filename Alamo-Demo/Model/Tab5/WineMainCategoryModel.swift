//
//  WineMainCategoryModel.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class WineMainCategoryModel: NSObject {
    var wineCategory: [WineCategoryModel]!

    init(fromDictionary dictionary: NSDictionary) {
        wineCategory = [WineCategoryModel]()
        if let wineCategoryArray = dictionary["wines"] as? [NSDictionary] {
            for dic in wineCategoryArray{
                let value = WineCategoryModel(fromDictionary: dic)
                wineCategory.append(value)
            }
        }
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        
        if wineCategory != nil {
            var dictionaryElements = [NSDictionary]()
            for recipeElement in wineCategory {
                dictionaryElements.append(recipeElement.toDictionary())
            }
            dictionary["wines"] = dictionaryElements
        }
        return dictionary
    }
}
