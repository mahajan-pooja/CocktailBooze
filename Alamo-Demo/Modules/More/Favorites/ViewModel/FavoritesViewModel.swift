import Foundation

protocol FavoritesDelegate: class {
    func loadFavorites()
}

class FavoritesViewModel: NSObject {
    weak var delegate: FavoritesDelegate?
    
    var favoritesArray: [String] = [] {
        didSet {
            delegate?.loadFavorites()
        }
    }
    
    func getFavorites() {
        FirebaseClient.getFavorites { result in
            switch result {
            case .success(let favorites):
                self.favoritesArray = favorites
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeFavorites(data: String) {
        FirebaseClient.removeFavorites(data: data) {
            self.getFavorites()
        }        
    }
}
