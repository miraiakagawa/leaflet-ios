//
//  StoriesMenuController.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/8/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class StoriesMenuViewController: UITableViewController, ENSideMenuDelegate {
    
    private var stories = [Story]()
    var selectedStory: Story!
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("story") as? StoriesListViewCell ?? StoriesListViewCell()
        var story = self.stories[indexPath.row]
        
        cell.storyBackgroundImg.image = UIImage(named: story.picture)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stories.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("did select row: \(indexPath.row)")
        
        var cell = tableView.dequeueReusableCellWithIdentifier("story", forIndexPath: indexPath) as! StoriesListViewCell
        
        self.selectedStory = stories[indexPath.row]
        self.performSegueWithIdentifier("toStory", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = false
        
        self.stories = LibraryAPI.sharedInstance.getStories()
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "toStory":
                if var storyVC = segue.destinationViewController as? StoryViewController {
                    storyVC.title = self.selectedStory.title
                    storyVC.storyDescriptionText = self.selectedStory.content
                    storyVC.storyIconPath = self.selectedStory.storyIcon
                    storyVC.storyColor = self.selectedStory.color
                }
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