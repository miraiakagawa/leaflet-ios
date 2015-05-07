//
//  GGCompass.swift
//  CompassView
//
//  Created by Tommy Doyle on 4/25/15.
//  Copyright (c) 2015 Tommy Doyle. All rights reserved.
//

import Foundation
import CoreLocation
import Darwin

class GGCompass : NSObject {
    
    let TO_RAD = M_PI / 180
    let TO_DEG = 180 / M_PI
    let R = 3959.0 * 5280.0 // Radius of the earth in feet
    
    override init() {
        super.init();
    }
    
    func distanceBetweenPoints(point1: CLLocation, point2: CLLocation) -> Double {

        let lat1 = point1.coordinate.latitude;
        let long1 = point1.coordinate.longitude;
        let lat2 = point2.coordinate.latitude;
        let long2 = point2.coordinate.longitude;

        // Calculate distance between two lat, long points
        var phi1 = lat1 * TO_RAD;
        var phi2 = lat2 * TO_RAD;

        var dPhi = (lat2 - lat1) * TO_RAD;
        var dLambda = (long2 - long1) * TO_RAD;

        var a = pow(sin(dPhi/2), 2.0) + cos(phi1) * cos(phi2) *
            pow(sin(dLambda/2), 2.0);
        var c = 2 * atan2(sqrt(a), sqrt(1-a));

        return R * c;
    }
    
    func headingFromPointToPoint(from: CLLocation, to: CLLocation) -> CLLocationDirection {
        
        // Set up constants in mathemtical form
        let phi1 = from.coordinate.latitude * TO_RAD;
        let phi2 = to.coordinate.latitude * TO_RAD;
        
        let lambda1 = from.coordinate.longitude * TO_RAD;
        let lambda2 = to.coordinate.longitude * TO_RAD;
    
        let y = sin(lambda2 - lambda1) * cos(phi2);
        let x = cos(phi1)*sin(phi2) - sin(phi1)*cos(phi2)*cos(lambda2 - lambda1);
        
        return atan2(y, x) * TO_DEG;
    }
    
}
