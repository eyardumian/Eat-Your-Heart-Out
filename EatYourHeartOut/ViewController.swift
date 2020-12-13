//
//  ViewController.swift
//  EatYourHeartOut
//
//  Created by Erika Yardumian on 11/17/20.
//  Copyright © 2020 Erika Yardumian. All rights reserved.
//

import UIKit
import os.log
import os

class ViewController: UICollectionViewController, NewItemDelegate, FavoritesDelegate {

    fileprivate static let rootKey = "rootKey"

    private static let groceryListCell = "GroceryList"
    var showsGroceryList:Bool = false
    var showsFavoritesList:Bool = false
    var showsRecipeDetails:Bool = false
    var groceryItemList = [String]()
    var favoritesList = [[AnyObject]]()
    var groceryIndex : Int = 0
    
    var defaultList = ["cheese", "butter"]
    
    let images = [
        UIImage (named: "pita"), UIImage (named: "spaghetti"), UIImage (named: "minty shake"), UIImage (named: "waffles"), UIImage (named: "fregola"), UIImage (named: "curry"), UIImage (named: "pork tonkatsu"), UIImage (named: "muffins"), UIImage (named: "tagliatelle"), UIImage (named: "tri-tip")
    ]
    
    let names = ["Garbanzo Bean and Feta Pitas", "Spaghetti with Tuna, Tomatoes,and Olive", "Blueberry Shake", "Whole-Grain Waffles with Strawberries", "Fregola with Clams", "Thai Red Curry with Butternut Squash", "Pork with Watermelon-Tomato Salad", "Raspberry Corn Muffins", "Tagliatelle with Fresh Pesto", "Steak Frites with Red Wine Sauce"]
    
    let ingredients = [
        ["1/2 cup olive oil", "1/3 cup white wine vinegar", "4 tsp Moraccan spice blend", "1 15oz can garbanzo beans, drained", "1.5 cups coarsely chopped seeded tomatoes", "1.5 cups coarsely chopped seeded peeled cucumbers", "1 cup coarsely crumbled feta cheese", "1/2 cup chopped red onion", "1/3 cup chopped fresh Italian parsley", "4 whole pita bread rounds, halved crosswise", "plain yogurt"],
        ["1 pint cherry tomatoes, halved", "6 oz olive oil-packed Italian or Spanish tuna, drained", "1/2 cup black olives, pitted, torn (about 2 oz)", "1/2 cup chopped fresh parsley", "1 tsp freshly ground black pepper", "3 tbls extra-virgin olive oil, plus more to taste", "1 tsp kosher salt, plus more to taste", "1 lb thin spaghetti", "1 tbls fresh lemon juice"],
        ["2 cups fresh or frozen wild blueberries", "1 cup plain, 2% yoburt or plain kefir", "1 cup assorted greens such as spinach, bab kale, or collards", "1 banana", "1/4 cup fresh mint leaves", "1/4 cup hemp seeds", "1/4 cup pumpkin seeds", "4 ice cubes", "3/4 cup cold water"],
        ["1/2 cup rolled oats", "1/2 cup whole-wheat flour", "1 tbls ground flaxseed", "2 tps baking powder", "1/4 tsp pumpkin pie spice", "1/4 teaspoon salt", "1 egg, separated", "3/4 cup skim milk", "1/4 cup mashed banana", "1 tbls canola oil", "Vegetable oil cooking spray", "3/4 cup nonfat plain Greek yogurt, divided", "1 1/2 cups sliced strawberries, divided", "3 tbls sliced almonds, divided", "6 tsp maple syrup, divided"],
        ["1 1/2 cups fregola (about 10 oz]", "Kosher salt", "1/2 cup olive oil, plus more for drizzling", "2 garlic cloves, finely chopped", "1 tsp crushed red pepper flakes", "1/2 cup dry white win", "24 littleneck clames, scrubbed", "2 tbls chopped fresh flat-leaf parsley", "1/2 tsp finely grated lemon zest"],
        ["1 small butternut squash (about 2 pounds]", "2 tbls canola oil", "1/3 cup Thai red curry paste", "One 15-oz can chickpeas, drained and rinsed", "Kosher salt", "One 13-oz can unsweetened coconut milk", "1/3 cup fresh cilantro, plus more for garnish"],
        ["2 cups 1/2 inch cubes watermelon", "2 cups cherry tomatoes, halved", "2 cups (lightly packed) baby arugula", "1/4 cup fresh flat-leaf parsley leaves", "1/4 cup extra-virgin olive oil", "2 tbls Dijon mustard, divided", "1 tbls fresh lemon juice", "4 lemon wedges", "1/2 tsp kosher salt", "1/4 tsp freshly ground black pepper plus more", "2 large eggs", "2 cups panko", "4 4-oz boneless center-cut pork chops, pounded to 1/8 inch thickness", "6 tbls vegetable oil, divided"],
        ["Standard 12-cup muffin pan", "1 cup cornmeal", "1 1/4 cups unbleached all-purpose flour", "1/2 cup granulated sugar", "2 tsp baking powder", "1 1/2 tsp baking soda", "1/2 tsp kosher salt", "2 large eggs", "3/4 cup buttermilk or 3/4 cup whole milk mixed with 1 tsp lemon juice", "12 tbls (1 1/2 sticks) unsalted butter, melted", "3 tbls honey", "1 1/2 cups raspberries"],
        ["4 bacon slices, cut lengthwise in half, then crosswise into 1/2-inch pieces", "4 cups fresh corn kernels", "1 large garlic clove, minced", "1 1/4 tsp coarse kosher salt", "3/4 tsp freshly grated Parmesan cheese plus additional for serving", "1/3 cup pine nuts, toasted", "1/3 cup extra-virgin olive oil", "8 oz tagliatelle or fettuccine", "3/4 cup coarsely torn fresh basil leaves, divided"],
        ["28 to 30 oz frozen french fries", "3 tbls vegetable oil, divided", "1 (1 1/2 to 2 lbs) tri-tip beef roast, cut into 4 steaks", "2 tsp cracked black peppercorns", "1/4 cup dry red wine", "1/2 cup water", "2 tbls unsalted butter, cut into tbls", "3 tbls finely chopped tarragon (optional)"]
    ]
    
    let directions = [
        ["Whisk together olive oil, white wine vinegar, and Moroccan spice blend in medium bowl. Place drained garbanzo beans in large bowl and mix enough vinaigrette to coat. Let stand 10 minutes to allow flavors to blend.", "Add tomatoes, cucumbers, feta cheese, red onion, and parsley to garbanzo beans. Mis in enough vinaigrette to coat Season bean salad to taste with salt and pepper. Fill 2 pita halves on each of 4 plates; pass remaining vinaigrette separately."],
        ["Combine tomatoes, tuna, olives, parsley, pepper, 3 Tbsp. oil, and 1 tsp salt in a large bowl.", "Cook spaghetti in a large pot of boiling salted water, stirring occasionally, until al dente. Drain and add to tomato mixture. Stir vigorously adn add more oil as need to fully coat. Season with salt.", "Transfer pasta to a serving bowl or platter. Drizzle with lemon juice and serve."],
        ["Place the blueberies, yogurt or kefir, greens, banana, mint leaves, hemp seeds, and pumpkin seeds in a blender along with the ice cubes and cold water and process until smooth. Divide evenly between two glasses and serve immediately."],
        ["Heat waffle iron. In a blender, process oats until flourlike in texture. In a bowl, combine oats with flour, flaxseed, baking powder, pumpkin pie spice and salt. In a second bowl, beat egg white until stiff peaks form. In a third bowl, mix milk, banana, oil and egg yolk. Gently stir milk-banana mixture into dry ingredients; gently fold in egg white until just comined. Coat waffle iron with cooking spray; pout 1/3 cup batter onto iron, and cook until waffle is crispy and pale gold, about 4 minutes. Repeat twice. Top each waffle with 1/4 cup yogurt, 1/2 cup strawberries, 1 tbls almonds and 2 teaspoon syrup."],
        ["Cook fregola in a large pot of boiling salted water, stirring occasionally, until very al dente, 6-8 minutes; drain.", "Meanwhile, heat 1/2 cup oil in a Dutch oven or other large heavy pot over medium-high heat. ADd garlic and red pepper flakes and cook, stirring, until fragrant, about 30 seconds. Carefully add wine; bring to a boil, reduce heat, and simmer until reduces by half, about 3 minutes.", "Add clams, cover, and cook, transferring clams to a bowl as they open (discard any that do not open), 6-8 minutes. Add fregola to cooking liquid in a pot and cook, stirring, until fregola is tender and sauce is slightly thickened (there should still be plenty of liquid), about 2 mintues. Return clams to pot and cook until warmed through.", "Divide fregola and clams among bowls, drizzle with oi., and top with parsley and lemon zest."],
        ["Peel the squash, cut it lengthwise in half, and scoop out the seeds. Cut off the top where it meets the bulbous bottom. Cut the bulb end into 3/4 - inch wide wedges. Cut the neck end into 1/2-inch thick half-moons.", "Heat a large heavy pot over medium-high heat. Add the canola oil, then add the curry paste and stir for about 1 minute, or until fragrant. Add the squash and stir to coat with the curry paste. Stir in the chickpeas and season with salt. Add the coconut milk and 3/4 cup water and bring to a simmer. Reduce the heat to medium-low, cover, and simmer gently for about 10 minutes, or until the squash just begins to soften.", "Stir in the cilantro and simmer, uncovered, stirring occasionally, for about 20 minutes, or until the squash is tender but not falling apart and the sauce has reduced slightly. Season to taste with salt.", "Divide the curry among four soup bowls, top with cilantro, and serve."],
        ["Combine first 4 ingredients in a large bowl. Whisk olive oil, 1 tbls mustard, and juice in a small bowl. Season dressing with salt and pepper. Set salad and dressing aside.", "Whisk eggs and 1 tbls mustard in a medium bowl. Combine panko, 1/2 teaspoon salt, and 1/4 tsp pepper on a large plate. Season pork lightly with salt and pepper. Dip in egg mixture, then in panko, pressing to adhere.", "Working in 2 batches, heat 2 tbls vegetable oil in a large nonstick skillet over medium heat and cook pork until golden brown and cooked through, about 2 minutes per side, adding 1 tbls vegetable oil after turning. Drain on paper towels.", "Toss salad with dressing; season to taste with salt and pepper. Serve pork with salad and lemon wedges for squeezing over."],
        ["Preheat the oven to 400 degrees. Grease the cups of a muffin pan with nonstick cooking spray or butter or fill with paper liners.", "In a medium bowl, stir the cornmeal with the flour, sugar, baking powder, baking soda, and salt.", "In another medium bowl, whisk the eggs and buttermilk, then whisk in the butter and honey. Using a rubber spatula or large sppon, stir in the flour mixture until the batter is evenly combined and no dry streaks are visible. Add the raspberries and gently mix until everything is barely blended- to keep the muffins light it's important to not overmix the batter.", "Spoon the batter into the prepared muffin cups, filling them equally. Bake until a bamboo skewer or toothpick inserted into the middles of the muffins comes out clean and the tops are godlen brown, about 20 minutes. Let cool in the pan for 5 minutes and then use a small paring knife to pop them out of the cups."],
        ["Cook bacon in large nonstick skillet over medium heat until crisp and brown, stirring often. Using slotted spoon, transfer to paper towels to drain. Pour offall but 1 tbls drippings from skillet. Add corn, garlic, 1 1/4 tsp coarse salt, and 3/4 tsp pepper to drippings in skillet. Saute over medium-high heat until corn is just tender but not brown, about 4 minutes. Transfer 1 1/2 cups corn kernels to small bowl and reserve. Scrape remaining corn mixture into processor. Add 1/2 cup Parmesan and pine nuts. With machine running, add olive oil through feed tube and blend until pesto is almost smooth. Set pesto aside.", "Cook pasta in large pot of boiling salted water until just tender but still firm to bite, stirring occasionally. Drain, reserving 1 1/2 cups pasta cooking liquid. Return pasta to pot. Add corn pesto, reserved corn kernels, and 1/2 cup basil leaves. Toss pasta mizutre over medium heat until warmed throguh, adding reserved pasta cooking liquid by 1/4 cupfuls to thin to desired consistency, 2 to 3 minutes. Season pasta to taste with salt and papper.", "Transfer pasta to large shallo bowl. Sprinkle with remaining 1/4 cup basil leaves and reserved bacon. Serve pasta, passing additional grated Parmesan alongside."],
        ["Preheat oven to 475 degrees with racks in upper and lower thirds, with a 4-sided sheet pan in lower third.", "Toss fries with 2 tbls oil in hot sheet pan, then bake according to package instructions until golden and crisp.", "Meanwhile, pat steaks dry, then rub with peppercorns and 1/2 teaspoon salt.", "Heat remaining tbls oil in an ovenproof 12-inch heavy skillet over medium-high heat until it shimmers. Sear steaks on all sides, about 3 minutes total. Transfer skillet to upper third of oven and roast 9 to 10 minutes for medium-rare. Transfer steaks to a plate and let rst 5 minutes.", "Add wine to skillet and boil, scraping brown bits, until reduced by half, about 1 minutes. Add water and meat jiuces from plate and boil briskly until recuded by jalf, 3 to 4 minutes. Whisk in butter until incorporated. Season with salt and pepper."]
    ]
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func addItem(item: String) {
        //print("Called addAlbum")
        groceryItemList.append(item)
        //self.tableView.reloadData()
        print(groceryItemList)
    }
    
    func addFavorite(items: [AnyObject]) {
        favoritesList.append(items)
        print(favoritesList)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.reloadData()
        let navBar = self.navigationController?.navigationBar
        
        // change the bar tint color to change what the color of the bar itself looks like
        navBar?.barTintColor = UIColor.orange
        
        // tint color changes the color of the nav item colors eg. the back button
        navBar?.tintColor = UIColor.white
        
        // if you notice that your nav bar color is off by a bit, sometimes you will have to
        // change it to not translucent to get correct color
        navBar?.isTranslucent = false
        
        
        // the following attribute changes the title color
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
       
        let fileURL = dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path!)) {
            
            let array = NSArray(contentsOf: fileURL as URL) as? [String]
            groceryItemList = array!
        } else {
            print("empty list")
        }
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector:#selector(self.applicationWillResignActive(notification:)), name:
            
            Notification.Name.UIApplicationWillResignActive, object: app)
        //let array = NSArray(contentsOf: fileURL as URL) as! [[String]]

    }
    
    func dataFileURL() -> NSURL
    {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:NSURL?
        url = URL(fileURLWithPath: "") as NSURL?
        url = urls.first?.appendingPathComponent("data.archive3") as NSURL?
        return url!
    }
        
        @objc func applicationWillResignActive(notification:NSNotification) {
            //let filename = getDocumentsDirectory().appendingPathComponent("albums.txt")
            
            // Save to file
            //(albums as NSArray).write(to: filename as URL, atomically: false)
            let fileURL = self.dataFileURL()
            let array = self.groceryItemList as NSArray
            array.write(to: fileURL as URL, atomically: true)
        }
        
        // Reload table data each time we display the view
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            //tableView.reloadData()
//        }
        

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Recipe", for: indexPath) as? RecipeCell
        cell?.imageView.image = images[indexPath.row]
        cell?.name.text = names[indexPath.row]
        return cell!
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {

        case "toGroceryList":
           //let indexPath = UIButton?.indexPath(for: sender as! UIButton)!
            let destVC = segue.destination as! GroceryListViewController
            //destVC.groceryIndex = (indexPath?.row)!
            destVC.groceriesList = groceryItemList
            destVC.showsGroceryList = true

        case "toFavoritesList":
            let destVC = segue.destination as! FavoritesViewController
            destVC.favoriteList = favoritesList
            destVC.showsFavoriteList = true
            
        case "toRecipeDetails":
            let indexPath = collectionView?.indexPath(for: sender as! UICollectionViewCell)!
            let destVC = segue.destination as! RecipeViewController
            destVC.recipeIndex = (indexPath?.row)!
            destVC.recipeImages = images as! [UIImage]
            destVC.namesList = names
            destVC.ingredientsList = ingredients
            destVC.directionsList = directions
            destVC.delegate = self
            destVC.delegate2 = self
            destVC.showsRecipeDetails = true
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

