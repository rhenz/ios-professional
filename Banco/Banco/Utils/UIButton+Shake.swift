//
//  UIButton+Shake.swift
//  Banco
//
//  Created by John Salvador on 5/23/22.
//

import Foundation
import UIKit

extension UIButton {
    public func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        self.layer.add(animation, forKey: "shake")
    }
}
