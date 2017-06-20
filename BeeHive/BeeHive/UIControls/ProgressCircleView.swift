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
    
    @IBInspectable var circleStrokeColor: UIColor = UIColor.orange
    @IBInspectable var backgroundCircleStrokeColor: UIColor = UIColor.lightGray
    @IBInspectable var fillColor: UIColor = UIColor.clear
    @IBInspectable var lineWidth: CGFloat = 10.0
    @IBInspectable var percentageComplete: CGFloat = 40
    
    let startAngle =  CGFloat(270).toRadians() //CGFloat(3 * Double.pi / 2.0)
    let endAngle = CGFloat(269.9).toRadians()
    var circleLayer : CAShapeLayer!
    var backgroundCircleLayer : CAShapeLayer!
    
    func initCircles() {
        backgroundCircleLayer = CAShapeLayer()
        layer.addSublayer(backgroundCircleLayer)
        
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer)
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
      initCircles()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCircles()
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        backgroundCircleLayer.fillColor = fillColor.cgColor
        backgroundCircleLayer.strokeColor = backgroundCircleStrokeColor.cgColor
        backgroundCircleLayer.lineWidth = lineWidth;
        
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.strokeColor = circleStrokeColor.cgColor
        circleLayer.lineWidth = lineWidth
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: (min(bounds.width, bounds.height) - (lineWidth * 2))/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundCircleLayer.path = circlePath.cgPath
        backgroundCircleLayer.strokeEnd = 1
        
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeEnd = percentageComplete / 100.0
        
    }
    
    
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = percentageComplete / 100.0
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
       // circleLayer.strokeColor = circleStrokeColor.cgColor
        
        circleLayer.strokeEnd = percentageComplete / 100.0
        
        circleLayer.add(animation, forKey: "animateCircle")
        
        
    }
    
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}


