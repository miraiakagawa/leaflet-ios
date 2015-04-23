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
    private var pois = [PointOfInterest]()
    
    override init() {

        let poi1 = FecPoi(title: "Bathroom",
        content: "The faucets and toilets in the bathroom are fed by grey water from the underground cistern. The water is not potable, but works perfectly fine for uses like these. Additionally, the low-flow faucets and toilet flushers conserve water so that as little as possible is wasted.",
        pictureUrl: "images/bathroom.jpg",
                beaconMajor: 42)
        
        let poi2 = FecPoi(title: "Solar panels",
        content: "Up above your head, this arch is outfitted with solar panels that are used to power the building, and provide you with some shade.",
        pictureUrl: "images/solarpanels.jpg",
                beaconMajor: -1)

        let poi3 = FecPoi(title: "Rain barrels",
        content: "Rain barrels are used to catch any runoff from the solar panels when it’s raining. Water stored here is used to water the vegetable garden and the slavery to freedom garden, which are more water intensive than the native landscape. </br> Rain barrels are also useful in residential homes. They capture water from roof gutters and provide you with water to feed any plants you may have.",
        pictureUrl: "images/myimg.jpg",
                beaconMajor: -1)

        let poi4 = FecPoi(title: "Runoff of solar panels",
        content: "Any water runoff from the solar panel roof that the rain barrels can’t capture or hold is caught and stored by an underground water cistern. The water that it captures is used in the restrooms in Newell Simon Hall in the sinks and toilets.",
        pictureUrl: "images/watercistern.jpg",
                beaconMajor: -1)

        let poi5 = FecPoi(title: "Permeable pavement",
        content: "Most asphalts are too dense for moisture from rainfall to soak through. This asphalt is porous enough for water to percolate through to help recharge the groundwater of the area.",
        pictureUrl: "images/myimg.jpg",
                beaconMajor: -1)

        let poi6 = FecPoi(title: "Native plants",
        content: "All landscaping around the Newell Simon building is full of native, low resource consuming plants. In addition to being beautiful, they also do not exacerbate problems caused by invasive, non-native plants such as erosion or unhealthy dominance of a single plant species.",
        pictureUrl: "images/myimg.jpg",
                beaconMajor: -1)

        let poi7 = FecPoi(title: "Water treatment",
        content: "Below the atrium, there is water treatment equipment that treats blackwater. Blackwater is any water that comes from a sink, a toilet, or a shower. The equipment treats the water and the water can then be dispersed in a slow and natural way outdoors to be taken up by trees.",
        pictureUrl: "images/myimg.jpg",
                beaconMajor: 17149)

        let poi8 = FecPoi(title: "Water veil",
        content: "The water veil captures the runoff water from the north face of the building and drops off the roof of the building in a sheet. It then flows along the front of the building and then behind the building. On rainy days, the water veil mimics the naturally occurring waterfall. There is a walkway behind it so that you can walk behind the waterfall.",
        pictureUrl: "images/waterveil.jpg",
                beaconMajor: 7863)

        let poi9 = FecPoi(title: "Slavery to freedom garden",
        content: "This garden features different plants from different parts of Africa as well as different vegetables that can be grown in an ordinary house garden.",
        pictureUrl: "images/slavery.jpg",
                beaconMajor: -1)
          
        fecPois = [poi1, poi2, poi3, poi4, poi5, poi6, poi7, poi8, poi9]
        
        pois = [
            PointOfInterest(title: "Bathroom",
                content: "The faucets and toilets in the bathroom are fed by grey water from the underground cistern. The water is not potable, but works perfectly fine for uses like these. Additionally, the low-flow faucets and toilet flushers conserve water so that as little as possible is wasted.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Solar panels",
                content: "Up above your head, this arch is outfitted with solar panels that are used to power the building, and provide you with some shade.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Rain barrels",
                content: "Rain barrels are used to catch any runoff from the solar panels when it’s raining. Water stored here is used to water the vegetable garden and the slavery to freedom garden, which are more water intensive than the native landscape. </br> Rain barrels are also useful in residential homes. They capture water from roof gutters and provide you with water to feed any plants you may have.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Runoff of solar panels",
                content: "Any water runoff from the solar panel roof that the rain barrels can’t capture or hold is caught and stored by an underground water cistern. The water that it captures is used in the restrooms in Newell Simon Hall in the sinks and toilets.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Permeable pavement",
                content: "Most asphalts are too dense for moisture from rainfall to soak through. This asphalt is porous enough for water to percolate through to help recharge the groundwater of the area.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Native plants",
                content: "All landscaping around the Newell Simon building is full of native, low resource consuming plants. In addition to being beautiful, they also do not exacerbate problems caused by invasive, non-native plants such as erosion or unhealthy dominance of a single plant species.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Water treatment",
                content: "Below the atrium, there is water treatment equipment that treats blackwater. Blackwater is any water that comes from a sink, a toilet, or a shower. The equipment treats the water and the water can then be dispersed in a slow and natural way outdoors to be taken up by trees.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Water veil",
                content: "The water veil captures the runoff water from the north face of the building and drops off the roof of the building in a sheet. It then flows along the front of the building and then behind the building. On rainy days, the water veil mimics the naturally occurring waterfall. There is a walkway behind it so that you can walk behind the waterfall.",
                locationAway: 50,
                image: "rain-veil.jpg"),
            PointOfInterest(title: "Slavery to freedom garden",
                content: "This garden features different plants from different parts of Africa as well as different vegetables that can be grown in an ordinary house garden.",
                locationAway: 50,
                image: "rain-veil.jpg")
        ]
    }
    
    func getPois() -> [FecPoi] {
        return fecPois
    }
    
    func getPointsOfInterest() -> [PointOfInterest] {
        return pois
    }
    
    func saveImage(image: UIImage, filename: String) {
        let path = NSHomeDirectory().stringByAppendingString("/Documents/\(filename)")
        let data = UIImagePNGRepresentation(image)
        data.writeToFile(path, atomically: true)
    }
    
    func getImage(filename: String) -> UIImage? {
        var error: NSError?
        let path = NSHomeDirectory().stringByAppendingString("/Documents/\(filename)")
        let data = NSData(contentsOfFile: path, options: .UncachedRead, error: &error)
        if let unwrappedError = error {
            return nil
        } else {
            return UIImage(data: data!)
        }
    }
    
}
