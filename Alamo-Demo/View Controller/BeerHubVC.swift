//
//  BeerHubVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 9/10/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class BeerHubVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BeerHubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerHubCell", for: indexPath) as! BeerHubCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 400)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
