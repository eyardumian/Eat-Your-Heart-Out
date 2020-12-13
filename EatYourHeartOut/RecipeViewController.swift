//
//  RecipeViewController.swift
//  EatYourHeartOut
//
//  Created by Erika Yardumian on 11/18/20.
//  Copyright © 2020 Erika Yardumian. All rights reserved.
//

import UIKit
import os.log

protocol NewItemDelegate {
    func addItem(item: String)
}

protocol FavoritesDelegate {
    func addFavorite(items: [AnyObject])
}

class RecipeViewController: UITableViewController {
    
    var recipeIndex: Int = 0
    var recipeImages = [UIImage]()
    var namesList = [String]()
    var ingredientsList = [[String]]()
    var groceryItems = [String]()
    var directionsList = [[String]]()
    var showsRecipeDetails:Bool = false

    var delegate: NewItemDelegate?
    var delegate2: FavoritesDelegate?
    
    @IBAction func addToGroceries(_ sender: UIButton) {
        /*WORKING CODE
        let point = tableView.convert(CGPoint.zero, from: sender)
        let indexPath = tableView.indexPathForRow(at: point)
        let cell = tableView.cellForRow(at: indexPath!) as! IngredientsCell
        print(indexPath)
        print(cell.ingredientLabel.text!)
        groceryItems.append(cell.ingredientLabel.text!)
        groceryItems.append("salt")
        //tableView.beginUpdates()
        //tableView.endUpdates()
        //tableView.reloadData()
        print(groceryItems)
        //tableView.insertRows(at: [indexPath], with: .automatic)
        */
        let point = tableView.convert(CGPoint.zero, from: sender)
        let indexPath = tableView.indexPathForRow(at: point)
        let cell = tableView.cellForRow(at: indexPath!) as! IngredientsCell
        let groceryItem = cell.ingredientLabel.text
        delegate?.addItem(item: groceryItem!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        //sender.backgroundColor = UIColor.orange
        //let point = tableView.convert(CGPoint.zero, from: sender)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! RecipeDetailCell
        let favoriteName = cell.detailName.text
        let favoriteImage = cell.detailImageView.image
        delegate2?.addFavorite(items: [favoriteName! as AnyObject, favoriteImage! as AnyObject])
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addToFavorites(_ sender: UIButton) {
//        //sender.backgroundColor = UIColor.orange
//        let point = tableView.convert(CGPoint.zero, from: sender)
//        let indexPath = tableView.indexPathForRow(at: point)
//        let cell = tableView.cellForRow(at: indexPath!) as! RecipeDetailCell
//        let favoriteName = cell.detailName.text
//        let favoriteImage = cell.detailImageView.image
//        delegate2?.addFavorite(items: [favoriteName! as AnyObject, favoriteImage! as AnyObject])
//        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        //self.view.backgroundColor = UIColor.clear
//        let navBar = self.navigationController?.navigationBar
//        navBar?.isTranslucent = true
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 270.0
        } else if indexPath.section == 1 {
            return 45.0
        } else if indexPath.section == 2 {
            return 45.0
        } else {
            //tableView.estimatedRowHeight = 75
            //return UITableViewAutomaticDimension
            return 135
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
        return 1
        } else if section == 1 {
            return ingredientsList[recipeIndex].count
        } else if section == 2 {
            return 1
        } else {
            return directionsList[recipeIndex].count
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                let cell : RecipeDetailCell = tableView.dequeueReusableCell(withIdentifier: "recipeDetailCell", for: indexPath) as! RecipeDetailCell
                cell.detailImageView.image = recipeImages[recipeIndex]
                cell.detailName.text = namesList[recipeIndex]
                return cell
            }else if indexPath.section == 1 {
                let cell : IngredientsCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as! IngredientsCell
                cell.ingredientLabel.text = self.ingredientsList[recipeIndex][indexPath.row]
                return cell
        } else if indexPath.section == 3{
            let cell: DirectionsCell = tableView.dequeueReusableCell(withIdentifier: "directionsCell", for: indexPath) as! DirectionsCell
            cell.directionsLabel.text = self.directionsList[recipeIndex][indexPath.row]
                cell.directionsLabel.sizeToFit()
                return cell
            } else {
                let cell: DirectionsLabelCell = tableView.dequeueReusableCell(withIdentifier: "directionsLabelCell", for: indexPath) as! DirectionsLabelCell
                return cell
        }
        }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //THIS GIVES AN ERROR: COULD NOT CAST VALUE OF TYPE UIBUTTON TO UITABLECELL
//        if (segue.identifier == "addItem") {
//            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
//            let destVC = segue.destination as! GroceryListViewController
//            destVC.groceryIndex = indexPath.row
//            destVC.groceryItemList = self.groceryItems
//        }
        
     }
     
     /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
