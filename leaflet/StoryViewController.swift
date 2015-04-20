//
//  StoryView.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/19/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var storyDescription: UITextView!
    var storyDescriptionText: String = ""
    var backgroundNavColor: UIColor = UIColor(hex: 0x61CE72)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = backgroundNavColor
        self.storyDescription.text = storyDescriptionText
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}