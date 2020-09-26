//
//  Extension + UIButton.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func pulsateStartAnimation() {
           let pulse : CASpringAnimation = CASpringAnimation(keyPath: "transform.scale")
           pulse.fromValue = 0.95
           pulse.duration = 0.6
           pulse.toValue = 1.0
           pulse.repeatCount = Float.greatestFiniteMagnitude
           pulse.autoreverses = true
           pulse.damping = 1.0
           pulse.initialVelocity = 0.5
           self.layer.add(pulse, forKey: "PulseAnimation")
       }
    
    func imageURL(imageURL: String?,label: UILabel?){
        guard let imageURL = imageURL else {return}
        guard let url = URL(string: imageURL) else {return}
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url)else {return}
                     let loadImage = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.layer.removeAllAnimations()
                            self.setImage(loadImage, for: .normal)
                            if let label = label {
                                label.pulsateStartAnimation()
                            }
            }
        }
    }
 
}
