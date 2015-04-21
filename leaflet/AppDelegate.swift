//
//  AppDelegate.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/4/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    // CONSTANTS
    let googleMapsApiKey = "AIzaSyAoKcrRBul4PmuGDzUfPKAi1_KoA0StmJQ"
    // Default uuid string for estimote beacons
    let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    let beaconIdentifier = "parks-and-rec.cmu.edu.Leaflet"
    
    var window: UIWindow?
    var locationManager: CLLocationManager?

    var knownBeacons = [NSNumber: CLProximity]()
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        GMSServices.provideAPIKey(googleMapsApiKey)
        
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        
        locationManager = CLLocationManager()
        
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
        
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil
                )
            )
        }
        
        if let options = launchOptions {
            if let notification = options[UIApplicationLaunchOptionsLocalNotificationKey] as? [NSObject : AnyObject] {
                println("So now it works.")
                //notification found mean that you app is opened from notification
            }
        }
        
        return true
    }

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        NSLog("FIREEEEEEE")
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CLLocationManagerDelegate {
    

    // actual method that registers the local notification.
    func sendLocalNotificationWithMessage(message: String!, playSound: Bool) {
        
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        
        if(playSound) {
            notification.soundName = "tos_beep.caf";
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        //            let viewController:ViewController = window!.rootViewController as ViewController
        //            viewController.beacons = beacons as [CLBeacon]?
        //            viewController.tableView!.reloadData()

        NSLog("didRangeBeacons: \(beacons.count)");
        var message:String = ""
        var foundBeacon:CLBeacon
        
        for beacon in beacons {
            
            foundBeacon = beacon as! CLBeacon
            
            if foundBeacon.proximity == CLProximity.Near || foundBeacon.proximity == CLProximity.Immediate {
                let prevProximity = knownBeacons[foundBeacon.major]
                if  prevProximity == nil || prevProximity != foundBeacon.proximity {
                    var poi:FecPoi? = LibraryAPI.sharedInstance.getPoiByBeaconMajor(foundBeacon.major.integerValue)
                    message = "Your are near the " + poi!.title + "!"
//                    message = "You are near beacon with major \(foundBeacon.major) and minor \(foundBeacon.minor)"
                    sendLocalNotificationWithMessage(message, playSound: true)
                }
            }
            knownBeacons[foundBeacon.major] = foundBeacon.proximity
//            } else {
//                knownBeacons[foundBeacon.major] = foundBeacon.proximity
//            }
            NSLog("beacon \(foundBeacon.major): proximity: \(foundBeacon.proximity.rawValue)")
        }

        NSLog("known beacons: \(knownBeacons.count)")
    }
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
            manager.startUpdatingLocation()
            
            NSLog("You entered the region")
            sendLocalNotificationWithMessage("You entered the region", playSound: true)
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            manager.stopUpdatingLocation()
            knownBeacons = [:]
            NSLog("You exited the region")
            sendLocalNotificationWithMessage("You exited the region", playSound: false)
    }
}
