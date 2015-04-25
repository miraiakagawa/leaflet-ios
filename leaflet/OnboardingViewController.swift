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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showNext")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    func showNext() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (self.restorationIdentifier!) {
        case "firstPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("secondPage") as! UIViewController
            break
        case "secondPage":
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("thirdPage")as! UIViewController
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("firstPage") as! UIViewController
            break
        }
        self.presentViewController(destViewController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}