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

    let fakeDestination = CLLocation(latitude: 40.448942, longitude: -79.948149);
//    let fakeDestination = CLLocation(latitude: 40.445835, longitude: -79.948833);
    
    var locationManager: CLLocationManager!
    var compass : GGCompass!
    var compassView : GGCompassNavView!;

    var destination: CLLocation?
    var destinationPoi: FecPoi?
    
    var mostRecentHeading: CLHeading?
    var mostRecentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.compassView = GGCompassNavView.NewGGCompassNavView(self);
        
        self.view = compassView;
        self.compass = GGCompass();
        
        if (destinationPoi == nil) {
            destinationPoi = LibraryAPI.sharedInstance.getFirstPoi()
        }
        
        destination = CLLocation(latitude: destinationPoi!.latitude, longitude: destinationPoi!.longitude)
        
        compassView.destinationImage = destinationPoi!.image;
        compassView.destinationName = destinationPoi!.title;

        startHeadAndLocationUpdates();
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.clipsToBounds = true
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
        self.navigationController!.navigationBar.hidden = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"updateDistance:", name: "setDistanceNotification", object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    func updateDistance(notification: NSNotification) {
        compassView.updateDistanceToDestination(destinationPoi!.getHumanDistance())
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

