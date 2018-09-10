//
//  CTGalleryPhoto.swift
//  ComoTravel
//
//  Created by WOO Yu Kit on 5/7/2016.
//  Copyright © 2016 Como. All rights reserved.
//

import UIKit
import Haneke
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
        return NSAttributedString(string: "Example caption text", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
    }
    
    init(image: UIImage?, thumbnailImage: UIImage?) {
        self.image = image
        self.thumbnailImage = thumbnailImage
    }
    
    init(imageURL: URL?, thumbnailImageURL: URL?) {
        self.imageURL = imageURL
        self.thumbnailImageURL = thumbnailImageURL
    }
    
    init (imageURL: URL?, thumbnailImage: UIImage) {
        self.imageURL = imageURL
        self.thumbnailImage = thumbnailImage
    }
    
    init (videoURL: URL?, thumbnailImage: UIImage) {
        self.videoURL = videoURL
        self.thumbnailImage = thumbnailImage
    }
    
    init(videoURL: URL?, thumbnailImageURL: URL?) {
        self.videoURL = videoURL
        self.thumbnailImageURL = thumbnailImageURL
    }
    
    func loadImageWithCompletionHandler(completion: (image: UIImage?, error: NSError?) -> ()) {
        if let url = imageURL {
            Shared.imageCache.fetch(URL: url).onSuccess({ image in
                completion(image: image, error: nil)
            }).onFailure({ error in
                completion(image: nil, error: error)
            })
        } else {
            completion(image: nil, error: NSError(domain: "PhotoDomain", code: -1, userInfo: [ NSLocalizedDescriptionKey: "Couldn't load image"]))
        }
    }
    func loadThumbnailImageWithCompletionHandler(completion: (image: UIImage?, error: NSError?) -> ()) {
        if let thumbnailImage = thumbnailImage {
            completion(image: thumbnailImage, error: nil)
            return
        }
        if let url = thumbnailImageURL {
            Shared.imageCache.fetch(URL: url).onSuccess({ image in
                completion(image: image, error: nil)
            }).onFailure({ error in
                completion(image: nil, error: error)
            })
        } else {
            completion(image: nil, error: NSError(domain: "PhotoDomain", code: -1, userInfo: [ NSLocalizedDescriptionKey: "Couldn't load image"]))
        }
    }
}
