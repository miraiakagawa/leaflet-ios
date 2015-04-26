//
//  StoriesMenuController.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/8/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

struct Story {
    var title: String
    var description: String
    var pointsOfInterest: [FecPoi]
    var color: CGColor
    var picture: String
    var storyIcon: String
}

class StoriesMenuViewController: UITableViewController, ENSideMenuDelegate {
    
    var stories: [Story] = [
        Story(title: "Water",
            description: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
            pointsOfInterest: [],
            color: UIColor(hex: 0x2EA9FC).CGColor,
            picture: "Water.png",
            storyIcon: "WaterHexagon.png"
            ),
        Story(title: "Energy",
            description: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
            pointsOfInterest: [],
            color: UIColor.orangeColor().CGColor,
            picture: "Energy.png",
            storyIcon: "EnergyHexagon.png"
        ),
        Story(title: "Heat",
            description: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
            pointsOfInterest: [],
            color: UIColor.redColor().CGColor,
            picture: "Heat.png",
            storyIcon: "HeatHexagon.png"
        ),
        Story(title: "Plants",
            description: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
            pointsOfInterest: [],
            color: UIColor.greenColor().CGColor,
            picture: "Plants.png",
            storyIcon: "PlantsHexagon.png"
        ),
        Story(title: "Explore",
            description: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
            pointsOfInterest: [],
            color: UIColor.grayColor().CGColor,
            picture: "Explore.png",
            storyIcon: "ExploreHexagon.png"
        )
    ]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("story") as? StoriesListViewCell ?? StoriesListViewCell()
        var story = self.stories[indexPath.row]
        
        cell.storyBackgroundImg.image = UIImage(named: story.picture)
        cell.overlay.hidden = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stories.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("did select row: \(indexPath.row)")
        
        var cell = tableView.dequeueReusableCellWithIdentifier("story", forIndexPath: indexPath) as! StoriesListViewCell
        cell.overlay.hidden = false
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var storyVC : StoryViewController
        storyVC = mainStoryboard.instantiateViewControllerWithIdentifier("storyView") as! StoryViewController
        storyVC.title = stories[indexPath.row].title
        
        storyVC.storyDescriptionText = stories[indexPath.row].description
        storyVC.storyIconPath = stories[indexPath.row].storyIcon
        storyVC.storyColor = stories[indexPath.row].color
    
        sideMenuController()?.setContentViewController(storyVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
        
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
        
        self.tableView.rowHeight = 100.0
        self.tableView.separatorStyle = .None

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        switch segue.identifier! {
//            case "storyViewDisplay":
//                let navVC = segue.destinationViewController as! UINavigationController
//                let storyVC = navVC.viewControllers.first as! StoryViewController
//                if var cell = sender as? StoriesListViewCell {
//                    var storySearch = filter(stories) { (s: Story) in s.title == cell.storyName.text! }
//                    storyVC.title = storySearch[0].title
//                    storyVC.storyDescriptionText = storySearch[0].description
//                    storyVC.backgroundNavColor = storySearch[0].color
//                }
//        default:
//            break
//        }
//        
//    }
    
    
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