//
//  DetailsViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/13/19.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var lblDetailsTitle: UILabel!
    @IBOutlet weak var imgDetailView: UIImageView!
    @IBOutlet weak var lblDetailsDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblDetailsTitle.text = arrayAllProductList[itemIndex].productName
        lblDetailsDesc.text = "Here goes category description!!"
        let url: URL = URL(string: arrayAllProductList[itemIndex].image)!
        imgDetailView.kf.setImage(with: url, placeholder: UIImage(named:""),  options: nil, progressBlock: nil, completionHandler: {
            ( image, error, cacheType, imageUrl) in
            if image != nil{
                self.imgDetailView.clipsToBounds = true
                self.imgDetailView.backgroundColor = .white
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.categoryItemName.text = "Kir"
        cell.categoryItemType.text = "Strong"
        cell.categoryItemImage.image = UIImage(named: "food_img")
        return cell
    }
}
