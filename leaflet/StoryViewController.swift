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
    @IBOutlet weak var progressCircle: UIView!
    @IBOutlet weak var storyIcon: UIImageView!
    @IBOutlet weak var poiTable: UITableView!

    private var allPois = [FecPoi]()
    private var visited = LibraryAPI.sharedInstance.getVisitedCount()
    
    var storyDescriptionText: String = ""
    var backgroundNavColor: UIColor = UIColor(hex: 0x61CE72)
    var progress: CGFloat!
    var storyColor: CGColor!
    var storyIconPath: String!
    var selectedPoi: FecPoi!

    override func viewDidLoad() {
        super.viewDidLoad()
        allPois = LibraryAPI.sharedInstance.getPois()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(CGColor: self.storyColor)
        self.navigationController?.navigationBar.translucent = false
        self.storyDescription.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        self.storyDescription.text = storyDescriptionText
        self.storyDescription.scrollEnabled = false
        self.storyDescription.font = GlobalConstants.textFont
        visited = LibraryAPI.sharedInstance.getVisitedCount()
        
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
        
        self.tableView.separatorStyle = .None
        
        self.progress = CGFloat(visited) / CGFloat(allPois.count)
        addCircleView()
        
        self.storyIcon.image = UIImage(named: self.storyIconPath)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"updateDistance:", name: "setDistanceNotification", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func addCircleView() {
        var circleWidth = CGFloat(60)
        var circleHeight = circleWidth
        
        // Create a new CircleView
        var circleView = CircleView(frame: CGRectMake(0, 0, circleWidth, circleHeight))
        circleView.progress = self.progress
        
        self.progressCircle.addSubview(circleView)
        
        // Animate the drawing of the circle over the course of 1 second
        circleView.animateCircle(1.0)
        
        let textLabel = UILabel(frame: CGRectMake(0 ,0 , 60.0, 60.0))
        textLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        textLabel.textAlignment = .Center
        textLabel.textColor = UIColor.whiteColor()
        textLabel.text = String(stringInterpolationSegment: Int(self.progress*100)) + "%"
        self.progressCircle.addSubview(textLabel)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("poi") as? StoryPointsOfInterestListViewCell ?? StoryPointsOfInterestListViewCell()
        var poi = self.allPois[indexPath.row]
        
        cell.poiName.text = poi.title
        cell.locationAway.text = poi.getHumanDistance()
        cell.poiImage.image = poi.image

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPois.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDistance(notification: NSNotification) {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedPoi = allPois[indexPath.row]
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.selectedPoi = selectedPoi
        self.performSegueWithIdentifier("toContentFromStory", sender: self)
        
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "toContentFromStory":
                if var poiVC = segue.destinationViewController as? DetailedViewController {
                    poiVC.selectedPoi = self.selectedPoi
                }
                break;
            case "toCompassViewFromStory":
                /*
                    TO-DO: Pass the closest, unvisited POI to the compass view
                */
                if let var compassVC = segue.destinationViewController as? GGCompassViewController {
                    var sortedByDistance : [FecPoi] = allPois.sorted({ (a, b) -> Bool in
                        if (a.distance != nil && b.distance != nil) {
                            return a.distance < b.distance;
                        } else {
                            return false;
                        }
                    });
                    
                    var nextToVisit : FecPoi? = sortedByDistance.filter({
                        return $0.visit;
                    }).first;
                    
                    if (nextToVisit == nil) {
                        compassVC.destination = sortedByDistance.first!;
                    } else {
                        compassVC.destination = nextToVisit!;
                    }
                }
                break;
            default:
                break
        }
    }
    
}