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
