//
//  GlobalConstants.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/22/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import Foundation

struct GlobalConstants {
    
//    COLORS
    static let darkGreen = 0x327935
    static let mediumGreen = 0x4CAF50
    static let lightGreen = 0x62EC68
    static let washedOutGreen = 0xEFFFF2
    
    static let textGray = 0x4A4A4A
    static let darkGray = 0x969696
    static let mediumGray = 0xD4D4D4
    static let lightGray = 0xEFEFF0
    static let white = 0xFFFFFF
    
    static let black = 0x000000
    
//    default coloring
    static let defaultNavColor = mediumGreen
    static let defaultNavTextColor = white
    static let bodyTextColor = textGray
    static let menuTextColor = black
    
    static let onboardingTextColor = white
    static let onboardingBackgroundColor = mediumGreen
    
//    text stylings
    static let defaultFont = UIFont(name: "HelveticaNeue-Light", size: 16)
    static let subHeadingFont = UIFont(name: "HelveticaNeue-Light", size: 14)
    static let textFont = UIFont(name: "HelveticaNeue-Light", size: 14)
    
    // remote api - currently hosted on makagawa.com
    static let remoteAPIUrl = "http://leaflet.makagawa.com/api"
    static let remoteAPIPoisPath = "/pois"
}