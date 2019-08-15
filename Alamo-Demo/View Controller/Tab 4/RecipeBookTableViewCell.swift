//
//  RecipeBookTableViewCell.swift
//  Alamo-Demo
//
//  Created by Pooja on 7/12/19.
//  Copyright © 2019 GenistaBio. All rights reserved.
//

import UIKit

class RecipeBookTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var imgRecipe: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
