//
//  SecondViewController.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/4/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit
import CoreLocation

class MapViewController: UIViewController, ENSideMenuDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func revealListView(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("listView") as! UITableViewController
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}

