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
    var title : String!
    var content: String!
    var pictureUrl : String!
    var beaconMajor: Int!
    var visit: Bool!

    
    init(id: Int, title: String, content: String, pictureUrl: String, beaconMajor: Int) {
        super.init()
        self.id = id
        self.visit = false
        self.title = title
        self.content = content
        self.pictureUrl = pictureUrl
        self.beaconMajor = beaconMajor
    }
    
    override var description : String {
        return "title: \(title)"
    }
    
    func setVisiting(visit: Bool) {
        self.visit = visit
    }
}
