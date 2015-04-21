//
//  StoryView.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/19/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var storyDescription: UITextView!
    
    @IBOutlet weak var tableView: UITableView!

    private var allPois = [FecPoi]()
    
    
    var storyDescriptionText: String = ""
    var backgroundNavColor: UIColor = UIColor(hex: 0x61CE72)

    override func viewDidLoad() {
        super.viewDidLoad()
        allPois = LibraryAPI.sharedInstance.getPois()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = backgroundNavColor
        self.storyDescription.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        self.storyDescription.text = storyDescriptionText
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("poi") as? StoriesListViewCell ?? StoriesListViewCell()
        var poi = self.allPois[indexPath.row]
        
        cell.textLabel?.text = poi.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPois.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedPoi = allPois[indexPath.row]
        self.performSegueWithIdentifier("ShowPoiDetail", sender: selectedPoi)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPoiDetail" {
            if let poi = sender as? FecPoi {
                let detailedViewController = segue.destinationViewController as! DetailedViewController
                detailedViewController.selectedPoi = poi
            }
        }
    }
    
}