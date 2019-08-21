//
//  MainCategoryViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/11/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

var itemIndex = 0
var arrayAllProductList: [SubCategoryModel] = [SubCategoryModel]()
var arrayAllCountryList: [SubCategoryModel] = [SubCategoryModel]()

class MainCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var objMainCategory: MainModelCategory!
    @IBOutlet weak var MainCategoryCollectionView: UICollectionView!
    @IBOutlet weak var lblTitleDiscover: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMainCategoryData()
        fetchCountryCategoryData()
    }
    override func viewWillLayoutSubviews() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == MainCategoryCollectionView){
            return arrayAllProductList.count
        }else{
            return arrayAllCountryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == MainCategoryCollectionView){
           let cell:MainCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoryCollectionViewCell", for: indexPath) as! MainCategoryCollectionViewCell
            
            let objectList: SubCategoryModel = arrayAllProductList[indexPath.item]
            if(objectList.image != "") {
                let url: URL = URL(string: objectList.image)!
                cell.imgCategory.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
                    ( image, error, cacheType, imageUrl) in
                    if image != nil{
                        cell.imgCategory.clipsToBounds = true
                        cell.imgCategory.backgroundColor = .white
                    }
                })
            }
            cell.mainCategoryView.layer.shadowColor = UIColor.gray.cgColor
            cell.mainCategoryView.layer.shadowOpacity = 0.8
            cell.mainCategoryView.layer.shadowOffset = CGSize.zero
            cell.mainCategoryView.layer.shadowRadius = 5
            cell.lblMainCategoryName.text = objectList.productName
            
            return cell
        }else{
            let cell:SliderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
            let objectList: SubCategoryModel = arrayAllCountryList[indexPath.item]
            cell.lblCategoryName.text = objectList.productName
            if(objectList.image != "") {
                let url: URL = URL(string: objectList.image)!
                cell.imgCocktailIcon.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
                    ( image, error, cacheType, imageUrl) in
                    if image != nil{
                        cell.imgCocktailIcon.clipsToBounds = true
                        //cell.imgCocktailIcon.backgroundColor = .white
                    }
                })
            }
            
            cell.sliderCategoryView.layer.shadowColor = UIColor.gray.cgColor
            cell.sliderCategoryView.layer.shadowOpacity = 0.5
            cell.sliderCategoryView.layer.shadowOffset = CGSize.zero
            cell.sliderCategoryView.layer.shadowRadius = 3
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == MainCategoryCollectionView){
            let yourWidth = collectionView.bounds.width/2.0
            let yourHeight = yourWidth
            
            return CGSize(width: yourWidth, height: yourHeight)
        }else{
            return CGSize(width: collectionView.bounds.width/2.0 - 10, height: collectionView.bounds.width/2.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == MainCategoryCollectionView){
            itemIndex = indexPath.row
            let cocktailDetail:DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            cocktailDetail.prod_id = arrayAllProductList[indexPath.row].productId!
            self.navigationController?.pushViewController(cocktailDetail, animated: true)
        }else{
            
        }
    }
    
    func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
               // print(json!)
            } catch {
                // Handle error here
            }
        }
        return json
    }
    
    func fetchMainCategoryData(){
//        let parentList: [NSDictionary] = ((self.readJSONFromFile(fileName: "main-category") as? [NSDictionary])!)
//        let arrayList: [NSDictionary] = parentList[0].value(forKey: "result") as! Array
//        arrayAllProductList.removeAll()
//        if (arrayList.count) > 0 {
//            let model: MainModelCategory = MainModelCategory.init(fromDictionary: arrayList[0])
//            arrayAllProductList.append(contentsOf: model.recipe)
//        }
//        self.MainCategoryCollectionView.reloadData()
        
//        DispatchQueue.main.async {
            Alamofire.request("https://mahajan-pooja.github.io/cocktail-booz-api/main-category.json").responseJSON(completionHandler: {(response) in
                if response.result.isSuccess {
                    print("response.result.value \(response.result.value)")
                    let model: MainModelCategory = MainModelCategory.init(fromDictionary: (response.result.value as? NSDictionary)!)
                    arrayAllProductList.removeAll()
                    if (model.recipe.count) > 0 {
                        arrayAllProductList.append(contentsOf: model.recipe)
                    }
                    self.MainCategoryCollectionView.reloadData()
                }else{
                    print("failure error")
                }
            })
//        }
    }
    
    func fetchCountryCategoryData(){
        Alamofire.request("https://mahajan-pooja.github.io/cocktail-booz-api/country-category.json").responseJSON(completionHandler: {(response) in
            if response.result.isSuccess {
                print("response.result.value \(response.result.value)")
                let model: MainModelCategory = MainModelCategory.init(fromDictionary: (response.result.value as? NSDictionary)!)
                arrayAllCountryList.removeAll()
                if (model.recipe.count) > 0 {
                    arrayAllCountryList.append(contentsOf: model.recipe)
                }
                self.sliderCollectionView.reloadData()
            }else{
                print("failure error")
            }
        })
    }
}