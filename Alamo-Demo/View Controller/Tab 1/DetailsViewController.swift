//
//  DetailsViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/13/19.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var arrayAllCategoryList = [DetailCategoryModel]()
    var recipeID: String?
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var lblDetailsTitle: UILabel!
    @IBOutlet weak var imgDetailView: UIImageView!
    @IBOutlet weak var lblDetailsDesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipeData()
        navigationController?.setNavigationBarHidden(false, animated: true)
        lblDetailsTitle.text = arrayAllProductList[itemIndex].productName
        lblDetailsDesc.text = Constants.quote
        
        if let url = URL(string: arrayAllProductList[itemIndex].image) {
            Common.setImage(imageView: imgDetailView, url: url)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayAllCategoryList.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 2.0
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemIndex = indexPath.row
        if let recipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController {
            recipeViewController.recipe = arrayAllCategoryList[indexPath.row]
            self.navigationController?.pushViewController(recipeViewController, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell {
            if let url: URL = URL(string: arrayAllCategoryList[indexPath.row].image) {
                Common.setImage(imageView: cell.categoryItemImage, url: url)
            }
            cell.categoryItemName.text = arrayAllCategoryList[indexPath.row].categoryName
            cell.categoryItemType.text = arrayAllCategoryList[indexPath.row].categoryType
            Common.setShadow(view: cell.categoryCellView)
            return cell
        }
        return UICollectionViewCell()
    }

    func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
    
    func loadJson(filename: String) {
        if let parentList: [NSDictionary] = (self.readJSONFromFile(fileName: filename) as? [NSDictionary]) {
            if let arrayList: [NSDictionary] = parentList[0].value(forKey: "result") as? Array {
                if !arrayList.isEmpty {
                    let model = CategoryModel.init(fromDictionary: arrayList[0])
                    arrayAllCategoryList.append(contentsOf: model.category)
                }
                self.categoryCollectionView.reloadData()
            }
        }
    }
    
    private func fetchRecipeData() {
        let recipeId = recipeID
        switch recipeId {
        case "1":
            loadJson(filename: "valentine")
        case "2":
            loadJson(filename: "summer")
        case "3":
            loadJson(filename: "spring")
        case "4":
            loadJson(filename: "slushy")
        default:
            loadJson(filename: "valentine")
        }
    }
}
