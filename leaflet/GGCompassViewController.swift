//
//  GGCompasViewController.swift
//  CompassViewController
//
//  Created by Tommy Doyle on 4/24/15.
//  Copyright (c) 2015 Tommy Doyle. All rights reserved.
//

import UIKit
import CoreLocation

class GGCompassViewController: UIViewController, CLLocationManagerDelegate, ENSideMenuDelegate {
    
    var locationManager: CLLocationManager!
    var compass : GGCompass!
    var compassView : GGCompassNavView!;
//    var destination : FecPoi?;
    var destination: CLLocation?
    
    var mostRecentHeading: CLHeading?
    var mostRecentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.compassView = GGCompassNavView.NewGGCompassNavView(self);
        
        self.view = compassView;
        self.compass = GGCompass();
        
        // For Debugging in the simulator
        // 202000 Lucille Ave, Cupertino, CA
        let defaultDestination = CLLocation(latitude: 40.448942, longitude: -79.948149);
//        let defaultDestination = CLLocation(latitude: 40.445835, longitude: -79.948833);
//        self.compass.destination = defaultDestination;
        self.compassView.destinationName = "Random Place";
        destination = defaultDestination

        if (destination != nil) {
//            compassView.destinationImage = destination!.image;
//            compassView.destinationName = destination!.title;
            
//            compass.destination = destination?.coordinate;
        }
        
        startHeadAndLocationUpdates();
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.clipsToBounds = true
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
        self.navigationController!.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: CoreLocation Handlers
    
    func startHeadAndLocationUpdates() {
        if(locationManager == nil) {
            locationManager = CLLocationManager();
        }
        
        locationManager.delegate = self;
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestAlwaysAuthorization();
        }
        
        locationManager.startUpdatingLocation();
        locationManager.startUpdatingHeading();
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            mostRecentLocation = location
            // NSLog("Lat: \(location.coordinate.latitude), Long: \(location.coordinate.longitude)");
            
//            var (newDirection, newDistance) = compass.directionAndDistanceToDestination(location);
//            var destinationDistance = 
//            compassView.updateDirectionToDestination(newDirection);
//            compassView.updateDistanceToDestination(newDistance);
            if (mostRecentHeading != nil) {
                var destinationHeading = compass.headingFromPointToPoint(mostRecentLocation!, to: destination!)
                compassView.updateCompassPointer(mostRecentHeading!.trueHeading, destinationHeading: destinationHeading)
            }
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        if let heading = newHeading {
            mostRecentHeading = newHeading
            if (mostRecentLocation != nil) {
                var destinationHeading = compass.headingFromPointToPoint(mostRecentLocation!, to: destination!)
                compassView.updateCompassPointer(mostRecentHeading!.trueHeading, destinationHeading: destinationHeading)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog(error.description);
    }
    
    @IBAction func revealListView(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("listView") as! UITableViewController
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}

