//
//  VideoCategoryViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import AVKit

class VideoCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var videoCategoryTableView: UITableView!
    private var arrayAllVideosList: [VideoCategoryModel] = [VideoCategoryModel]()
    private var videos = [VideoCategoryModel]()
    private var filteredVideos = [VideoCategoryModel]() {
        didSet {
            DispatchQueue.main.async {
                self.videoCategoryTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideoCategoryData()
        searchBar.backgroundImage = UIImage()

//        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
//        textFieldInsideSearchBar?.backgroundColor = UIColor.systemOrange
    }

    private func fetchVideoCategoryData() {
        DispatchQueue.main.async {
            Alamofire.request(Constants.ExternalHyperlinks.videoCategory).responseJSON(completionHandler: { response in
                if response.result.isSuccess {
                    let model: MainVideoCategoryModel = MainVideoCategoryModel.init(fromDictionary: (response.result.value as? NSDictionary)!)
                    self.arrayAllVideosList.removeAll()
                    if !model.result.isEmpty {
                        self.arrayAllVideosList.append(contentsOf: model.result)
                        self.videos = self.arrayAllVideosList
                        self.filteredVideos = self.videos
                    }
                  //  self.videoCategoryTableView.reloadData()
                } else {
                    print("failure error")
                }
            })
        }
    }

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
            cell.lblVideo.text = filteredVideos[indexPath.row].productName
            if let url = URL(string: filteredVideos[indexPath.row].image) {
                Common.setImage(imageView: cell.videoImageView, url: url)
            }
            Common.setShadow(view: cell.cellView)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = AVPlayer(url: URL.init(string: filteredVideos[indexPath.row].url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredVideos = searchText.isEmptyOrWhiteSpace ? arrayAllVideosList : arrayAllVideosList.filter { $0.productName.lowercased().contains(searchText.lowercased()) }
    }
}
extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}
