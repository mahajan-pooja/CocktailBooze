import Foundation

class DetailsViewModel: NSObject {
    func fetchRecipeData(categoryId: String, completion: @escaping ([DetailCategoryModel]) -> Void) {
        switch categoryId {
        case "1":
            APIClient.loadJson(filename: "valentine") { result in
                completion(result)
            }
        case "2":
            APIClient.loadJson(filename: "summer") { result in
                completion(result)
            }
        case "3":
            APIClient.loadJson(filename: "spring") { result in
                completion(result)
            }
        case "4":
            APIClient.loadJson(filename: "slushy") { result in
                completion(result)
            }
        default:
            APIClient.loadJson(filename: "valentine") { result in
                completion(result)
            }
        }
    }
}
