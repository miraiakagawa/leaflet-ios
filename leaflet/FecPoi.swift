//
//  FecPoi.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit
import CoreLocation

class FecPoi: NSObject {
   
    let feetInMeters:Double = 3.28084
    
    var id: Int!
    var title: String!
    var content: String!
    var imageUrl: String!
    var image: UIImage!
    var beaconMajor: Int!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    var visit: Bool!
    var distance: Double?
    
    var coordinate : CLLocationCoordinate2D!
    
    init(id: Int, title: String, content: String, imageUrl: String, beaconMajor: Int, latitude: Double, longitude: Double) {
        super.init()
        self.id = id
        self.title = title
        self.content = content
        self.imageUrl = imageUrl
        self.beaconMajor = beaconMajor
        self.latitude = latitude
        self.longitude = longitude
        
        self.visit = false
        
        self.downloadImage()
    }
    
    override var description : String {
        return "title: \(title)"
    }
    
    func setVisiting(visit: Bool) {
        self.visit = visit
    }
    
    func setDistance(distanceInMetric: Double) {
        self.distance = distanceInMetric * feetInMeters
        NSNotificationCenter.defaultCenter().postNotificationName("setDistanceNotification", object: self)
    }
    
    func getHumanDistance() -> String {
        if (self.distance == nil) {
//            return "Unknown distance away."
            return "A little further."
        }
        else if (self.distance < 10) {
            return "You are here!"
        } else {
//            return "\(Int(self.distance!)) feet away."
            return "A short walk away,"
        }
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
