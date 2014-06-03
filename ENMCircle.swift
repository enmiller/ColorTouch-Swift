//
//  ENMCircle.swift
//  ColorTouch_Swift
//
//  Created by Eric Miller on 6/3/14.
//  Copyright (c) 2014 Yogurt Salad. All rights reserved.
//

import UIKit
import QuartzCore

class ENMCircle: UIView {

    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        super.init(frame: initialFrame())
        layer.contents = generateRadialWithRed(red, green: green, blue: blue).CGImage
    }
    
    @final func generateRadialWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIImage {
        var gradient: CGGradientRef?
        var colorSpace: CGColorSpaceRef?
        var numberOfLocation: size_t = 6
        let locations: CGFloat[] = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        let components: CGFloat[] = [0.0,   0.0,    0.0,    1.0,
                                     red,   green,  blue,   1.0,
                                     red,   green,  blue,   0.8,
                                     red,   green,  blue,   0.6,
                                     red,   green,  blue,   0.2,
                                     red,   green,  blue,   0.0]
        
        colorSpace = CGColorSpaceCreateDeviceRGB()
        gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                       components,
                                                       locations,
                                                       numberOfLocation)
        
        var startPoint: CGPoint = CGPointMake(frame.size.width/2, frame.size.height/2)
        var endPoint: CGPoint = CGPointMake(frame.size.width/2, frame.size.height/2)
        
        UIGraphicsBeginImageContext(frame.size)
        let imageContext: CGContextRef = UIGraphicsGetCurrentContext()
        CGContextDrawRadialGradient(imageContext,
                                    gradient,
                                    startPoint,
                                    0.0,
                                    endPoint,
                                    frame.size.width/2,
                                    0)
        let resultImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    
// MARK: - Animation
    
    func fadeInWithDuration(duration: CFTimeInterval) {
        let fadeIn: CABasicAnimation = CABasicAnimation()
        fadeIn.keyPath = "opacity"
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = duration
        
        layer.addAnimation(fadeIn, forKey: "face")
    }
    
    func fadeOutWithDuration(duration: CFTimeInterval) {
        let fadeOut: CABasicAnimation = CABasicAnimation()
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = duration
        fadeOut.fillMode = kCAFillModeForwards
        fadeOut.removedOnCompletion = false
        
        layer.addAnimation(fadeOut, forKey: "fade")
    }
    

// MARK: - Helpers
    
    @final func initialFrame() -> CGRect {
        return CGRectMake(0.0, 0.0, 60.0, 60.0)
    }

}
