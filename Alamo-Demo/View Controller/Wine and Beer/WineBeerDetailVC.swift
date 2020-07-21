//
//  WineBeerDetailVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 9/10/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class WineBeerDetailVC: UIViewController {
    var wineDetails: WineModel?
    
    @IBOutlet weak var imgViewBottle: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var UIViewLblDescExtra: UIView!
    @IBOutlet weak var UIViewLblDesc: UIView!
    @IBOutlet weak var lblExtra: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        UIViewLblDesc.layer.cornerRadius = UIViewLblDesc.frame.height / 6
        UIViewLblDesc.layer.shadowColor = UIColor.gray.cgColor
        UIViewLblDesc.layer.shadowOpacity = 0.8
        UIViewLblDesc.layer.shadowOffset = CGSize.zero
        UIViewLblDesc.layer.shadowRadius = 2
        UIViewLblDesc.layer.masksToBounds = false

        UIViewLblDescExtra.layer.cornerRadius = UIViewLblDescExtra.frame.height / 6
        UIViewLblDescExtra.layer.shadowColor = UIColor.gray.cgColor
        UIViewLblDescExtra.layer.shadowOpacity = 0.8
        UIViewLblDescExtra.layer.shadowOffset = CGSize.zero
        UIViewLblDescExtra.layer.shadowRadius = 2
        UIViewLblDescExtra.layer.masksToBounds = false
        
        if let wineDetails = wineDetails {
            lblDesc.text = wineDetails.desc
            lblName.text = wineDetails.name
            lblExtra.text = wineDetails.descExtra
            if let img = wineDetails.image, let url: URL = URL(string: img) {
                Common.setImage(imageView: imgViewBottle, url: url)
            }
        }
    }
}
