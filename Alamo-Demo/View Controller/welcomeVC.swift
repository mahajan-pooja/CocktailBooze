//
//  welcomeVC.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/25/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class welcomeVC: UIViewController {

    @IBOutlet weak var goToButton: UIButton!
    @IBOutlet weak var logoUIView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillLayoutSubviews() {
        logoUIView.layer.shadowColor = UIColor.black.cgColor
        logoUIView.layer.shadowOpacity = 1
        logoUIView.layer.shadowOffset = CGSize.zero
        logoUIView.layer.shadowRadius = 10
        
        goToButton.layer.shadowColor = UIColor.black.cgColor
        goToButton.layer.shadowOpacity = 1
        goToButton.layer.shadowOffset = CGSize.zero
        goToButton.layer.shadowRadius = 10
    }
}
