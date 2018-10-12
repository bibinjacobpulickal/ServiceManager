//
//  UIImageExtensions.swift
//  ChatTemplate
//
//  Created by Bibin Jacob Pulickal on 14/07/2018.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadCachedImage(from urlString: String?) {
        
        if let urlString = urlString,
            let chachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = chachedImage
        } else {
            loadImage(from: urlString)
        }
    }
    
    func loadImage(from urlString: String?) {
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            if let error = error {
                Network.shared.logSession(URLRequest(url: url), data, nil, error)
                return
            }
            guard let imageData = data, let downloadedImage = UIImage(data: imageData) else { return }
            imageCache.setObject(downloadedImage, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }).resume()
    }
}
