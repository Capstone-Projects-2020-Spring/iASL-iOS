//
//  Extensions.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/20/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    
    /// Rotate a UIView according to the given angle
    /// - Parameter angle: the amount of angle to rotate
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}

extension UIViewController {
    
    /// Activates touch recognizer on current UIViewController. It hides keyboard when tapped outside the keyboard area
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    ///Dismiss the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UIView {
    
    /// Shakes the given UIView with rubber motion
    /// - Parameter viewToShake: UIView to shake
    func shake(viewToShake: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x - 10, y: viewToShake.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x + 10, y: viewToShake.center.y))

        viewToShake.layer.add(animation, forKey: "position")
    }

}
