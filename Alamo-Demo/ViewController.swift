//
//  ViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 11/14/18.
//  Copyright © 2018 GenistaBio. All rights reserved.
//
//testing
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDetail.text = dietCatDesc[myIndex]
        fetchUserData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.lblRecipeName?.text = "Pav Bhaji"
        cell.imageView.image = UIImage(named: "food_img")
        return cell
    }
    func fetchUserData(){
        let param = cat_param[myIndex]
        DispatchQueue.main.async {
            Alamofire.request("http://api.edamam.com/search?q=&app_id=bc2cc635&app_key=2fbcb964bbd1268576b89857a499b956&diet=\(param)").responseJSON(completionHandler: {(response) in
                //Alamofire.request("https://raw.githubusercontent.com/arimunandar/API/master/users.json").responseJSON(completionHandler: {(response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    //let data = json['']
                    print(json["hits"])
                    for recipe in json["hits"]{
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}

