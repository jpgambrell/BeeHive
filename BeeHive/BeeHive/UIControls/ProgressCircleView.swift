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
    @IBInspectable var backgroundCircleTransparancy: Double = 1
    @IBInspectable var lineWidth: CGFloat = 10.0
    @IBInspectable var percentageComplete: Int = 40
    @IBInspectable var labelColor: UIColor = UIColor.black
    @IBInspectable var labelFontSize: CGFloat = 40
    
    let fillColor: UIColor = UIColor.clear
    let startAngle =  CGFloat(270).toRadians()
    let endAngle = CGFloat(269.9).toRadians()
    var circleLayer : CAShapeLayer!
    var backgroundCircleLayer : CAShapeLayer!
    var renderedFromIB : Bool = false
    
    
    func setupCircles() {
        backgroundCircleLayer = CAShapeLayer()
        layer.addSublayer(backgroundCircleLayer)
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer)
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCircles()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCircles()
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        let alpha = (backgroundCircleTransparancy >= 0 && backgroundCircleTransparancy <= 1) ? backgroundCircleTransparancy : 1
        let strokeColor = UIColor(red: backgroundCircleStrokeColor.components.red, green: backgroundCircleStrokeColor.components.green, blue: backgroundCircleStrokeColor.components.blue, alpha: CGFloat(alpha))
        
        backgroundCircleLayer.fillColor = fillColor.cgColor
        backgroundCircleLayer.strokeColor = strokeColor.cgColor
        backgroundCircleLayer.lineWidth = lineWidth;
        
        
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.strokeColor = circleStrokeColor.cgColor
        circleLayer.lineWidth = lineWidth
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: (min(bounds.width, bounds.height) - (lineWidth * 2))/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundCircleLayer.path = circlePath.cgPath
        backgroundCircleLayer.strokeEnd = 1
        
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeEnd = (renderedFromIB) ? CGFloat(percentageComplete) / 100 : 0
        
        let textAttributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : labelColor.cgColor,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.systemFont(ofSize: labelFontSize)
        ]
         guard let context = UIGraphicsGetCurrentContext() else { return }
        // Flip the coordinate system
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        _ = drawText(context: context, text: "\(percentageComplete)%" as NSString, attributes: textAttributes)
        
    }
    
    func drawText(context: CGContext, text: NSString, attributes: [NSAttributedStringKey: AnyObject]) -> CGSize {
        let attributedString = NSAttributedString(string: text as String, attributes: attributes)
        
        let textSize = text.size(withAttributes: attributes)
        
        // y: Add font.descender (its a negative value) to align the text at the baseline
        let yPos = (bounds.height/2) - (textSize.height/2)
        let xPos = (bounds.width/2) - (textSize.width/2)
        
        let textPath    = CGPath(rect: CGRect(x: xPos, y: yPos, width: ceil(textSize.width), height: ceil(textSize.height)).integral, transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
        let frame       = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: attributedString.length), textPath, nil)
        
        CTFrameDraw(frame, context)
        
        return textSize
    }
    
    override func prepareForInterfaceBuilder() {
        renderedFromIB = true
    }
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokePath")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = CGFloat(percentageComplete) / 100
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
       // circleLayer.strokeColor = circleStrokeColor.cgColor
        
        circleLayer.strokeEnd = CGFloat(percentageComplete) / 100
        
        circleLayer.add(animation, forKey: "animateCircle")
        
        
    }
    
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = CIColor(color: self)
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}

