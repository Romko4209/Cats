//
//  GalleryCollectionViewCell.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let imageCache = NSCache<NSString, UIImage>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        activityIndicator.center = self.center
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor).isActive = true
        
        addSubview(activityIndicator)
    }
    
    func configure(with: ImageCat) {
        
        guard let urlString = with.url else { return }
            if let image = imageCache.object(forKey: urlString as NSString){
                self.imageView.image = image
                
                      return
                  }
            self.activityIndicator.startAnimating()
            self.imageView.image = nil
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
               self.activityIndicator.stopAnimating()
                let imageToCache = UIImage(data: imageData)
                self.imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                self.imageView.image = imageToCache
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
