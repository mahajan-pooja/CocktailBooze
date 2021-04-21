import Foundation

class WineViewModel: NSObject {
    private var apiService = APIService()
    
    func fetchWineCategory(completion: @escaping (WineCategory) -> Void) {
        guard let url = URL(string: Constants.ExternalHyperlinks.wineCategory) else {
            return
        }
        
        APIClient.getWineCategory(url: url) { result in
            switch result {
            case .success(let wineCategory):
                completion(wineCategory)
            case .failure(let error):
                print(error)
            }
        }
    }
}
