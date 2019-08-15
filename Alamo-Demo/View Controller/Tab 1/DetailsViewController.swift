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
    var arrayAllCategoryList: [DetailCategoryModel] = [DetailCategoryModel]()
    var prod_id: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        
        navigationController?.setNavigationBarHidden(false, animated: true)

        lblDetailsTitle.text = arrayAllProductList[itemIndex].productName
        lblDetailsDesc.text = "Somewhere in Oprah's mantra is making time for yourself…with an adult beverage.!!"
        let url: URL = URL(string: arrayAllProductList[itemIndex].image)!
        imgDetailView.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
            ( image, error, cacheType, imageUrl) in
            if image != nil{
                self.imgDetailView.clipsToBounds = true
                self.imgDetailView.backgroundColor = .white
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayAllCategoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.3, height: collectionView.frame.size.width/2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let url: URL = URL(string: arrayAllCategoryList[indexPath.row].image)!
        cell.categoryItemImage.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
            ( image, error, cacheType, imageUrl) in
            if image != nil{
                cell.categoryItemImage.clipsToBounds = true
                cell.categoryItemImage.backgroundColor = .white
            }
        })
        cell.categoryCellView.layer.masksToBounds = true
        cell.categoryCellView.layer.cornerRadius = 20
        cell.categoryItemName.text = arrayAllCategoryList[indexPath.row].cat_name//"Kir"
        cell.categoryItemType.text = arrayAllCategoryList[indexPath.row].cat_type//"Strong"
        cell.categoryCellView.layer.borderWidth = 1
        cell.categoryCellView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        return cell
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
    func loadJson(filename:String){
        let parentList: [NSDictionary] = ((self.readJSONFromFile(fileName: filename) as? [NSDictionary])!)
        let arrayList: [NSDictionary] = parentList[0].value(forKey: "result") as! Array
        
        if (arrayList.count) > 0 {
            let model: CategoryModel = CategoryModel.init(fromDictionary: arrayList[0])
            arrayAllCategoryList.append(contentsOf: model.category)
        }
        self.categoryCollectionView.reloadData()
        
        //        DispatchQueue.main.async {
        //            Alamofire.request("http://demo0104834.mockable.io/category").responseJSON(completionHandler: {(response) in
        //                if response.result.isSuccess {
        //                    let model: MainModelCategory = MainModelCategory.init(fromDictionary: (response.result.value as? NSDictionary)!)
        //                    arrayAllProductList.removeAll()
        //                    if (model.result.count) > 0 {
        //                        arrayAllProductList.append(contentsOf: model.result)
        //                    }
        //                    self.MainCategoryCollectionView.reloadData()
        //                }else{
        //                    print("failure error")
        //                }
        //            })
        //        }
    }
    func fetchUserData(){
        //print("prod_id \(prod_id)")
        let recipe_id = prod_id!
        
        if(recipe_id == "1"){
            loadJson(filename: "valentine")
        }else if(recipe_id == "2"){
            loadJson(filename: "summer")
        }else if(recipe_id == "3"){
            loadJson(filename: "spring")
        }else if(recipe_id == "4"){
            loadJson(filename: "slushy")
        }
    }
}
