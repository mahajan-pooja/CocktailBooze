//
//  TableViewCellController.swift
//  Alamo-Demo
//
//  Created by Pooja on 12/6/18.
//  Copyright © 2018 GenistaBio. All rights reserved.
//

import UIKit
//let dietCat = ["Balanced","High Fiber", "High Protein", "Low Fat", "Low Sodium"]
//let dietCatDesc = ["Protein/Fat/Carb values in 15/35/50 ratio","More than 5g fiber per serving","More than 50% of total calories from proteins", "Less than 20% of total calories from carbs", "Less than 15% of total calories from fat", "Less than 140mg Na per serving"]
//var myIndex = 0
class TableViewCellController: UITableViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //lblDesc.text = dietCatDesc[indexPath.row]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
