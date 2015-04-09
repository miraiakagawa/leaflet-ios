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
   
    var title : String!
    var content: String!
    var pictureUrl : String!
    
    init(title: String, content: String, pictureUrl: String) {
        super.init()
        self.title = title
        self.content = content
        self.pictureUrl = pictureUrl
    }
    
    override var description : String {
        return "title: \(title)"
    }
}
