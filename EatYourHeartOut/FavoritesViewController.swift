//
//  FavoritesViewController.swift
//  EatYourHeartOut
//
//  Created by Erika Yardumian on 11/23/20.
//  Copyright © 2020 Erika Yardumian. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoritesViewController: UICollectionViewController {
    
    var favoriteList = [[AnyObject]]()
    var showsFavoriteList:Bool = true


    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let indexPath = collectionView?.indexPath(for: sender as! UICollectionViewCell)!
//        let destVC = segue.destination as! FavRecipeDetailViewControllerTableViewController
//       destVC.favRecipeImages = (favoriteList[(indexPath?.row)!][0] ) as! [UIImage]
//        destVC.favNameList = (favoriteList[(indexPath?.row)!][1] as! [String])
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return favoriteList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesListCell", for: indexPath) as? FavoritesCell
        cell?.favImage.image = favoriteList[indexPath.row][1] as? UIImage
        cell?.FavNameLabel.text = favoriteList[indexPath.row][0] as? String
        cell?.RemoveFavButton.tag = indexPath.item
        
        return cell!
    }
    
    @IBAction func RemoveFav(_ sender: UIButton) {
        let indexPath = NSIndexPath(item: sender.tag, section: 0)
        print(indexPath.row)
        self.favoriteList.remove(at: indexPath.row)
        collectionView?.deleteItems(at: [indexPath as IndexPath])
        self.collectionView?.reloadItems(at: (self.collectionView?.indexPathsForVisibleItems)!)

        }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var indexPaths: [NSIndexPath] = []
        for i in 0..<collectionView!.numberOfItems(inSection: 0) {
            indexPaths.append(NSIndexPath(item: i, section: 0))
        }
        collectionView?.reloadItems(at: indexPaths as [IndexPath])
        
    }
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.favoriteList.remove(at: indexPath.row)
//        collectionView.deleteItems(at: [indexPath])
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
