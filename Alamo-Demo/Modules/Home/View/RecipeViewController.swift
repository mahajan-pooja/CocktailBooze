import UIKit
import Firebase
import SwiftKeychainWrapper
import Alamofire

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var obj = [String: Any]()
    var ref: DocumentReference!
    var ingredients = [String]()
    var procedure = [String]()
    var favoritesArray: [String] = []
    var recipe: DetailCategoryModel?
    
    @IBOutlet weak var procedureTblviewHeight: NSLayoutConstraint!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var procedureTableView: UITableView!
    @IBOutlet weak var ingredientsTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recipeImgView: UIImageView!
    @IBOutlet weak var lblRecipeType: UILabel!
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBAction func btnAddFavoritesAction(_ sender: Any) {
        if let recipeName = recipe?.categoryName {
            if self.favoritesArray.contains(recipeName) {
                let user = Auth.auth().currentUser
                var email: String!
                
                if let user = user {
                    email = user.email
                } else {
                    email = KeychainWrapper.standard.string(forKey: "user-email")
                }
                ref = Firestore.firestore().collection("RecipeCollection").document(email)
                
                ref.updateData([
                    "regions": FieldValue.arrayRemove([recipeName])
                ])
                self.btnFavorite.setBackgroundImage(UIImage(named: "like"), for: .normal)
            } else {
                let user = Auth.auth().currentUser
                var email: String!
                
                if let user = user {
                    email = user.email
                } else {
                    email = KeychainWrapper.standard.string(forKey: "user-email")
                }
                ref = Firestore.firestore().collection("RecipeCollection").document(email)

                ref.updateData([
                    "regions": FieldValue.arrayUnion([recipeName])
                ])
                self.btnFavorite.setBackgroundImage(UIImage(named: "like (1)"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecipe()
        Firestore.firestore().collection("RecipeCollection").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.favoritesArray = document.data()["regions"]! as! [String]
                }
                if let recipeName = self.recipe?.categoryName {
                    if self.favoritesArray.contains(recipeName) {
                        self.btnFavorite.setBackgroundImage(UIImage(named: "like (1)"), for: .normal)
                    } else {
                        self.btnFavorite.setBackgroundImage(UIImage(named: "like"), for: .normal)
                    }
                }
            }
        }
    }
    
    private func getRecipe() {
        Alamofire.request(Constants.ExternalHyperlinks.recipe).responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                let model = RecipeDetailModel.init(fromDictionary: (response.result.value as? NSDictionary)!)
                self.ingredients.removeAll()
                self.procedure.removeAll()
                self.ingredients = model.ingredients
                self.procedure = model.procedure
                self.ingredientsTableView.reloadData()
                self.ingredientsTblViewHeight.constant = CGFloat(self.ingredients.count * 70)
                self.procedureTableView.reloadData()
                self.procedureTblviewHeight.constant = CGFloat(self.procedure.count * 70)
            } else {
                print("failure error")
            }
        })
    }
    
    private func setData() {
        self.lblRecipeName.text = recipe?.categoryName
        self.lblRecipeType.text = recipe?.categoryType
        
        if let recipeImage = recipe?.image, let url = URL(string: recipeImage) {
            Common.setImage(imageView: recipeImgView, url: url)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientsTableView {
            return ingredients.count
        } else {
            return procedure.count
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ingredientsTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as? IngredientsTableViewCell {
                cell.lblIngredients.text = ingredients[indexPath.row]
                Common.setShadow(view: cell.containerUIView)
                cell.containerUIView.layer.masksToBounds = false
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProcedureTableCell", for: indexPath) as? ProcedureTableCell {
                cell.lblProcedure.text = procedure[indexPath.row]
                Common.setShadow(view: cell.containerUIView)
                cell.containerUIView.layer.masksToBounds = false
                return cell
            }
        }
        return UITableViewCell()
    }
}
