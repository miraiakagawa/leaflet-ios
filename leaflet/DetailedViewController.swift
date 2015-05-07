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
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var button: UIButton!
    
    var backgroundNavColor: UIColor = UIColor(hex: 0x2EA9FC)
    
    let savedForHomeButtonName = "SavedForHomeButton"
    
    private var allPois = [FecPoi]()
    private var stories = [Story]()
    private var visited = LibraryAPI.sharedInstance.getVisitedCount()
    private var saved = [FecPoi]()
    
    var selectedPoi:FecPoi? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = backgroundNavColor

        stories = LibraryAPI.sharedInstance.getStories()
        allPois = LibraryAPI.sharedInstance.getPois()
        saved = LibraryAPI.sharedInstance.getSaved()
        
        // if for some reason the segue didn't register a selected poi, just choose the first one
        if (selectedPoi == nil) {
            selectedPoi = allPois[0]
        }
        
        // set the content on the page with the selected poi information
        navBar.title = selectedPoi?.title
        textView.text = selectedPoi?.content
        imageView.image = selectedPoi?.image
        
        // if the poi is already visited, set the saved icon
        if contains(saved, selectedPoi!) {
            self.button.setImage(UIImage(named: savedForHomeButtonName), forState: UIControlState.Normal)
        }
        
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
        
        // rewards overlay. // TODO: make this a modal based view
        createOverlay()
        checkRewards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toCompassViewFromPoi" {
            if let var compassVC = segue.destinationViewController as? GGCompassViewController {
//                compassVC.destination = selectedPoi!
            }
        }
        
    }
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        let n: Int! = self.navigationController?.viewControllers?.count
        let myUIViewController = self.navigationController?.viewControllers[n-1] as? UIViewController
        if ((myUIViewController as? StoryViewController) == nil) {
            self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
        }
    }
    
    @IBAction func savePoi(sender: AnyObject) {
        if (selectedPoi != nil) {
            LibraryAPI.sharedInstance.savePoi(selectedPoi!)
            self.button.setImage(UIImage(named: savedForHomeButtonName), forState: UIControlState.Normal)
        }
    }
    
    func createOverlay() {
        var name:String = "Umbrella"
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds //view is self.view in a UIViewController
            self.overlay.addSubview(blurEffectView)
            //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view
            
            //                sticker image
            let stickerImage = UIImageView(frame: CGRectMake(0, 100, 150, 150))
            stickerImage.backgroundColor = UIColor(hex: GlobalConstants.darkGreen)
            stickerImage.image = UIImage(named: name)
            stickerImage.layer.cornerRadius = stickerImage.frame.size.width / 2;
            stickerImage.clipsToBounds = true
            stickerImage.frame.origin.x = CGRectGetMidX(view.bounds) - CGRectGetMidX(stickerImage.bounds)
            self.overlay.addSubview(stickerImage)
            
            //                reward text
            let headingText = UILabel(frame: CGRectMake(0, 250, 200, 100))
            headingText.text = "You Got The " + name + " Sticker!"
            headingText.font = GlobalConstants.titleFont
            headingText.textColor = UIColor(hex: GlobalConstants.white)
            headingText.textAlignment = .Center
            headingText.lineBreakMode = .ByWordWrapping
            headingText.numberOfLines = 2
            headingText.frame.origin.x = CGRectGetMidX(view.bounds) - CGRectGetMidX(headingText.bounds)
            self.overlay.addSubview(headingText)
            
            let subheadingText = UILabel(frame: CGRectMake(0, 325, 200, 100))
            subheadingText.text = "Keep exploring to get more stickers just like this one!"
            subheadingText.font = GlobalConstants.defaultFont
            subheadingText.textColor = UIColor(hex: GlobalConstants.white)
            subheadingText.textAlignment = .Center
            subheadingText.lineBreakMode = .ByWordWrapping
            subheadingText.numberOfLines = 2
            subheadingText.frame.origin.x = CGRectGetMidX(view.bounds) - CGRectGetMidX(subheadingText.bounds)
            self.overlay.addSubview(subheadingText)
            
            //                button
            let button = UIButton(frame: CGRectMake(0, 425, 150, 30))
            button.backgroundColor = UIColor(hex: GlobalConstants.mediumGray)
            button.setTitleColor(UIColor(hex: GlobalConstants.textGray), forState: UIControlState.Normal)
            button.setTitle("Got It", forState: UIControlState.Normal)
            button.addTarget(self, action: "dismissReward", forControlEvents: UIControlEvents.TouchUpInside)
            button.frame.origin.x = CGRectGetMidX(view.bounds) - CGRectGetMidX(button.bounds)
            button.layer.cornerRadius = 5;
            self.overlay.addSubview(button)
            
            //add auto layout constraints so that the blur fills the screen upon rotating device
            blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
            view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
            
            self.overlay.setTranslatesAutoresizingMaskIntoConstraints(false)
            view.addConstraint(NSLayoutConstraint(item: self.overlay, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: self.overlay, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: self.overlay, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: self.overlay, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        } else {
            view.backgroundColor = UIColor.blackColor()
        }
    }
    
    func checkRewards() {
        if (visited % 3 == 2) {
            showReward()
        } else {
            dismissReward()
        }
    }
    
    func showReward() {
        self.navigationController?.navigationBar.hidden = true
        self.overlay.hidden = false
    }
    
    func dismissReward() {
        self.navigationController?.navigationBar.hidden = false
        self.overlay.hidden = true
    }
}
