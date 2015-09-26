//
//  ENMCircle.swift
//  ColorTouch_Swift
//
//  Created by Eric Miller on 6/3/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit
import QuartzCore

class ENMCircle: UIView {
    
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
        super.init(frame: CGRectMake(0.0, 0.0, size.width, size.height))
        
        guard let image = generateRadialWithRed(redValue, green: greenValue, blue: blueValue) else {
            return nil
        }
        layer.contents = image.CGImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension ENMCircle {
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
            self.frame.size = CGSizeMake(sizeDimension, sizeDimension)
        }
    }
}

// MARK: - Animations
extension ENMCircle {
    
    ///
    /// Fades the gradient circle into view over the specified duration
    ///
    func fadeInWithDuration(duration: CFTimeInterval) {
        let fadeIn: CABasicAnimation = CABasicAnimation()
        fadeIn.keyPath = "opacity"
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = duration
        
        layer.addAnimation(fadeIn, forKey: "fade")
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
        fadeOut.fillMode = kCAFillModeForwards
        fadeOut.removedOnCompletion = false
        
        layer.addAnimation(fadeOut, forKey: "fade")
    }
}

// MARK: - Gradients (Private)
private extension ENMCircle {
    
    func generateRadialWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIImage? {
        var gradient: CGGradientRef?
        var colorSpace: CGColorSpaceRef?
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
        gradient = CGGradientCreateWithColorComponents(colorSpace,
            components,
            locations,
            numberOfLocation)
        
        let startPoint: CGPoint = CGPointMake(frame.size.width/2, frame.size.height/2)
        let endPoint: CGPoint = CGPointMake(frame.size.width/2, frame.size.height/2)
        
        UIGraphicsBeginImageContext(frame.size)
        guard let imageContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        CGContextDrawRadialGradient(imageContext,
            gradient,
            startPoint,
            0.0,
            endPoint,
            frame.size.width/2,
            CGGradientDrawingOptions(rawValue: 0))
        let resultImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}
