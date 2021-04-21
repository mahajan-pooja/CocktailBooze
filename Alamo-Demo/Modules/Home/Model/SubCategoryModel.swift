import UIKit

class SubCategoryModel: NSObject {
    var image: String!
    var productId: String!
    var productName: String!

    init(fromDictionary dictionary: NSDictionary) {
        image = dictionary["image"] as? String
        productId = dictionary["product_id"] as? String
        productName = dictionary["product_name"] as? String
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if image != nil {
            dictionary["image"] = image
        }
        if productId != nil {
            dictionary["product_id"] = productId
        }
        if productName != nil {
            dictionary["product_name"] = productName
        }
        return dictionary
    }
}
