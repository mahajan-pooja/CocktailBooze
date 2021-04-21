import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryCellView: UIView!
    @IBOutlet weak var categoryItemType: UILabel!
    @IBOutlet weak var categoryItemName: UILabel!
    @IBOutlet weak var categoryItemImage: UIImageView!
    
    func configureCell(detailCategory: DetailCategoryModel) {
        if let url: URL = URL(string: detailCategory.image) {
            Common.setImage(imageView: categoryItemImage, url: url)
        }
        categoryItemName.text = detailCategory.categoryName
        categoryItemType.text = detailCategory.categoryType
    }
}
