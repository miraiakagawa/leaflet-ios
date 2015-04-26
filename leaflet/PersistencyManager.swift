//
//  PersistencyManager.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
   
    private var fecPois = [FecPoi]()
    private var stories = [Story]()
    var httpClient: HTTPClient
    
    override init() {
        httpClient = HTTPClient()
        
        super.init()

        fecPois = []
    
        if let jsonUrl = NSURL(string: GlobalConstants.remoteAPIUrl + GlobalConstants.remoteAPIPoisPath) {
            httpClient.getJSONArrayFromUrl(jsonUrl) { data in
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if (data != nil) {
                        for poi in data! {
                            self.fecPois.append(FecPoi(id: poi["id"] as! Int,
                                title: poi["title"] as! String,
                                content: poi["content"] as! String,
                                imageUrl: poi["img"] as! String,
                                beaconMajor: poi["beaconMajor"] as! Int))
                        }
                    }
                }
            }
        }
        
       stories = [
            Story(id: 1, title: "Water",
                content: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
                pointsOfInterest: [],
                color: UIColor(hex: 0x2EA9FC).CGColor,
                picture: "Water.png",
                storyIcon: "WaterHexagon.png"
            ),
            Story(id: 2, title: "Energy",
                content: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
                pointsOfInterest: [],
                color: UIColor.orangeColor().CGColor,
                picture: "Energy.png",
                storyIcon: "EnergyHexagon.png"
            ),
            Story(id: 3, title: "Heat",
                content: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
                pointsOfInterest: [],
                color: UIColor.redColor().CGColor,
                picture: "Heat.png",
                storyIcon: "HeatHexagon.png"
            ),
            Story(id: 4, title: "Plants",
                content: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
                pointsOfInterest: [],
                color: UIColor.greenColor().CGColor,
                picture: "Plants.png",
                storyIcon: "PlantsHexagon.png"
            ),
            Story(id: 5, title: "Explore",
                content: "Both our wellness and that of our environment depends greatly on the quality of water available to us. This means we need to take great care to protect our ground water as well as efficiently collect rain water. The center has various practical as well as beautiful features revolving around our water.",
                pointsOfInterest: [],
                color: UIColor.grayColor().CGColor,
                picture: "Explore.png",
                storyIcon: "ExploreHexagon.png"
            )
        ]
        
    }
    
    func getPois() -> [FecPoi] {
        return fecPois
    }
    
    func getStories() -> [Story] {
        return stories
    }

}
