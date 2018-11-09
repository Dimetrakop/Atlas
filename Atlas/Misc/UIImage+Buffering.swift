//
//  UIImage+Buffering.swift
//  Atlas
//
//  Created by Dmitry Koppel on 11/8/18.
//  Copyright © 2018 PrivateSoft. All rights reserved.
//

import SVGKit
import UIKit

extension UIImageView {
    
    func loadImageData(urlString: String, imageCache: ImageSvgCache?, completion: @escaping (NSData) -> ()) {
        if  let imageCache = imageCache,
            let cachedData = imageCache.object(forKey: NSString(string: urlString)) as NSData?
        {
            completion(cachedData)
        } else {
            guard let svgURL = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: svgURL, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }
                if let data = data as Data? {
                    imageCache?.setObject(data as NSData, forKey: NSString(string: urlString))
                    completion(data as NSData)
                }
            }).resume()
        }
    }
    
    
    func loadSVGImageFrom(urlString: String, imageCache: ImageSvgCache?) {
        
        loadImageData(urlString: urlString, imageCache: imageCache) { [weak self] (data) in
            SVGKImage.imageParser(withDataAsynchronously: data as Data , onCompletion: {  [weak self] (image, result) in
                if  let image = image {
                    DispatchQueue.main.async { [weak self] in
                        guard let that = self else { return }
                        let imageKf = that.frame.width / image.size.width
                        image.scaleToFit(inside: CGSize(width: image.size.width * imageKf, height: image.size.height * imageKf))
                        //TODO: wrong size break app fix nedeed
                        if let layer = image.caLayerTree {
                            that.layer.addSublayer(layer)
                        }
                    }
                }
            })
        }

    }
}
