import UIKit

class CategoryModel: NSObject {
    var category: [DetailCategoryModel]!

    init(fromDictionary dictionary: NSDictionary) {
        category = [DetailCategoryModel]()
        if let categoryArray = dictionary["categories"] as? [NSDictionary] {
            for dic in categoryArray {
                let value = DetailCategoryModel(fromDictionary: dic)
                category.append(value)
            }
        }
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()

        if category != nil {
            var dictionaryElements = [NSDictionary]()
            for categoryElement in category {
                dictionaryElements.append(categoryElement.toDictionary())
            }
            dictionary["categories"] = dictionaryElements
        }
        return dictionary
    }
}
