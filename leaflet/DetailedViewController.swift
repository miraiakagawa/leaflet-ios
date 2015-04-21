//
//  DetailedViewController.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {


    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var textView: UITextView!

    private var allPois = [FecPoi]()
    
    var selectedPoi:FecPoi? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allPois = LibraryAPI.sharedInstance.getPois()
        if (selectedPoi == nil) {
            selectedPoi = allPois[0]
        }
        navBarTitle.title = selectedPoi?.title
        textView.text = selectedPoi?.content
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
    
}
