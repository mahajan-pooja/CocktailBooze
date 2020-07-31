import UIKit

class WineModel: NSObject {
    var name: String!
    var image: String!
    var desc: String!
    var descExtra: String!
    var category: String!

    init(fromDictionary dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        image = dictionary["image"] as? String
        desc = dictionary["desc"] as? String
        descExtra = dictionary["desc-extra"] as? String
        category = dictionary["category"] as? String
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if name != nil {
            dictionary["name"] = name
        }
        if image != nil {
            dictionary["image"] = image
        }
        if desc != nil {
            dictionary["desc"] = desc
        }
        if descExtra != nil {
            dictionary["desc-extra"] = descExtra
        }
        if category != nil {
            dictionary["category"] = category
        }
        return dictionary
    }
}
