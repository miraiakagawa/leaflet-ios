//
//  AppDelegate.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/4/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit
import CoreLocation

/**
* AppDelegate, which also acts as the CLLocationManagerDelegate, meaning any system notifications to do with locations will get handled in this class.
* To avoid clogging, created an extension which handles the CLLocationManagerDelegate specifically, see below.
*/
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    // CONSTANTS
    // TODO: generate a new uuid just for this application to use and set all beacons with this uuid
    // Default uuid string for estimote beacons
    let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    let beaconIdentifier = "parks-and-rec.cmu.edu.Leaflet"
    
    // location manager will handle region monitoring and changes in beacon region
    var locationManager: CLLocationManager?

    var window: UIWindow?

    // an array of known beacons. // TODO: move this to API
    var knownBeacons = [NSNumber: CLProximity]()
    
    private var allPois = [FecPoi]()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        /************** BEACON MONITORING SETUP **************/
        
        // set up location manager which will handle beacon regions, etc.
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        // ask user permission to use location stuff
        if locationManager!.respondsToSelector("requestAlwaysAuthorization") {
            locationManager!.requestAlwaysAuthorization()
        }
        
        // set beacon region based on the uuid string constant
        // note that by fixing the uuid and controlling major/minor values, we only need to monitor one region
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        
        // start monitoring and updating for the specified region.
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
        
        /************** REGISTER NOTIFICATION **************/
        
        // Register local notifications. Currently this app does not use remote notifications.
        // Also ask permission if not done already.
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil
                )
            )
        }
        

        /************** INITIATED POIS **************/
        
        allPois = LibraryAPI.sharedInstance.getPois()

        
        return true
    }
    
    /**
    * This is the app delegate method that catches how the app responds when a local notification is fired.
    * Here, one of two things can happen:
    *   1. The app was opened from a notification, and has emerged to the foreground process
    *   2. The app was already running in the foreground, and a notification was fired. (Does not actually show up as a notification)
    */
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {

        if notification.userInfo != nil && notification.userInfo!["poiId"] != nil {
            let poiId:Int = notification.userInfo!["poiId"] as! Int
            var selectedPoi = LibraryAPI.sharedInstance.getPoiById(poiId)
            NSLog("POI Id is: \(poiId)")
            
            switch application.applicationState {
            case UIApplicationState.Active:
                NSLog("Active")
                var title = "Hey there, it seems like  you are near the " + selectedPoi!.title + "!"
                var alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                let cancelAction = UIAlertAction(title: "not now", style: .Cancel) { (action) in
                    // nothing happens
                }
                alert.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "Learn More", style: .Default) { (action) in
                    self.displayDetailedView(selectedPoi!)
                }
                alert.addAction(OKAction)

                if let rvc = self.window?.rootViewController as? SideBarNavigationViewController {
                    rvc.presentViewController(alert, animated: true, completion: nil)
                }
            case UIApplicationState.Inactive:
                displayDetailedView(selectedPoi!)
            default:
                return
            }
        }
    }
    
    func displayDetailedView(selectedPoi: FecPoi) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        
        var vc: DetailedViewController = mainStoryboard.instantiateViewControllerWithIdentifier("detailedView") as! DetailedViewController
        vc.selectedPoi = selectedPoi
        
        if let rvc = self.window?.rootViewController as? SideBarNavigationViewController {
            rvc.setContentViewController(vc)
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CLLocationManagerDelegate {
    
    /*
    * actual method that registers the local notification.
    */
    func sendLocalNotificationWithMessage(title: String!, message: String!, playSound: Bool, userInfo: [String:Int?]) {
        
        // construct the notification with a message.
        let notification:UILocalNotification = UILocalNotification()
        notification.alertTitle = title
        notification.alertBody = message
        
        // we can attach an id to the notification so we know which poi to retrieve when the user opens.
        if let id = userInfo["poiId"] {
            notification.userInfo = ["poiId": id!]
        }

        // play a custom sound when the notification fires
        if(playSound) {
            notification.soundName = "tos_beep.caf";
        }
        
        // send
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {

        var message:String = ""
        
        var foundBeacon:CLBeacon
        
        for beacon in beacons {
            
            foundBeacon = beacon as! CLBeacon
            var poi:FecPoi? = LibraryAPI.sharedInstance.getPoiByBeaconMajor(foundBeacon.major.integerValue)
            
            if foundBeacon.proximity == CLProximity.Near || foundBeacon.proximity == CLProximity.Immediate {
                let prevProximity = knownBeacons[foundBeacon.major]
                if  prevProximity == nil || prevProximity != foundBeacon.proximity {
                    if (poi?.visit == false) {
                        message = "Hey there, it seems like you are near the " + poi!.title + "!"
                        var userInfo = ["poiId": poi?.id]
                        sendLocalNotificationWithMessage(nil, message: message, playSound: true, userInfo: userInfo)
                    }
                    poi?.setVisiting(true)
                }
            }
            
            if (foundBeacon.proximity != CLProximity.Unknown && poi != nil) {
                poi?.setDistance(foundBeacon.accuracy)
            }
            
            knownBeacons[foundBeacon.major] = foundBeacon.proximity
        }

    }
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
            manager.startUpdatingLocation()
            
            NSLog("You entered the region")
//            sendLocalNotificationWithMessage("You entered the region", playSound: true)
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            manager.stopUpdatingLocation()
            knownBeacons = [:]
            NSLog("You exited the region")
//            sendLocalNotificationWithMessage("You exited the region", playSound: false)
    }
}
