//
//  MainViewController.swift
//  ColorTouch_Swift
//
//  Created by Eric Miller on 6/3/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var gradientCircle: ENMCircle?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        gradientCircle = ENMCircle(
            size: CGSizeMake(60.0, 60.0),
            redValue: 0.0,
            greenValue: 1.0,
            blueValue: 1.0
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGrayColor()
        gradientCircle?.fadeOutWithDuration(0.0)
    }
}

//MARK: - Touches
extension MainViewController {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let unwrappedGradient = gradientCircle {
            if (unwrappedGradient.superview == nil) {
                view.addSubview(unwrappedGradient)
            }
        }
        
        if let touch = touches.first {
            let touchPoint: CGPoint = touch.locationInView(view)
            gradientCircle?.center = touchPoint
            
            gradientCircle?.fadeInWithDuration(0.2)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint: CGPoint = touch.locationInView(view)
            gradientCircle?.center = touchPoint
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        gradientCircle?.fadeOutWithDuration(0.2)
    }
}
