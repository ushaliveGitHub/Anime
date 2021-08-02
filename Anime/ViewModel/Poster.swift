//
//  Poster.swift
//  Anime
//
//  Created by Usha Natarajan on 7/31/21.
//

import Foundation
import SwiftUI

/**
  # Image class for anime
 */
class Poster: ObservableObject {
    private var service: ApiService?
    private var endpoint: String?
    @Published var image: UIImage?
    var posterCache = PosterCache.getCache()
    
    //Poster class Will attempt to fetch image from cache , if it not available then, makes an API call to get the images
    init(_ endpoint: String?){
        guard let endpoint = endpoint else { return }
        self.endpoint = endpoint
        guard  loadImageFromCache(endpoint) else {
            self.service = ApiService(endpoint: endpoint)
            self.service?.delegate = self
            self.service?.getData()
            return
        }
    }
    
    func loadImageFromCache(_ urlString: String) ->Bool {
        guard let image = posterCache.get(forkey: urlString) else {
            return false
        }
        DispatchQueue.main.async {
            self.image = image
        }
        return true
    }
}
    
extension Poster: Service { // The delegate methods for API Service
    func didGetData(data: Data) {
        if let image = UIImage(data: data){
            //attempt to cache the image
            if let url = self.endpoint {
              posterCache.set(forkey: url, image: image)
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    func didGetError(error: Error) {
        debugPrint(error.localizedDescription)
    }
}

/**
 # The class to cache images
 */

class PosterCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forkey: String) ->UIImage? {
        return cache.object(forKey: NSString(string: forkey))
    }
    
    func set(forkey: String, image: UIImage){
        cache.setObject(image, forKey: NSString(string: forkey))
    }
}

extension PosterCache {
    private static var cache = PosterCache()
    static func getCache() -> PosterCache {
        return cache
    }
}
