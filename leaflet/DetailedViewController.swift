//
//  DetailedViewController.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    

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
    
    var backgroundNavColor: UIColor = UIColor(hex: 0x2EA9FC)
    
    private var allPois = [FecPoi]()
    
    var selectedPoi:FecPoi? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = backgroundNavColor

        allPois = LibraryAPI.sharedInstance.getPois()
        if (selectedPoi == nil) {
            selectedPoi = allPois[0]
        }
        
        navBar.title = selectedPoi?.title
        textView.text = selectedPoi?.content
        imageView.image = selectedPoi?.image
        
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NextPoi" {
            var index = find(allPois, selectedPoi!)
            if index != nil && index! + 1 < allPois.count {
                let detailedViewController = segue.destinationViewController as! DetailedViewController
                detailedViewController.selectedPoi = allPois[index! + 1]
            } else {
                println("end of story")
            }
        }
    }
    
    @IBAction func backButtonAction(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc:StoryViewController = mainStoryboard.instantiateViewControllerWithIdentifier("storyView") as! StoryViewController
        
        // TODO: temporary patch. move stories into api and fix all this shit
        vc.title = stories[0].title
        
        vc.storyDescriptionText = stories[0].description
        vc.storyIconPath = stories[0].storyIcon
        vc.storyColor = stories[0].color
        
        sideMenuController()?.setContentViewController(vc)
    }
        
}
