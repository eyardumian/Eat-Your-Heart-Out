//
//  GroceryListCell.swift
//  EatYourHeartOut
//
//  Created by Erika Yardumian on 11/21/20.
//  Copyright © 2020 Erika Yardumian. All rights reserved.
//

import UIKit

class GroceryListCell: UITableViewCell {

//    @IBAction func GroceryButton(_ sender: UIBarButtonItem) {
//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = tableView.cellForRow(at: indexPath) as! IngredientsCell
//        groceryItems.append(cell.ingredientLabel.text)
//    }
    
    static let cellIdentifier = "Groceries"

    
    
    @IBOutlet weak var groceriesItem: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
