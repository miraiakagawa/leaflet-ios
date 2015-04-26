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
        
    }
    
    func getPois() -> [FecPoi] {
        return fecPois
    }

}
