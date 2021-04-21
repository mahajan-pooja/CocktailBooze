import UIKit

class MainCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainCategoryView: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblMainCategoryName: UILabel!
    
    func configureCell(mainCategory: MainCategory) {
        lblMainCategoryName.text = mainCategory.categoryName
        setImage(imageURL: mainCategory.categoryImage)
    }
    
    private func setImage(imageURL: String) {
        APIClient.downloadImage(url: imageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imgCategory.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self.imgCategory.image = UIImage(named: "cocktail")
                }
            }
        }
    }
}
