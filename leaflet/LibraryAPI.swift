//
//  LibraryAPI.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
   
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    class var sharedInstance: LibraryAPI {
        
        struct Singleton {
            static let instance = LibraryAPI()
        }

        return Singleton.instance
    }

    override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = true
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"downloadImage:", name: "BLDownloadImageNotification", object: nil)

    }
    
    func getPois() -> [FecPoi] {
        return persistencyManager.getPois()
    }
    
    func getPointsOfInterest() -> [PointOfInterest] {
        return persistencyManager.getPointsOfInterest()
    }
    
    func getPoiByBeaconMajor(major: Int) -> FecPoi? {
        var allPois = persistencyManager.getPois()
        for poi in allPois {
            if poi.beaconMajor == major {
                return poi
            }
        }
        return nil
    }
    
    func getPoiById(id: Int) -> FecPoi? {
        var allPois = persistencyManager.getPois()
        for poi in allPois {
            if poi.id == id {
                return poi
            }
        }
        return nil
    }
    
//    func addAlbum(album: Album, index: Int) {
//        persistencyManager.addAlbum(album, index: index)
//        if isOnline {
//            httpClient.postRequest("/api/addAlbum", body: album.description())
//        }
//    }
//    
//    func deleteAlbum(index: Int) {
//        persistencyManager.deleteAlbumAtIndex(index)
//        if isOnline {
//            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
//        }
//    }
    
    func downloadImage(notification: NSNotification) {
        //1
        let userInfo = notification.userInfo as! [String: AnyObject]
        var imageView = userInfo["imageView"] as! UIImageView?
        let coverUrl = userInfo["coverUrl"] as! NSString
        
        //2
        if let imageViewUnWrapped = imageView {
            imageViewUnWrapped.image = persistencyManager.getImage(coverUrl.lastPathComponent)
            if imageViewUnWrapped.image == nil {
                //3
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                    let downloadedImage = self.httpClient.downloadImage(coverUrl as String)
                    //4
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        imageViewUnWrapped.image = downloadedImage
                        self.persistencyManager.saveImage(downloadedImage, filename: coverUrl.lastPathComponent)
                    })
                })
            }
        }
    }
    
}
