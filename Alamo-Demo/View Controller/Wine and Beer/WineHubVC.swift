//
//  WineHubVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 9/9/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Alamofire

class WineHubVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var arrayAllWinesListOne = [WineModel]()
    private var arrayAllWinesListTwo = [WineModel]()
    private var arrayAllWinesListThree = [WineModel]()
    
    @IBOutlet weak var wineCollectionOne: UICollectionView!
    @IBOutlet weak var wineCollectionTwo: UICollectionView!
    @IBOutlet weak var wineCollectionThree: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWineData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wineCollectionOne {
            return arrayAllWinesListOne.count
        } else if collectionView == wineCollectionTwo {
            return arrayAllWinesListTwo.count
        } else if collectionView == wineCollectionThree {
            return arrayAllWinesListThree.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wineCollectionOne {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCell", for: indexPath) as? WineHubCell {
                cell.lblName.text = arrayAllWinesListOne[indexPath.item].name
                cell.lblCategory.text = arrayAllWinesListOne[indexPath.item].category
                if let image = arrayAllWinesListOne[indexPath.item].image, let url = URL(string: image) {
                    Common.setImage(imageView: cell.imgIcon, url: url)
                }
                return cell
            }
        } else if collectionView == wineCollectionTwo {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCellTwo", for: indexPath) as? WineHubCell {
                cell.lblName.text = arrayAllWinesListTwo[indexPath.item].name
                cell.lblCategory.text = arrayAllWinesListTwo[indexPath.item].category
                
                if let image = arrayAllWinesListTwo[indexPath.item].image, let url = URL(string: image) {
                     Common.setImage(imageView: cell.imgIcon, url: url)
                }
                return cell
            }
        } else if collectionView == wineCollectionThree {
            if let cell: WineHubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCellThree", for: indexPath) as? WineHubCell {
                cell.lblName.text = arrayAllWinesListThree[indexPath.item].name
                cell.lblCategory.text = arrayAllWinesListThree[indexPath.item].category
                
                if let image = arrayAllWinesListThree[indexPath.item].image, let url = URL(string: image) {
                    Common.setImage(imageView: cell.imgIcon, url: url)
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }

    private func fetchWineData() {
        Alamofire.request(Constants.ExternalHyperlinks.wineCategory).responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                let model: WineCategoryMain = WineCategoryMain.init(fromDictionary: (response.result.value as? NSDictionary)!)
                if (model.wineCategory.count) > 0 {
                    self.arrayAllWinesListOne.append(contentsOf: model.wineCategory[0].wine)
                    self.arrayAllWinesListTwo.append(contentsOf: model.wineCategory[1].wine)
                    self.arrayAllWinesListThree.append(contentsOf: model.wineCategory[2].wine)
                }
                self.wineCollectionOne.reloadData()
                self.wineCollectionTwo.reloadData()
                self.wineCollectionThree.reloadData()
            } else {
                print("failure error")
            }
        })
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == wineCollectionOne {
            if let wineBeerDetailVC = Constants.storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as? WineBeerDetailVC {
                wineBeerDetailVC.wineDetails = arrayAllWinesListOne[indexPath.item]
                self.present(wineBeerDetailVC, animated: true, completion: nil)
            }
        } else if collectionView == wineCollectionTwo {
            if let wineBeerDetailVC = Constants.storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as? WineBeerDetailVC {
                wineBeerDetailVC.wineDetails = arrayAllWinesListTwo[indexPath.item]
                self.present(wineBeerDetailVC, animated: true, completion: nil)
            }
        } else if collectionView == wineCollectionThree {
            if let wineBeerDetailVC = Constants.storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as? WineBeerDetailVC {
                wineBeerDetailVC.wineDetails = arrayAllWinesListThree[indexPath.item]
                self.present(wineBeerDetailVC, animated: true, completion: nil)
            }
        }
    }
}
