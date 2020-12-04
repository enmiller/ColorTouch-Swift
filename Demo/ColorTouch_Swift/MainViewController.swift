//
//  MainViewController.swift
//  ColorTouch_Swift
//
//  Created by Eric Miller on 6/3/14.
//  Copyright (c) 2014 Tiny Zepplin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var gradientCircle: TouchCircle?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        gradientCircle = TouchCircle(
            size: CGSize(width: 60.0, height: 60.0),
            redValue: 0.0,
            greenValue: 1.0,
            blueValue: 1.0
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientCircle?.fadeOutWithDuration(duration: 0.0)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            gradientCircle?.supportsForceTouch = true
        }
    }
}

//MARK: - Touches
extension MainViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let unwrappedGradient = gradientCircle {
            if (unwrappedGradient.superview == nil) {
                view.addSubview(unwrappedGradient)
            }
        }
        
        if let touch = touches.first {
            let touchPoint: CGPoint = touch.location(in: view)
            gradientCircle?.center = touchPoint
            
            gradientCircle?.fadeInWithDuration(duration: 0.2)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint: CGPoint = touch.location(in: view)
            gradientCircle?.center = touchPoint
            
            gradientCircle?.updateSizeForForce(force: touch.force)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gradientCircle?.fadeOutWithDuration(duration: 0.2)
    }
}
