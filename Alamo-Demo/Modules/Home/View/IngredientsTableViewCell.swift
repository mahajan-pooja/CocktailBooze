import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var lblIngredients: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
