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
    
    @IBInspectable var progressColor: UIColor = UIColor.orange
    @IBInspectable var bgCircleColor: UIColor = UIColor.lightGray
    @IBInspectable var bgCircleAlpha: Double = 1
    @IBInspectable var strokeWidth: CGFloat = 10.0
    @IBInspectable var percentComplete: Int = 40
    @IBInspectable var labelColor: UIColor = UIColor.black
    @IBInspectable var labelFontSize: CGFloat = 40
    
    var labelFont : UIFont = UIFont()
    let fillColor: UIColor = UIColor.clear
    var circleLayer : CAShapeLayer!
    var backgroundCircleLayer : CAShapeLayer!
    var renderedFromIB : Bool = false
    
    
    func setupIntialView(progressStrokeColor: UIColor, backgroundStrokeColor: UIColor, backgroundCircleAlpa: Double, strokeWidth: CGFloat, percentageComplete: Int,
                           labelFont: UIFont, labelColor : UIColor) {
        self.progressColor = progressStrokeColor
        self.bgCircleColor = backgroundStrokeColor
        self.bgCircleAlpha = backgroundCircleAlpa
        self.strokeWidth = strokeWidth
        self.percentComplete = percentageComplete
        self.labelFont = labelFont
        self.labelColor = labelColor
        setNeedsDisplay()
    }
    
    
    private func setupCircles() {
        labelFont = UIFont.systemFont(ofSize: labelFontSize)
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
        let alpha = (bgCircleAlpha >= 0 && bgCircleAlpha <= 1) ? bgCircleAlpha : 1
        let bgStrokeColor = UIColor(red: bgCircleColor.components.red, green: bgCircleColor.components.green, blue: bgCircleColor.components.blue, alpha: CGFloat(alpha))
        
        backgroundCircleLayer.fillColor = fillColor.cgColor
        backgroundCircleLayer.strokeColor = bgStrokeColor.cgColor
        backgroundCircleLayer.lineWidth = strokeWidth;
        
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.strokeColor = progressColor.cgColor
        circleLayer.lineWidth = strokeWidth
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: (min(bounds.width, bounds.height) - (strokeWidth * 2))/2, startAngle: CGFloat(-90).toRadians(), endAngle: CGFloat(270).toRadians(), clockwise: true)
        
        backgroundCircleLayer.path = circlePath.cgPath
        backgroundCircleLayer.strokeEnd = 1
        
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeEnd = (renderedFromIB) ? CGFloat(percentComplete) / 100 : 0
        
        let textAttributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : labelColor.cgColor,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : labelFont.withSize(labelFontSize)
        ]
         guard let context = UIGraphicsGetCurrentContext() else { return }
        // Flip the coordinate system
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        drawText(context: context, text: "\(percentComplete)%" as NSString, attributes: textAttributes)
        
    }
    
    private func drawText(context: CGContext, text: NSString, attributes: [NSAttributedStringKey: AnyObject]) {
        let attributedString = NSAttributedString(string: text as String, attributes: attributes)
        
        let textSize = text.size(withAttributes: attributes)
        let yPos = (bounds.height/2) - (textSize.height/2)
        let xPos = (bounds.width/2) - (textSize.width/2)
        
        let textPath    = CGPath(rect: CGRect(x: xPos, y: yPos, width: ceil(textSize.width), height: ceil(textSize.height)).integral, transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
        let frame       = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: attributedString.length), textPath, nil)
        
        CTFrameDraw(frame, context)
    }
    
    override func prepareForInterfaceBuilder() {
        renderedFromIB = true
    }
    
    func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokePath")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = CGFloat(percentComplete) / 100
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        circleLayer.strokeEnd = CGFloat(percentComplete) / 100
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

