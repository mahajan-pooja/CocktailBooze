//
//  DetailsViewController.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/13/19.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var lblDetailsTitle: UILabel!
    @IBOutlet weak var imgDetailView: UIImageView!
    @IBOutlet weak var lblDetailsDesc: UILabel!

    private var detailCategoryList = [DetailCategoryModel]()
    var selectedMainCategory: MainCategory?
    let detailsViewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        guard let selectedMainCategory = selectedMainCategory else {
            return
        }
        configureHeaderView(selectedMainCategory: selectedMainCategory)
        detailsViewModel.fetchRecipeData(categoryId: selectedMainCategory.categoryId) { result in
            self.detailCategoryList = result
            DispatchQueue.main.async {
                self.categoryCollectionView.reloadData()
            }
        }
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailCategoryList.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 2.0
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let recipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController {
            recipeViewController.recipe = detailCategoryList[indexPath.row]
            self.navigationController?.pushViewController(recipeViewController, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell {
            cell.configureCell(detailCategory: detailCategoryList[indexPath.row])
            Common.setShadow(view: cell.categoryCellView)
            return cell
        }
        return UICollectionViewCell()
    }
}

private extension DetailsViewController {
    func configureHeaderView(selectedMainCategory: MainCategory) {
        lblDetailsTitle.text = selectedMainCategory.categoryName
        lblDetailsDesc.text = Constants.quote
        setImage(imageURL: selectedMainCategory.categoryImage)
    }
    
    func setImage(imageURL: String) {
        APIClient.downloadImage(url: imageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imgDetailView.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self.imgDetailView.image = UIImage(named: "cocktail")
                }
            }
        }
    }
}
