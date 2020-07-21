import UIKit

class WineModel: NSObject {
    var name: String!
    var image: String!
    var desc: String!
    var descExtra: String!
    var category: String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        image = dictionary["image"] as? String
        desc = dictionary["desc"] as? String
        descExtra = dictionary["desc-extra"] as? String
        category = dictionary["category"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
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
