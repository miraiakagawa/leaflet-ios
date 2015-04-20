//
//  PointsOfInterestListViewController.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/8/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

struct PointOfInterest {
    var title: String
    var content: String
}

class PointsOfInterestListViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var pointsOfInterests: [PointOfInterest] = [
        PointOfInterest(title: "Bathroom",
            content: "The faucets and toilets in the bathroom are fed by grey water from the underground cistern. The water is not potable, but works perfectly fine for uses like these. Additionally, the low-flow faucets and toilet flushers conserve water so that as little as possible is wasted."),
        PointOfInterest(title: "Solar panels",
            content: "Up above your head, this arch is outfitted with solar panels that are used to power the building, and provide you with some shade."),
        PointOfInterest(title: "Rain barrels",
            content: "Rain barrels are used to catch any runoff from the solar panels when it’s raining. Water stored here is used to water the vegetable garden and the slavery to freedom garden, which are more water intensive than the native landscape. </br> Rain barrels are also useful in residential homes. They capture water from roof gutters and provide you with water to feed any plants you may have."),
        PointOfInterest(title: "Runoff of solar panels",
            content: "Any water runoff from the solar panel roof that the rain barrels can’t capture or hold is caught and stored by an underground water cistern. The water that it captures is used in the restrooms in Newell Simon Hall in the sinks and toilets."),
        PointOfInterest(title: "Permeable pavement",
            content: "Most asphalts are too dense for moisture from rainfall to soak through. This asphalt is porous enough for water to percolate through to help recharge the groundwater of the area."),
        PointOfInterest(title: "Native plants",
            content: "All landscaping around the Newell Simon building is full of native, low resource consuming plants. In addition to being beautiful, they also do not exacerbate problems caused by invasive, non-native plants such as erosion or unhealthy dominance of a single plant species."),
        PointOfInterest(title: "Water treatment",
            content: "Below the atrium, there is water treatment equipment that treats blackwater. Blackwater is any water that comes from a sink, a toilet, or a shower. The equipment treats the water and the water can then be dispersed in a slow and natural way outdoors to be taken up by trees."),
        PointOfInterest(title: "Water veil",
            content: "The water veil captures the runoff water from the north face of the building and drops off the roof of the building in a sheet. It then flows along the front of the building and then behind the building. On rainy days, the water veil mimics the naturally occurring waterfall. There is a walkway behind it so that you can walk behind the waterfall."),
        PointOfInterest(title: "Slavery to freedom garden",
            content: "This garden features different plants from different parts of Africa as well as different vegetables that can be grown in an ordinary house garden.")
    ]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("pointOfInterest") as? PointsOfInterestListViewCell ?? PointsOfInterestListViewCell()
        var pointOfInterest = self.pointsOfInterests[indexPath.row]
        
        cell.poiName.text = pointOfInterest.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pointsOfInterests.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            //        case "tableToDisplay":
            //            if var secondViewController = segue.destinationViewController as? RestaurantDisplayViewController {
            //                if var cell = sender as? RestaurantCellTableViewCell {
            //                    secondViewController.nameString = cell.restaurantName.text!
            //                }
            //            }
//        case "newRestaurantDisplay":
//            if var thirdViewController = segue.destinationViewController as? RestaurantNewViewController {
//                thirdViewController.delegate = self
//            }
//        case "restaurantDisplay":
//            if var fourthViewController = segue.destinationViewController as? DishTableViewController {
//                fourthViewController.delegate = self
//                if var cell = sender as? RestaurantCellTableViewCell {
//                    fourthViewController.restaurantName.title = cell.restaurantName.text!
//                    var index = 0
//                    while (cell.restaurantName.text != self.restaurants[index].name && index < self.restaurants.count) {
//                        index = index + 1
//                    }
//                    fourthViewController.dishes = restaurants[index].dishes!
//                }
//            }
        default:
            break
        }
        
    }
    
    
    
    // MARK: - Table view data source
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
