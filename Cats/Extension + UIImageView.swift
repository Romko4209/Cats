//
//  Extension + UIImageView.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func imageURL(imageURL: String){
        guard let url = URL(string: imageURL) else {return}
            guard let data = try? Data(contentsOf: url)else {return}
                     let loadImage = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.image = loadImage
            }
        
    }
}
