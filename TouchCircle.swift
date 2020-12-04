//
//  TouchCircle.swift
//  ColorTouch_Swift
//
//  Created by Eric Miller on 6/3/14.
//  Copyright (c) 2014 Tiny Zepplin. All rights reserved.
//

import UIKit
import QuartzCore

class TouchCircle: UIView, CAAnimationDelegate {
    
    ///
    /// The smallest size the gradient circle will shrink to when supporting force touch.
    ///
    var smallestSizeDimension: CGFloat = 60.0
    
    ///
    /// The largest size the gradient circle will grow to when supporting force touch.
    ///
    var largestSizeDimension: CGFloat = 200.0
    
    ///
    /// Notifies the gradient circle that force touch is supported by the current UITraitCollection.
    ///
    var supportsForceTouch: Bool = false
    
    init?(size: CGSize!, redValue: CGFloat = 1.0, greenValue: CGFloat = 0.0, blueValue: CGFloat = 0.0) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        guard let image = generateRadialWithRed(red: redValue, green: greenValue, blue: blueValue) else {
            return nil
        }
        layer.contents = image.cgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension TouchCircle {
    ///
    /// Call this to update the size of the gradient circle based on the force being applied.
    /// The gradient circle will grow or shrink to the minimum and maximum boundaries set by the 
    /// ```smallestSizeDimension``` and ```largestSizeDimension```
    ///
    func updateSizeForForce(force: CGFloat) {
        if supportsForceTouch {
            var sizeDimension = smallestSizeDimension * force
            if sizeDimension > largestSizeDimension {
                sizeDimension = largestSizeDimension
            } else if sizeDimension < smallestSizeDimension {
                sizeDimension = smallestSizeDimension
            }
            self.frame.size = CGSize(width: sizeDimension, height: sizeDimension)
        }
    }
}

// MARK: - Animations
extension TouchCircle {
    
    ///
    /// Fades the gradient circle into view over the specified duration
    ///
    func fadeInWithDuration(duration: CFTimeInterval) {
        let fadeIn: CABasicAnimation = CABasicAnimation()
        fadeIn.keyPath = "opacity"
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = duration
        
        layer.add(fadeIn, forKey: "fade")
    }
    
    ///
    /// Fades the gradient circle out of view over the specified duration
    ///
    func fadeOutWithDuration(duration: CFTimeInterval) {
        let fadeOut: CABasicAnimation = CABasicAnimation()
        fadeOut.keyPath = "opacity"
        fadeOut.delegate = self
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = duration
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        fadeOut.isRemovedOnCompletion = false
        
        layer.add(fadeOut, forKey: "fade")
    }
}

// MARK: - Gradients (Private)
private extension TouchCircle {
    
    func generateRadialWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIImage? {
        var colorSpace: CGColorSpace
        let numberOfLocation: size_t = 6
        let locations: [CGFloat] = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        let components: [CGFloat] = [
            0.0,  0.0,    0.0,    1.0,
            red,   green,  blue,   1.0,
            red,   green,  blue,   0.8,
            red,   green,  blue,   0.6,
            red,   green,  blue,   0.2,
            red,   green,  blue,   0.0
        ]
        
        colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorSpace: colorSpace,
                                           colorComponents: components,
                                           locations: locations,
                                           count: numberOfLocation) else { return nil }
        
        let startPoint: CGPoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        let endPoint: CGPoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        
        UIGraphicsBeginImageContext(frame.size)
        guard let imageContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        imageContext.drawRadialGradient(gradient,
                                        startCenter: startPoint,
                                        startRadius: 0.0,
                                        endCenter: endPoint,
                                        endRadius: frame.size.width/2,
                                        options: CGGradientDrawingOptions(rawValue: 0))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}
