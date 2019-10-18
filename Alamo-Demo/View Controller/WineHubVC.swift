//
//  WineHubVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 9/9/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Alamofire

class WineHubVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var arrayAllWinesListOne: [WineModel] = [WineModel]()
    var arrayAllWinesListTwo: [WineModel] = [WineModel]()
    var arrayAllWinesListThree: [WineModel] = [WineModel]()
    
    @IBOutlet weak var WineCollectionOne: UICollectionView!
    @IBOutlet weak var WineCollectionTwo: UICollectionView!
    @IBOutlet weak var WineCollectionThree: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWineData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == WineCollectionOne){
            return arrayAllWinesListOne.count
        }
        else if(collectionView == WineCollectionTwo){
            return arrayAllWinesListTwo.count
        }
        else if(collectionView == WineCollectionThree){
            return arrayAllWinesListThree.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == WineCollectionOne){
        let cell:WineHubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCell", for: indexPath) as! WineHubCell
        cell.lblName.text = arrayAllWinesListOne[indexPath.item].name
        cell.lblCategory.text = arrayAllWinesListOne[indexPath.item].category
        if(arrayAllWinesListOne[indexPath.item].image != "") {
            let url: URL = URL(string: arrayAllWinesListOne[indexPath.item].image)!
            cell.imgIcon.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
                ( image, error, cacheType, imageUrl) in
                if image != nil{
                    cell.imgIcon.clipsToBounds = true
                    cell.imgIcon.backgroundColor = .clear
                }
            })
        }
        return cell
        }
        else if(collectionView == WineCollectionTwo){
            let cell:WineHubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCellTwo", for: indexPath) as! WineHubCell
            cell.lblName.text = arrayAllWinesListTwo[indexPath.item].name
            cell.lblCategory.text = arrayAllWinesListTwo[indexPath.item].category
            if(arrayAllWinesListTwo[indexPath.item].image != "") {
                let url: URL = URL(string: arrayAllWinesListTwo[indexPath.item].image)!
                cell.imgIcon.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
                    ( image, error, cacheType, imageUrl) in
                    if image != nil{
                        cell.imgIcon.clipsToBounds = true
                        cell.imgIcon.backgroundColor = .clear
                    }
                })
            }
            return cell
        }
        else if(collectionView == WineCollectionThree){
            let cell:WineHubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCellThree", for: indexPath) as! WineHubCell
            cell.lblName.text = arrayAllWinesListThree[indexPath.item].name
            cell.lblCategory.text = arrayAllWinesListThree[indexPath.item].category
            if(arrayAllWinesListThree[indexPath.item].image != "") {
                let url: URL = URL(string: arrayAllWinesListThree[indexPath.item].image)!
                cell.imgIcon.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
                    ( image, error, cacheType, imageUrl) in
                    if image != nil{
                        cell.imgIcon.clipsToBounds = true
                        cell.imgIcon.backgroundColor = .clear
                    }
                })
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func fetchWineData(){
        Alamofire.request("https://mahajan-pooja.github.io/cocktail-booz-api/wine-category.json").responseJSON(completionHandler: {(response) in
            if response.result.isSuccess {
                let model: WineCategoryMain = WineCategoryMain.init(fromDictionary: (response.result.value as? NSDictionary)!)
                if (model.wineCategory.count) > 0 {
                    self.arrayAllWinesListOne.append(contentsOf: model.wineCategory[0].wine)
                    self.arrayAllWinesListTwo.append(contentsOf: model.wineCategory[1].wine)
                    self.arrayAllWinesListThree.append(contentsOf: model.wineCategory[2].wine)
                }
                self.WineCollectionOne.reloadData()
                self.WineCollectionTwo.reloadData()
                self.WineCollectionThree.reloadData()
            }else{
                print("failure error")
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == WineCollectionOne){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let WineBeerDetailVC: WineBeerDetailVC = storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as! WineBeerDetailVC
            WineBeerDetailVC.desc = arrayAllWinesListOne[indexPath.item].desc
            WineBeerDetailVC.descExtra = arrayAllWinesListOne[indexPath.item].descExtra
            WineBeerDetailVC.name = arrayAllWinesListOne[indexPath.item].name
            WineBeerDetailVC.img = arrayAllWinesListOne[indexPath.item].image
            self.present(WineBeerDetailVC, animated: true, completion: nil)
        }else if(collectionView == WineCollectionTwo){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let WineBeerDetailVC: WineBeerDetailVC = storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as! WineBeerDetailVC
            WineBeerDetailVC.desc = arrayAllWinesListTwo[indexPath.item].desc
            WineBeerDetailVC.descExtra = arrayAllWinesListTwo[indexPath.item].descExtra
            WineBeerDetailVC.name = arrayAllWinesListTwo[indexPath.item].name
            WineBeerDetailVC.img = arrayAllWinesListTwo[indexPath.item].image
            self.present(WineBeerDetailVC, animated: true, completion: nil)
        }else if(collectionView == WineCollectionThree){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let WineBeerDetailVC: WineBeerDetailVC = storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as! WineBeerDetailVC
            WineBeerDetailVC.desc = arrayAllWinesListThree[indexPath.item].desc
            WineBeerDetailVC.descExtra = arrayAllWinesListThree[indexPath.item].descExtra
            WineBeerDetailVC.name = arrayAllWinesListThree[indexPath.item].name
            WineBeerDetailVC.img = arrayAllWinesListThree[indexPath.item].image
            self.present(WineBeerDetailVC, animated: true, completion: nil)
        }
    }
}
