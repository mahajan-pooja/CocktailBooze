//
//  VideoCategoryViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import AVKit
var arrayAllVideosList: [VideoCategoryModel] = [VideoCategoryModel]()
class VideoCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var videoCategoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideoCategoryData()
    }
    
    func fetchVideoCategoryData(){
        DispatchQueue.main.async {
            Alamofire.request("https://mahajan-pooja.github.io/cocktail-booz-api/video-category.json").responseJSON(completionHandler: {(response) in
                if response.result.isSuccess {
                    let model: MainVideoCategoryModel = MainVideoCategoryModel.init(fromDictionary: (response.result.value as? NSDictionary)!)
                    arrayAllVideosList.removeAll()
                    if (model.result.count) > 0 {
                        arrayAllVideosList.append(contentsOf: model.result)
                    }
                    self.videoCategoryTableView.reloadData()
                }else{
                    print("failure error")
                }
            })
        }
    }

    //Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAllVideosList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.lblVideo.text = arrayAllVideosList[indexPath.row].productName!
        let url: URL = URL(string: arrayAllVideosList[indexPath.row].image!)!
        cell.videoImageView.kf.setImage(with: url, placeholder: UIImage(named:""),  options: nil, progressBlock: nil, completionHandler: {
            ( image, error, cacheType, imageUrl) in
            if image != nil{
                cell.videoImageView.clipsToBounds = true
            }
        })
        cell.cellView.layer.shadowColor = UIColor.red.cgColor
        cell.cellView.layer.shadowOpacity = 0.5
        cell.cellView.layer.shadowOffset = CGSize.zero
        cell.cellView.layer.shadowRadius = 1.5
        
        return cell
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
