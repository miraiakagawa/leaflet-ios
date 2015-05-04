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
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var text: UITextView!
    
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
        
        hideSideMenuView()
        self.navigationController!.navigationBar.hidden = true
        
        self.view.backgroundColor = UIColor(hex: GlobalConstants.onboardingBackgroundColor)
        
        heading.textColor = UIColor(hex: GlobalConstants.onboardingTextColor)
        
        text.textColor = UIColor(hex: GlobalConstants.onboardingTextColor)
    }
    
    func showNext() {
        switch (self.restorationIdentifier!) {
            case "firstPage":
                self.performSegueWithIdentifier("onboardingToSecond", sender: self)
                break
            case "secondPage":
                self.performSegueWithIdentifier("onboardingToThird", sender: self)
                break
            case "thirdPage":
                self.performSegueWithIdentifier("onboardingToFourth", sender: self)
                break
            default:
                break
        }
    }
    
    func showPrevious() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnPressed(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("compassView") as! UIViewController
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