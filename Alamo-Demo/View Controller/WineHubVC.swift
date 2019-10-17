//
//  WineHubVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 9/9/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class WineHubVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//            let yourWidth = collectionView.bounds.width/2.0
//            let yourHeight = yourWidth
        
            return CGSize(width: 200, height: 400)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WineHubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineHubCell", for: indexPath) as! WineHubCell
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let WineBeerDetailVC: WineBeerDetailVC = storyBoard.instantiateViewController(withIdentifier: "WineBeerDetailVC") as! WineBeerDetailVC
        self.present(WineBeerDetailVC, animated: true, completion: nil)
    }
}
