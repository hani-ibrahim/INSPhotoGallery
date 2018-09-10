//
//  CTGalleryPhoto.swift
//  ComoTravel
//
//  Created by WOO Yu Kit on 5/7/2016.
//  Copyright © 2016 Como. All rights reserved.
//

import UIKit
import INSPhotoGalleryFramework

class CTGalleryPhoto: NSObject, INSPhotoViewable {
    
    enum CTGalleryPhotoType{
        case Video, Photo
    }
    
    var image: UIImage?
    var thumbnailImage: UIImage?
    
    var imageURL: URL?
    var thumbnailImageURL: URL?
    
    var videoURL: URL?
    
    var itemType = CTGalleryPhotoType.Photo
    
    var attributedTitle: NSAttributedString? {
        return NSAttributedString(string: "Example caption text", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    init(image: UIImage?, thumbnailImage: UIImage?) {
        self.image = image
        self.thumbnailImage = thumbnailImage
    }
    
    init(imageURL: URL?, thumbnailImageURL: URL?) {
        self.imageURL = imageURL
        self.thumbnailImageURL = thumbnailImageURL
    }
    
    init(imageURL: URL?, thumbnailImage: UIImage) {
        self.imageURL = imageURL
        self.thumbnailImage = thumbnailImage
    }
    
    init(videoURL: URL?, thumbnailImage: UIImage) {
        self.videoURL = videoURL
        self.thumbnailImage = thumbnailImage
    }
    
    init(videoURL: URL?, thumbnailImageURL: URL?) {
        self.videoURL = videoURL
        self.thumbnailImageURL = thumbnailImageURL
    }
    
    func loadImageWithCompletionHandler(_ completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        if let image = image {
            completion(image, nil)
            return
        }
        loadImageWithURL(imageURL, completion: completion)
    }
    
    func loadThumbnailImageWithCompletionHandler(_ completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        if let thumbnailImage = thumbnailImage {
            completion(thumbnailImage, nil)
            return
        }
        loadImageWithURL(thumbnailImageURL, completion: completion)
    }
    
    func loadImageWithURL(_ url: URL?, completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        if let imageURL = url {
            session.dataTask(with: imageURL, completionHandler: { (response, data, error) in
                DispatchQueue.main.async(execute: { () -> Void in
                    if error != nil {
                        completion(nil, error)
                    } else if let response = response, let image = UIImage(data: response) {
                        completion(image, nil)
                    } else {
                        completion(nil, NSError(domain: "INSPhotoDomain", code: -1, userInfo: [ NSLocalizedDescriptionKey: "Couldn't load image"]))
                    }
                    session.finishTasksAndInvalidate()
                })
            }).resume()
        } else {
            completion(nil, NSError(domain: "INSPhotoDomain", code: -2, userInfo: [ NSLocalizedDescriptionKey: "Image URL not found."]))
        }
    }
}
