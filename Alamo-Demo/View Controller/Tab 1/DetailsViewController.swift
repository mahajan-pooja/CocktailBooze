//
//  DetailsViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/13/19.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.3, height: collectionView.frame.size.width/2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryCellView.layer.masksToBounds = true
        cell.categoryCellView.layer.cornerRadius = 20
        cell.categoryItemName.text = "Kir"
        cell.categoryItemType.text = "Strong"
        let url: URL = URL(string: "https://images.cocktailflow.com/v1/collection/w_300,h_270/collection_valentines_day.png")!
        cell.categoryItemImage.kf.setImage(with: url, placeholder: UIImage(named:""),  options: nil, progressBlock: nil, completionHandler: {
            ( image, error, cacheType, imageUrl) in
            if image != nil{
                cell.categoryItemImage.clipsToBounds = true
                cell.categoryItemImage.backgroundColor = .white
            }
        })
        cell.categoryCellView.layer.borderWidth = 1
        cell.categoryCellView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        cell.categoryCellView.layer.shadowColor = UIColor.gray.cgColor
        cell.categoryCellView.layer.shadowOpacity = 1
        cell.categoryCellView.layer.shadowOffset = CGSize.zero
        cell.categoryCellView.layer.shadowRadius = 5

        return cell
    }
}
