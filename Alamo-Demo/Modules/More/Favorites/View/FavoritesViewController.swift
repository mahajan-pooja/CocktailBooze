import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tblViewFavorites: UITableView!
    
    private var favoritesArray: [String] = []
    private let favoritesViewModel = FavoritesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 255.0 / 255.0, green: 223.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
        favoritesViewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesViewModel.getFavorites()
    }
    
    @objc
    func btnRemoveFavoritesAction(sender: UIButton) {
        let data = favoritesArray[sender.tag]
        favoritesViewModel.removeFavorites(data: data)
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath)
        
        if let favoritesTableViewCell = cell as? FavoritesTableViewCell {
            favoritesTableViewCell.btnRemoveFevorites.tag = indexPath.row
            favoritesTableViewCell.btnRemoveFevorites.addTarget(self, action: #selector(btnRemoveFavoritesAction(sender:)), for: .touchUpInside)
            favoritesTableViewCell.configureCell(favoritesData: favoritesArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension FavoritesViewController: FavoritesDelegate {
    func loadFavorites() {
        favoritesArray = favoritesViewModel.favoritesArray
        tblViewFavorites.reloadData()
    }
}
