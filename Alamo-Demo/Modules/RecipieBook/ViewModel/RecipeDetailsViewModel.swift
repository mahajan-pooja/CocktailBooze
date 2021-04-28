import Foundation

protocol RecipeDetailsDelegate: class {
    func loadRecipeDetails()
}

class RecipeDetailsViewModel: NSObject {
    weak var delegate: RecipeDetailsDelegate?
    
    var recipeDetails: [String: Any] = [:] {
        didSet {
            delegate?.loadRecipeDetails()
        }
    }
    
    func getRecipeDetails(selectedRecipe: RecipeModel) {
        FirebaseClient.getRecipeDetails(selectedRecipe: selectedRecipe) { result in
            switch result {
            case .success(let recipeDetails):
                self.recipeDetails = recipeDetails
            case .failure(let error):
                print(error)
            }
        }
    }
}
