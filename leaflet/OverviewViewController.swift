//
//  FirstViewController.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/4/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

protocol OverviewViewControllerDelegate: class {
    func typesController(controller: OverviewViewController, didSelectTypes types: [String])
}

class OverviewViewController: UITableViewController {

    private var allPois = [FecPoi]()
//    private var selectedPoi:FecPoi? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allPois = LibraryAPI.sharedInstance.getPois()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var selectedTypes: [String]!
    weak var delegate: OverviewViewControllerDelegate!
    
    // MARK: - Actions
//    @IBAction func donePressed(sender: AnyObject) {
//        delegate?.typesController(self, didSelectTypes: selectedTypes)
//    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !allPois.isEmpty {
            return allPois.count
        } else {
            return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath) as! UITableViewCell
        let poi = allPois[indexPath.row]
        cell.textLabel?.text = poi.title
//        cell.imageView?.image = UIImage(named: key)
//        cell.accessoryType = contains(selectedTypes!, key) ? .Checkmark : .None
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailedViewSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let selectedIndex = indexPath?.row
            if let index = selectedIndex {
                let selectedPoi = allPois[index]
                let detailedViewController = segue.destinationViewController.topViewController as! DetailedViewController
                detailedViewController.selectedPoi = selectedPoi
            }


        }
    }
    
    // MARK: - Table view delegate
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        var selectedPoi = allPois[indexPath.row]
//        let key = sortedKeys[indexPath.row]
//        if contains(selectedTypes!, key) {
//            selectedTypes = selectedTypes.filter({$0 != key})
//        } else {
//            selectedTypes.append(key)
//        }
//        println(indexPath.row)
//        tableView.reloadData()
//    }

}

