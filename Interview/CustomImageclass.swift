//
//  CustomImageclass.swift
//  Interview
//
//  Created by davy ngoma mbaku on 8/11/19.
//  Copyright © 2019 davy ngoma mbaku. All rights reserved.
//


import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageclass: UIImageView {
    var imageURL: URL?
    func loadImageWithUrl(_ url: URL) {
        imageURL = url
        image = nil
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = image
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: {
                if let data = data, let image = UIImage(data: data) {
                    if self.imageURL == url {
                        self.image = image
                    }
                    imageCache.setObject(image, forKey: url as AnyObject)
                }
            })
        }).resume()
    }
}
