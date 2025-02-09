//
//  UIView+Async.swift
//  Created by Shawn Throop on 19.02.25.
//

import UIKit
import SwiftUI

public extension UIView {
    
    @available(iOS 18.0, *)
    static func animate(_ animation: Animation, changes: () -> Void) async {
        await withUnsafeContinuation { continuation in
            animate(animation, changes: changes) {
                continuation.resume()
            }
        }
    }
    
    @available(iOS 17.0, *)
    @discardableResult static func animate(springDuration duration: TimeInterval = 0.5, bounce: CGFloat = 0.0, initialSpringVelocity: CGFloat = 0.0, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = [], animations: () -> Void) async -> Bool {
        await withUnsafeContinuation { continuation in
            animate(springDuration: duration, bounce: bounce, initialSpringVelocity: initialSpringVelocity, delay: delay, options: options, animations: animations) { success in
                continuation.resume(returning: success)
            }
        }
    }
    
    @discardableResult static func animate(withDuration duration: TimeInterval, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = [], animations: @escaping () -> Void) async -> Bool {
        await withUnsafeContinuation { continuation in
            animate(withDuration: duration, delay: 0.0, options: options, animations: animations) { success in
                continuation.resume(returning: success)
            }
        }
    }
}
