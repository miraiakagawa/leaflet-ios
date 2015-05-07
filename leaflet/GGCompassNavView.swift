//
//  GGCompassNavView.swift
//  CompassView
//
//  Created by Tommy Doyle on 4/25/15.
//  Copyright (c) 2015 Tommy Doyle. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class GGCompassNavView: UIView {
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var distnaceToGo: UILabel!
    @IBOutlet weak var compassPointerImage: UIImageView!
    @IBOutlet weak var destinationImageView: UIImageView!
    
    var destinationName : String = "No Where!" {
        didSet {
            destinationLabel.text? = destinationName;
        }
    };
    
    var destinationImage : UIImage? {
        didSet {
            if(destinationImage != nil) {
                destinationImageView.image = destinationImage;
            }
        }
    }
    
    // Convience Initializer for GGCompassNavView
    class func NewGGCompassNavView(owner : AnyObject) -> GGCompassNavView {
        var newView: AnyObject? = NSBundle.mainBundle().loadNibNamed("GGCompassNavView", owner: owner, options: nil).first;
        return (newView as! GGCompassNavView);
    }
    
    /**
    * @args:
    *   deviceHeading: the angle from due North of the orientation of the Device
    *   destinationHeading: the angle from due North of the Destination from current location
    *
    * Updates the compass angle on the screen based on the difference between the two angles.
    *
    */
    func updateCompassPointer(deviceHeading : CLLocationDirection, destinationHeading : CLLocationDirection) {
        let radius = 70.0
        let TO_RAD = M_PI/180
        
        var newX : Double
        var newY : Double
        var deviceRotation : Double = deviceHeading
        var destinationRotation : Double = destinationHeading
        var compassRotation = destinationRotation - deviceRotation
        
        let width = Double(compassPointerImage.frame.width)
        let height = Double(compassPointerImage.frame.height)
        
        let centerX = compassPointerImage.frame.origin.x
        let centerY = compassPointerImage.frame.origin.y
        
        let currentX = Double(compassPointerImage.frame.origin.x)
        let currentY = Double(compassPointerImage.frame.origin.y)
        
        newX = cos(compassRotation * TO_RAD) * radius + Double(centerX)
        newY = sin(compassRotation * TO_RAD) * radius + Double(centerY)
        
        var pointer : UIImageView = compassPointerImage
        
        UIView.animateWithDuration(0.5, animations: {
            var newDirectionRad = compassRotation * TO_RAD
            pointer.transform = CGAffineTransformMakeRotation(CGFloat(newDirectionRad))
            return ()
        })
    }
    
    func updateDistanceToDestination(newDistance : CLLocationDistance) {
        distnaceToGo.text? = String(format: "%0.0f ft", newDistance);
    }
    
}
