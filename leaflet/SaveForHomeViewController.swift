//
//  SaveForHomeTableViewController.swift
//  leaflet
//
//  Created by Cindy Zeng on 5/4/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class SaveForHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ENSideMenuDelegate {
    
    private var allSaved = [FecPoi]()
    var selectedSaved: FecPoi!
    @IBOutlet weak var textInstructions: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("saved") as? SaveForHomeListViewCell ?? SaveForHomeListViewCell()
        var saved = self.allSaved[indexPath.row]
        
        cell.poiImage.image = saved.image
        cell.poiName.text = saved.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allSaved.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("did select row: \(indexPath.row)")
        
        var cell = tableView.dequeueReusableCellWithIdentifier("saved", forIndexPath: indexPath) as! SaveForHomeListViewCell
        
        self.selectedSaved = allSaved[indexPath.row]
        self.performSegueWithIdentifier("toContentFromAtHome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = false
        
        self.allSaved = LibraryAPI.sharedInstance.getSaved()
        
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60.0
        self.tableView.backgroundColor = UIColor(hex: GlobalConstants.lightGray)
        
        self.headerView.backgroundColor = UIColor(hex: GlobalConstants.washedOutGreen)
        self.textInstructions.backgroundColor = UIColor.clearColor()
        self.textInstructions.font = GlobalConstants.textFont
        self.textInstructions.textColor = UIColor(hex: GlobalConstants.black)
        self.textInstructions.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
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
        case "toContentFromAtHome":
            if var poiVC = segue.destinationViewController as? DetailedViewController {
                poiVC.selectedPoi = self.selectedSaved
            }
        default:
            break
        }
        
    }
}