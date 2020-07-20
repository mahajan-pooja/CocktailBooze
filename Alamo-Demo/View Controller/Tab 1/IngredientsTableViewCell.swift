//
//  IngredientsTableViewCell.swift
//  Alamo-Demo
//
//  Created by Akshay on 2/21/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var lblIngredients: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
