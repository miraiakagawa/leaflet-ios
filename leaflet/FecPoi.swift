//
//  FecPoi.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit
import ObjectiveC

class FecPoi: NSObject {
   
    var id: Int!
    var title: String!
    var content: String!
    var imageUrl: String!
    var image: UIImage!
    var beaconMajor: Int!
    var visit: Bool!

    init(id: Int, title: String, content: String, imageUrl: String, beaconMajor: Int) {
        super.init()
        self.id = id
        self.visit = false
        self.title = title
        self.content = content
        self.imageUrl = imageUrl
        self.beaconMajor = beaconMajor
        
        self.downloadImage()
    }
    
    override var description : String {
        return "title: \(title)"
    }
    
    func setVisiting(visit: Bool) {
        self.visit = visit
    }
    
    func downloadImage() {
        var httpClient = HTTPClient()
        if let url = NSURL(string: GlobalConstants.remoteAPIUrl + self.imageUrl) {
            httpClient.getImageFromUrl(url) { data in
                dispatch_async(dispatch_get_main_queue()) {
                    self.image = data
                }
            }
        }
    }
}
