//
//  StoryView.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/19/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ENSideMenuDelegate {

    @IBOutlet weak var storyDescription: UITextView!
    
    @IBOutlet var topView: UIView!
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
        self.storyDescription.scrollEnabled = false
        self.storyDescription.font = GlobalConstants.subHeadingFont
        
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("poi") as? StoryPointsOfInterestListViewCell ?? StoryPointsOfInterestListViewCell()
        var poi = self.allPois[indexPath.row]
        
        cell.poiName.text = poi.title
        cell.poiImage.image = UIImage(named: poi.pictureUrl)
        cell.locationAway.text = String(poi.beaconMajor) + "ft"
        
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
    
    @IBAction func backToMenu(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var menuVC : StoriesMenuViewController
        menuVC = mainStoryboard.instantiateViewControllerWithIdentifier("storyMenuView") as! StoriesMenuViewController
        
        sideMenuController()?.setContentViewController(menuVC)
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