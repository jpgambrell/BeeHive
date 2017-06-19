//
//  CircleProgressView.swift
//  BeeHive
//
//  Created by John Gambrell on 6/16/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressCircleView: UIView {
    
    @IBInspectable var circleColor: UIColor = UIColor.orange
    @IBInspectable var fillColor: UIColor = UIColor.clear
    @IBInspectable var lineWidth: CGFloat = 10.0
    @IBInspectable var startAngle: CGFloat = CGFloat(3 * Double.pi / 2.0)
    @IBInspectable var endAngle: CGFloat = 360.0
    @IBInspectable var strokeEnd: CGFloat = 1.0
    
    var circleLayer : CAShapeLayer!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (min(bounds.width, bounds.height) - 20)/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.strokeColor = circleColor.cgColor
        circleLayer.lineWidth = lineWidth;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer)
        
    }
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = strokeEnd
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        //circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
}


