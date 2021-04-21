import UIKit

class WineHubCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    func configureCell(wine: Wine) {
        lblName.text = wine.name
        lblCategory.text = wine.category
        setImage(imageURL: wine.image)
    }
    
    private func setImage(imageURL: String) {
        APIClient.downloadImage(url: imageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imgIcon.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self.imgIcon.image = UIImage(named: "cocktail")
                }
            }
        }
    }
}
