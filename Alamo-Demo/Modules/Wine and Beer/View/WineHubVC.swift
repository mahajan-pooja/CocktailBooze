import UIKit
import Alamofire

class WineHubVC: UIViewController {
    
    @IBOutlet weak var wineCollectionOne: UICollectionView!
    @IBOutlet weak var wineCollectionTwo: UICollectionView!
    @IBOutlet weak var wineCollectionThree: UICollectionView!
    @IBOutlet weak var lblSectionOne: UILabel!
    @IBOutlet weak var lblSectionTwo: UILabel!
    @IBOutlet weak var lblSectionThree: UILabel!
    
    private var wineViewModel: WineViewModel = WineViewModel()
    private var sectionOne: WineSection?
    private var sectionTwo: WineSection?
    private var sectionThree: WineSection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWineCategories()
    }
}

private extension WineHubVC {
    func fetchWineCategories() {
        wineViewModel.fetchWineCategory { wineCategory in
            self.configureWineCategoryViews(wineCategory: wineCategory)
        }
    }
    
    func configureWineCategoryViews(wineCategory: WineCategory) {
        sectionOne = wineCategory.sectionOne
        sectionTwo = wineCategory.sectionTwo
        sectionThree = wineCategory.sectionThree
        
        DispatchQueue.main.async {
            self.lblSectionOne.text = wineCategory.sectionOne.name
            self.lblSectionTwo.text = wineCategory.sectionTwo.name
            self.lblSectionThree.text = wineCategory.sectionThree.name
            
            self.wineCollectionOne.reloadData()
            self.wineCollectionTwo.reloadData()
            self.wineCollectionThree.reloadData()
        }
    }
}

extension WineHubVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case wineCollectionOne: return sectionOne?.wines.count ?? 0
        case wineCollectionTwo: return sectionTwo?.wines.count ?? 0
        case wineCollectionThree: return sectionThree?.wines.count ?? 0
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case wineCollectionOne:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCell", for: indexPath) as? WineHubCell {
                if let wine = sectionOne?.wines[indexPath.item] {
                    cell.configureCell(wine: wine)
                }
                return cell
            }
        case wineCollectionTwo:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCellTwo", for: indexPath) as? WineHubCell {
                if let wine = sectionTwo?.wines[indexPath.item] {
                    cell.configureCell(wine: wine)
                }
                return cell
            }
        case wineCollectionThree:
            if let cell: WineHubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCellThree", for: indexPath) as? WineHubCell {
                if let wine = sectionThree?.wines[indexPath.item] {
                    cell.configureCell(wine: wine)
                }
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case wineCollectionOne:
            if let wineBeerDetailVC = Constants.storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as? WineBeerDetailVC {
                wineBeerDetailVC.wineDetails = sectionOne?.wines[indexPath.item]
                self.present(wineBeerDetailVC, animated: true, completion: nil)
            }
        case wineCollectionTwo:
            if let wineBeerDetailVC = Constants.storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as? WineBeerDetailVC {
                wineBeerDetailVC.wineDetails = sectionTwo?.wines[indexPath.item]
                self.present(wineBeerDetailVC, animated: true, completion: nil)
            }
        case wineCollectionThree:
            if let wineBeerDetailVC = Constants.storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as? WineBeerDetailVC {
                wineBeerDetailVC.wineDetails = sectionThree?.wines[indexPath.item]
                self.present(wineBeerDetailVC, animated: true, completion: nil)
            }
        default:
            return
        }
    }
}
