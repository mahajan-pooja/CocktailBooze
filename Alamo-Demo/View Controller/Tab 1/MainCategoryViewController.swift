//
//  MainCategoryViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

var itemIndex = 0
var arrayAllProductList = [SubCategoryModel]()
var arrayAllCountryList = [SubCategoryModel]()

class MainCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var objMainCategory: MainModelCategory!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMainCategoryData()
        fetchCountryCategoryData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainCategoryCollectionView {
            return arrayAllProductList.count
        } else {
            return arrayAllCountryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainCategoryCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoryCollectionViewCell", for: indexPath) as? MainCategoryCollectionViewCell {
                let objectList: SubCategoryModel = arrayAllProductList[indexPath.item]
                if let image = objectList.image, let url = URL(string: image) {
                    Common.setImage(imageView: cell.imgCategory, url: url)
                }
                Common.setShadow(view: cell.mainCategoryView)
                cell.lblMainCategoryName.text = objectList.productName
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as? SliderCollectionViewCell {
                let objectList: SubCategoryModel = arrayAllCountryList[indexPath.item]
                cell.lblCategoryName.text = objectList.productName
                if let image = objectList.image, let url = URL(string: image) {
                    Common.setImage(imageView: cell.imgCocktailIcon, url: url)
                }
                Common.setShadow(view: cell.sliderCategoryView)
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainCategoryCollectionView {
            let yourWidth = collectionView.bounds.width / 2.0
            let yourHeight = yourWidth
            return CGSize(width: yourWidth, height: yourHeight)
        } else {
            return CGSize(width: collectionView.bounds.width / 2.0 - 10, height: collectionView.bounds.width / 2.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainCategoryCollectionView {
            itemIndex = indexPath.row
            if let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
                detailsViewController.recipeID = arrayAllProductList[indexPath.row].productId!
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }
    }
    
    private func fetchMainCategoryData() {
        Alamofire.request(Constants.ExternalHyperlinks.mainCategory).responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                let model: MainModelCategory = MainModelCategory.init(fromDictionary: (response.result.value as? NSDictionary)!)
                arrayAllProductList.removeAll()
                if !model.recipe.isEmpty {
                    arrayAllProductList.append(contentsOf: model.recipe)
                }
                self.mainCategoryCollectionView.reloadData()
            } else {
                print("failure error")
            }
        })
    }
    
    private func fetchCountryCategoryData() {
        Alamofire.request(Constants.ExternalHyperlinks.countryCategory).responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                let model: MainModelCategory = MainModelCategory.init(fromDictionary: (response.result.value as? NSDictionary)!)
                arrayAllCountryList.removeAll()
                if !model.recipe.isEmpty {
                    arrayAllCountryList.append(contentsOf: model.recipe)
                }
                self.sliderCollectionView.reloadData()
            } else {
                print("failure error")
            }
        })
    }
}
