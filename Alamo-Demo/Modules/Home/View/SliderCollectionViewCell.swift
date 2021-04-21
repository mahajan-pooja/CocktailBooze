import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderCategoryView: UIView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgCocktailIcon: UIImageView!
    
    func configureCell(countryCategory: CountryCategory) {
        lblCategoryName.text = countryCategory.countryName
        setImage(imageURL: countryCategory.countryImage)
    }
    
    private func setImage(imageURL: String) {
        APIClient.downloadImage(url: imageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imgCocktailIcon.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self.imgCocktailIcon.image = UIImage(named: "cocktail")
                }
            }
        }
    }
}
