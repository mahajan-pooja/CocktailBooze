import UIKit
import Firebase

class RecipeBookTableViewCell: UITableViewCell {

    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var imgRecipe: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(recipe: RecipeModel) {
        lblRecipeName.text = recipe.recipeName
        if recipe.recipeImage != nil {
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            let imageRef = Storage.storage().reference().child("images/\(recipe.recipeImage!)")
            imageRef.getData(maxSize: 50 * 1024 * 1024) { data, error in
                if let error = error {
                    print("error \(error)")
                } else {
                    self.imgRecipe.image = UIImage(data: data!)
                }
            }
        } else {
           imgRecipe.image = UIImage(named: "cocktail")
        }
    }
}
