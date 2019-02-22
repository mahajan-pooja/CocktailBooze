//
//  TableViewController.swift
//  Alamo-Demo
//
//  Created by Pooja on 12/6/18.
//  Copyright © 2018 GenistaBio. All rights reserved.
//

import UIKit

let dietCat = ["Balanced","High Fiber", "High Protein", "Low Fat", "Low Sodium"]
let cat_param = ["balanced","High Fiber", "High Protein", "Low Fat", "Low Sodium"]
let dietCatDesc = ["Protein/Fat/Carb values in 15/35/50 ratio","More than 5g fiber per serving","More than 50% of total calories from proteins", "Less than 20% of total calories from carbs", "Less than 15% of total calories from fat", "Less than 140mg Na per serving"]
var myIndex = 0

class TableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dietCat.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellController

        cell.lblTitle?.text = dietCat[indexPath.row]
        cell.lblDesc?.text = dietCatDesc[indexPath.row]
        cell.imgView?.image = UIImage(named: "food_img")
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

}
