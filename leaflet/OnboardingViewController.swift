//
//  OnboardingViewController.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/25/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var circle1: UIView?
    @IBOutlet weak var circle2: UIView?
    @IBOutlet weak var startCompass: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var swipeLeftGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showNext")
        swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        var swipeRightGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showPrevious")
        swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightGestureRecognizer)
        
        if circle1 != nil {
            addCircleView(circle1!)
        }
        
        if circle2 != nil {
            addCircleView(circle2!)
        }
        
        if startCompass != nil {
            startCompass!.clipsToBounds = true
            startCompass!.addTarget(self, action: "btnPressed", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        hideSideMenuView()
        self.navigationController!.navigationBar.hidden = true
    }
    
    func showNext() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (self.restorationIdentifier!) {
        case "firstPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("secondPage") as! UIViewController
            break
        case "secondPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("thirdPage") as! UIViewController
            break
        case "thirdPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("fourthPage") as! UIViewController
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("firstPage") as! UIViewController
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    func showPrevious() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (self.restorationIdentifier!) {
        case "secondPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("firstPage") as! UIViewController
            break
        case "thirdPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("secondPage") as! UIViewController
            break
        case "fourthPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("thirdPage") as! UIViewController
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("firstPage") as! UIViewController
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    func btnPressed() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mapView") as! UIViewController
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    func addCircleView(view: UIView) {
        var circleWidth = CGFloat(50)
        var circleHeight = circleWidth
        
        // Create a new CircleView
        var circleView = CircleView(frame: CGRectMake(0, 0, circleWidth, circleHeight))
        circleView.progress = 1.0
        
        view.addSubview(circleView)
        
        // Animate the drawing of the circle over the course of 1 second
        circleView.animateCircle(1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}