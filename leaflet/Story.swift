//
//  Story.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/26/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class Story: NSObject {

    var id: Int!
    var title: String
    var content: String
    var pointsOfInterest: [FecPoi]
    var color: CGColor
    var picture: String
    var storyIcon: String
    
    init(id: Int, title: String, content: String, pointsOfInterest: [FecPoi], color: CGColor, picture: String, storyIcon: String) {
        self.id = id
        self.title = title
        self.content = content
        self.pointsOfInterest = pointsOfInterest
        self.color = color
        self.picture = picture
        self.storyIcon = storyIcon
        
        super.init()
    }
}
