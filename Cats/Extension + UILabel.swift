//
//  Extension + UILabel.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
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
    
}
