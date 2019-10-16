//
//  FavoritesTableViewCell.swift
//  Alamo-Demo
//
//  Created by Pooja on 8/27/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var btnRemoveFevorites: UIButton!
    @IBOutlet weak var lblFavoriteName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
