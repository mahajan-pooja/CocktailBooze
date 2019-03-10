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

class MainCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var MainCategoryCollectionView: UICollectionView!
    @IBOutlet weak var lblTitleDiscover: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("arrayAllProductList.count \(arrayAllProductList.count)")

            return arrayAllProductList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell:MainCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoryCollectionViewCell", for: indexPath) as! MainCategoryCollectionViewCell
            
            let objectList: SubCategoryModel = arrayAllProductList[indexPath.item]
            if(objectList.image != "") {
                let url: URL = URL(string: objectList.image)!
                cell.imgCategory.kf.setImage(with: url, placeholder: UIImage(named:""),  options: nil, progressBlock: nil, completionHandler: {
                    ( image, error, cacheType, imageUrl) in
                    if image != nil{
                        cell.imgCategory.clipsToBounds = true
                        cell.imgCategory.backgroundColor = .white
                    }
                })
            }
        cell.mainCategoryView.layer.shadowColor = UIColor.gray.cgColor
        cell.mainCategoryView.layer.shadowOpacity = 1
        cell.mainCategoryView.layer.shadowOffset = CGSize.zero
        cell.mainCategoryView.layer.shadowRadius = 5
            cell.lblMainCategoryName.text = objectList.productName
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemIndex = indexPath.row
        let cocktailDetail:DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        self.navigationController?.pushViewController(cocktailDetail, animated: true)
    }
    
    func fetchUserData(){
        DispatchQueue.main.async {
            Alamofire.request("http://demo0104834.mockable.io/category").responseJSON(completionHandler: {(response) in
                if response.result.isSuccess {
                    let model: MainModelCategory = MainModelCategory.init(fromDictionary: (response.result.value as? NSDictionary)!)
                    arrayAllProductList.removeAll()
                    if (model.result.count) > 0 {
                        arrayAllProductList.append(contentsOf: model.result)
                    }
                    self.MainCategoryCollectionView.reloadData()
                }else{
                    print("failure error")
                }
            })
        }
    }
}
