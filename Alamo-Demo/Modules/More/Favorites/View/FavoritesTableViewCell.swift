import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var btnRemoveFevorites: UIButton!
    @IBOutlet weak var lblFavoriteName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(favoritesData: String) {
        containerUIView.layer.shadowColor = UIColor.red.cgColor
        containerUIView.layer.shadowOpacity = 0.5
        containerUIView.layer.shadowOffset = CGSize.zero
        containerUIView.layer.shadowRadius = 1.5
        containerUIView.layer.cornerRadius = containerUIView.frame.height / 15
        
        lblFavoriteName.text = favoritesData
    }
}
