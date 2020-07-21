//
//  DetailsViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/13/19.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var arrayAllCategoryList: [DetailCategoryModel] = [DetailCategoryModel]()
    var productId: String!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var lblDetailsTitle: UILabel!
    @IBOutlet weak var imgDetailView: UIImageView!
    @IBOutlet weak var lblDetailsDesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        navigationController?.setNavigationBarHidden(false, animated: true)
        lblDetailsTitle.text = arrayAllProductList[itemIndex].productName
        lblDetailsDesc.text = "Somewhere in Oprah's mantra is making time for yourself…with an adult beverage.!!"
        let url: URL = URL(string: arrayAllProductList[itemIndex].image)!
        imgDetailView.kf.setImage(with: url, placeholder: UIImage(named: "cocktail"), options: nil, progressBlock: nil, completionHandler: { (image, _, _, _) in
            if image != nil {
                self.imgDetailView.clipsToBounds = true
                self.imgDetailView.backgroundColor = .white
            }
        })
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
            recipeViewController.recipeName = arrayAllCategoryList[indexPath.row].categoryName!
            recipeViewController.recipeImage = arrayAllCategoryList[indexPath.row].image!
            recipeViewController.recipeType = arrayAllCategoryList[indexPath.row].categoryType!
            self.navigationController?.pushViewController(recipeViewController, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell {
            let url: URL = URL(string: arrayAllCategoryList[indexPath.row].image)!
            cell.categoryItemImage.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: { (image, _, _, _) in
                if image != nil {
                    cell.categoryItemImage.clipsToBounds = true
                }
            })

            cell.categoryItemName.text = arrayAllCategoryList[indexPath.row].categoryName
            cell.categoryItemType.text = arrayAllCategoryList[indexPath.row].categoryType
            cell.categoryCellView.layer.shadowColor = UIColor.red.cgColor
            cell.categoryCellView.layer.shadowOpacity = 0.5
            cell.categoryCellView.layer.shadowOffset = CGSize.zero
            cell.categoryCellView.layer.shadowRadius = 1.5
            cell.categoryCellView.layer.masksToBounds = false
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
        let parentList: [NSDictionary] = ((self.readJSONFromFile(fileName: filename) as? [NSDictionary])!)
        let arrayList: [NSDictionary] = parentList[0].value(forKey: "result") as! Array

        if (arrayList.count) > 0 {
            let model: CategoryModel = CategoryModel.init(fromDictionary: arrayList[0])
            arrayAllCategoryList.append(contentsOf: model.category)
        }
        self.categoryCollectionView.reloadData()
    }
    
    func fetchUserData() {
        let recipeId = productId!
        if recipeId == "1" {
            loadJson(filename: "valentine")
        } else if recipeId == "2" {
            loadJson(filename: "summer")
        } else if recipeId == "3" {
            loadJson(filename: "spring")
        } else if recipeId == "4" {
            loadJson(filename: "slushy")
        }
    }
}
