//
//  GlobalConstants.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/22/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import Foundation

struct GlobalConstants {
    
//    defaults
    static let defaultNavColor = 0x61CE72
    static let defaultNavTextColor = 0xFFFFFF
    static let defaultFont = UIFont(name: "HelveticaNeue-Light", size: 16)
    
    
//    text stylings
    static let bodyTextColor = 0x4A4A4A
    static let menuTextColor = 0x000000
    static let subHeadingFont = UIFont(name: "HelveticaNeue-Light", size: 12)
    
//    onboarding stylings
    static let onboardingTextColor = 0xFFFFFF
    static let onboardingBackgroundColor = 0x61CE72
    
    // remote api - currently hosted on makagawa.com
    static let remoteAPIUrl = "http://leaflet.makagawa.com/api"
    static let remoteAPIPoisPath = "/pois"
}