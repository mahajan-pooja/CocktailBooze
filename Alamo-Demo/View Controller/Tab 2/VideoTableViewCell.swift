//
//  VideoTableViewCell.swift
//  Alamo-Demo
//
//  Created by Pooja on 3/8/19.
//  Copyright © 2019 Pooja Mahajan. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var lblVideo: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
