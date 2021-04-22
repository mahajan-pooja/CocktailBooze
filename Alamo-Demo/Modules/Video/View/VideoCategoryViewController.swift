import UIKit
import Alamofire
import Kingfisher
import AVKit

class VideoCategoryViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var videoCategoryTableView: UITableView!
    
    private var videoViewModel: VideoViewModel = VideoViewModel()
    private var arrayAllVideosList: [Video] = [Video]()
    private var videos = [Video]()
    private var filteredVideos = [Video]() {
        didSet {
            DispatchQueue.main.async {
                self.videoCategoryTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoViewModel.delegate = self
        videoViewModel.fetchVideoList()
        searchBar.backgroundImage = UIImage()
    }
}

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}

extension VideoCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredVideos.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell {
            cell.lblVideo.text = filteredVideos[indexPath.row].videoTitle
            if let url = URL(string: filteredVideos[indexPath.row].videoImage) {
                Common.setImage(imageView: cell.videoImageView, url: url)
            }
            Common.setShadow(view: cell.cellView)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = AVPlayer(url: URL.init(string: filteredVideos[indexPath.row].videoUrl)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}

extension VideoCategoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredVideos = searchText.isEmptyOrWhiteSpace ? arrayAllVideosList : arrayAllVideosList.filter { $0.videoTitle.lowercased().contains(searchText.lowercased())
        }
    }
}
extension VideoCategoryViewController: VideoViewModelDelegate {
    func loadVideoList() {
        arrayAllVideosList = videoViewModel.videos ?? []
        
        videos = arrayAllVideosList
        filteredVideos = videos
    }
}
