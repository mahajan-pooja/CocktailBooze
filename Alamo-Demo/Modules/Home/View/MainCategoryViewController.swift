import UIKit
import Alamofire
import Kingfisher

class MainCategoryViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!
    
    private var mainCategoryViewModel: MainCategoryViewModel = MainCategoryViewModel()
    private var mainCategory: [MainCategory] = [MainCategory]()
    private var countryCategory: [CountryCategory] = [CountryCategory]()
    private var homeCategory: HomeCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCategoryViewModel.delegate = self
        mainCategoryViewModel.fetchHomeCategory()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension MainCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == mainCategoryCollectionView ? mainCategory.count : countryCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainCategoryCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoryCollectionViewCell", for: indexPath) as? MainCategoryCollectionViewCell {
                cell.configureCell(mainCategory: mainCategory[indexPath.row])
                Common.setShadow(view: cell.mainCategoryView)
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as? SliderCollectionViewCell {
                cell.configureCell(countryCategory: countryCategory[indexPath.row])
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
            if let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
                detailsViewController.selectedMainCategory = mainCategory[indexPath.row]
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }
    }
}

extension MainCategoryViewController: MainCategoryViewModelDelegate {
    func loadHomeCategory() {
        homeCategory = mainCategoryViewModel.homeCategory
        countryCategory = homeCategory?.country ?? []
        mainCategory = homeCategory?.main ?? []
        
        DispatchQueue.main.async {
            self.mainCategoryCollectionView.reloadData()
            self.sliderCollectionView.reloadData()
        }
    }
}
