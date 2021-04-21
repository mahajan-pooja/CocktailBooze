import UIKit

class VideoCategoryModel: NSObject {
    var url: String!
    var productId: String!
    var productName: String!
    var image: String!

    init(fromDictionary dictionary: NSDictionary) {
        url = dictionary["video_url"] as? String
        image = dictionary["image"] as? String
        productId = dictionary["product_id"] as? String
        productName = dictionary["product_name"] as? String
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if url != nil {
            dictionary["video_url"] = url
        }
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
