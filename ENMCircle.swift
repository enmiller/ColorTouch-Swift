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
    
    init(size: CGSize, redValue: Double, greenValue: Double, blueValue: Double) {
        super.init(frame: CGRectMake(0.0, 0.0, size.width, size.height))
        layer.contents = generateRadialWithRed(redValue, green: greenValue, blue: blueValue).CGImage
    }
    
    func generateRadialWithRed(red: Double, green: Double, blue: Double) -> UIImage {
        var gradient: CGGradientRef?
        var colorSpace: CGColorSpaceRef?
        var numberOfLocation: size_t = 6
        let locations: Double[] = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        let components: Double[] = [0.0,   0.0,    0.0,    1.0,
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
        
        layer.addAnimation(fadeIn, forKey: "fade")
    }
    
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
