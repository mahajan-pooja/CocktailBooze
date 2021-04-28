import Foundation

protocol RecipeBookDelegate: class {
    func loadRecipes()
}

class RecipeBookViewModel: NSObject {
    weak var delegate: RecipeBookDelegate?
    var downloadedRecipes: [[String: Any]] = [] {
        didSet {
            delegate?.loadRecipes()
        }
    }
    
    func getRecipes() {
        FirebaseClient.getRecipes { result in
            switch result {
            case .success(let recipies):
                self.downloadedRecipes = recipies
            case .failure(let error):
                print(error)
            }
        }
    }
}
