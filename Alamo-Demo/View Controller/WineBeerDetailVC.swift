//
//  WineBeerDetailVC.swift
//  Alamo-Demo
//
//  Created by Pooja on 9/10/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class WineBeerDetailVC: UIViewController {
    var desc: String!
    var descExtra: String!
    var name: String!
    var img: String!
    
    @IBOutlet weak var imgViewBottle: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var UIViewLblDescExtra: UIView!
    @IBOutlet weak var UIViewLblDesc: UIView!
    @IBOutlet weak var lblExtra: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewLblDesc.layer.cornerRadius = UIViewLblDesc.frame.height/6
        UIViewLblDesc.layer.shadowColor = UIColor.gray.cgColor
        UIViewLblDesc.layer.shadowOpacity = 0.8
        UIViewLblDesc.layer.shadowOffset = CGSize.zero
        UIViewLblDesc.layer.shadowRadius = 2
        UIViewLblDesc.layer.masksToBounds = false
        
        UIViewLblDescExtra.layer.cornerRadius = UIViewLblDescExtra.frame.height/6
        UIViewLblDescExtra.layer.shadowColor = UIColor.gray.cgColor
        UIViewLblDescExtra.layer.shadowOpacity = 0.8
        UIViewLblDescExtra.layer.shadowOffset = CGSize.zero
        UIViewLblDescExtra.layer.shadowRadius = 2
        UIViewLblDescExtra.layer.masksToBounds = false
        
        lblDesc.text = desc
        lblName.text = name
        lblExtra.text = descExtra
        if(img != "") {
            let url: URL = URL(string: img)!
            imgViewBottle.kf.setImage(with: url, placeholder: UIImage(named:"cocktail"),  options: nil, progressBlock: nil, completionHandler: {
                ( image, error, cacheType, imageUrl) in
                if image != nil{
                    self.imgViewBottle.clipsToBounds = true
                    self.imgViewBottle.backgroundColor = .clear
                }
            })
        }
    }
}
