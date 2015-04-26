//
//  HTTPClient.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

// TODO Should be static class or shared instance.
// TODO: need to check status code and only respond if 200
class HTTPClient {
    
    func getJSONArrayFromUrl(url:NSURL, completion: ((data: NSArray?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResponse: NSArray! = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSArray
            
            if (jsonResponse != nil) {
                completion(data: jsonResponse)
            } else {
                NSLog("Accessing API Failed.")
                completion(data: nil)
            }
            
            }.resume()
    }
    
    func getJSONFromUrl(url:NSURL, completion: ((data: NSDictionary?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResponse: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResponse != nil) {
                completion(data: jsonResponse)
            } else {
                NSLog("Accessing API Failed.")
                completion(data: nil)
            }
        
        }.resume()
    }

    func getImageFromUrl(url:NSURL, completion: ((data: UIImage?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            var imageData:NSData = data
            completion(data: UIImage(data: imageData))
        
        }.resume()
    }
    
}
