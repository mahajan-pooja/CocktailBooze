import UIKit
import Firebase
import SwiftKeychainWrapper

class RecipeDetailVC: UIViewController {
    
    @IBOutlet weak var imgRecipeIcon: UIImageView!
    @IBOutlet weak var lblRecipeType: UILabel!
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var tblProcedureHeight: NSLayoutConstraint!
    @IBOutlet weak var tblIngreHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewProcedure: UITableView!
    @IBOutlet weak var tblViewIngredients: UITableView!
    
    var selectedRecipe: RecipeModel!
    var ingredients = [String]()
    var procedure = [String]()
    var recipeDetailsViewModel = RecipeDetailsViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        recipeDetailsViewModel.delegate = self
        recipeDetailsViewModel.getRecipeDetails(selectedRecipe: selectedRecipe)
        configureHeaderView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureHeaderView() {
        lblRecipeName.text = selectedRecipe.recipeName
        lblRecipeType.text = selectedRecipe.recipeType
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        let imageRef = Storage.storage().reference().child("images/\(self.selectedRecipe.recipeImage!)")
        imageRef.getData(maxSize: 50 * 1024 * 1024) { data, error in
            if let error = error {
                print("error \(error)")
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.imgRecipeIcon.image = image
            }
        }
    }
}

extension RecipeDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblViewIngredients {
            return 60
        } else {
            return 100
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewIngredients {
            return ingredients.count
        } else {
            return procedure.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewIngredients {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath) as? IngredientsCell {
                cell.lblIngredients.text = ingredients[indexPath.row]
                Common.setShadow(view: cell.containerUIView)
                cell.containerUIView.layer.masksToBounds = false
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProcedureCell", for: indexPath) as? ProcedureCell {
                cell.lblProcedure.text = procedure[indexPath.row]
                Common.setShadow(view: cell.containerUIView)
                cell.containerUIView.layer.masksToBounds = false
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension RecipeDetailVC: RecipeDetailsDelegate {
    func loadRecipeDetails() {
        let model: RecipeDetailModel = RecipeDetailModel.init(fromDictionary: recipeDetailsViewModel.recipeDetails as NSDictionary)
        ingredients = model.ingredients
        procedure = model.procedure
        
        tblIngreHeight.constant = CGFloat(ingredients.count * 60)
        tblProcedureHeight.constant = CGFloat(procedure.count * 100)
        
        tblViewProcedure.reloadData()
        tblViewIngredients.reloadData()
    }
}
