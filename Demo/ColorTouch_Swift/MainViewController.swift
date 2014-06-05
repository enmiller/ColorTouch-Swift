//
//  MainViewController.swift
//  ColorTouch_Swift
//
//  Created by Eric Miller on 6/3/14.
//  Copyright (c) 2014 Yogurt Salad. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let gradientCircle: ENMCircle = ENMCircle(size: CGSizeMake(60.0, 60.0),
                                          redValue: 0.0,
                                        greenValue: 1.0,
                                         blueValue: 1.0)
    
    override func loadView() {
        let myView = UIView(frame: UIScreen.mainScreen().bounds)
        myView.backgroundColor = UIColor.darkGrayColor()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientCircle.fadeOutWithDuration(0.0)
    }
}

//MARK: - Touches
extension MainViewController {
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)  {
        if (gradientCircle.superview == nil) {
            view.addSubview(gradientCircle)
        }
        
        let touch: UITouch = touches.anyObject() as UITouch
        let touchPoint: CGPoint = touch.locationInView(view)
        
        gradientCircle.center = touchPoint
        
        gradientCircle.fadeInWithDuration(0.2)
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!)  {
        let touch: UITouch = touches.anyObject() as UITouch
        let touchPoint: CGPoint = touch.locationInView(view)
        gradientCircle.center = touchPoint
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)  {
        gradientCircle.fadeOutWithDuration(0.2)
    }
}
