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
        isOnline = false
        
        super.init()
    }
    
    func getPois() -> [FecPoi] {
        return persistencyManager.getPois()
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
    
}
