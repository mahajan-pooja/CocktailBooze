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

class VideoCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var videoCategoryTableView: UITableView!
    private var arrayAllVideosList: [VideoCategoryModel] = [VideoCategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideoCategoryData()
    }

    private func fetchVideoCategoryData() {
        DispatchQueue.main.async {
            Alamofire.request(Constants.ExternalHyperlinks.videoCategory).responseJSON(completionHandler: { response in
                if response.result.isSuccess {
                    let model: MainVideoCategoryModel = MainVideoCategoryModel.init(fromDictionary: (response.result.value as? NSDictionary)!)
                    self.arrayAllVideosList.removeAll()
                    if !model.result.isEmpty {
                        self.arrayAllVideosList.append(contentsOf: model.result)
                    }
                    self.videoCategoryTableView.reloadData()
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
        arrayAllVideosList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell {
            cell.lblVideo.text = arrayAllVideosList[indexPath.row].productName
            if let url = URL(string: arrayAllVideosList[indexPath.row].image) {
                Common.setImage(imageView: cell.videoImageView, url: url)
            }
            Common.setShadow(view: cell.cellView)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = AVPlayer(url: URL.init(string: arrayAllVideosList[indexPath.row].url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}
