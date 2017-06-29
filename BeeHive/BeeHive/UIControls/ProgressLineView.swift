//
//  TableCellHeaderProgressView.swift
//  BeeHive
//
//  Created by John Gambrell on 6/27/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit
enum ProgressLineViewType {
    case Header
    case Footer
    case Other
    
    func calculateYPositionsForLine(bounds: CGRect) -> [CGFloat]{
        switch self {
        case .Header:
            return [bounds.height/2, bounds.height]
        case .Footer:
            return [0, bounds.height/2]
        case .Other:
            return [0, bounds.height]
        }
    }
//    func calculateYPositionForCircle(bounds: CGRect) -> CGFloat {
//        switch self {
//        case .Header, .Footer:
//            return bounds.height/2
//        case .Other:
//            return 0
//        }
//    }
}

class ProgressLineView: UIView {
    var lineLayer : CAShapeLayer!
    var circleLayer : CAShapeLayer!
    var type: ProgressLineViewType = .Other
    
    func setupLayers() {
        lineLayer = CAShapeLayer()
       // layer.addSublayer(lineLayer)
        
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer)
    }
    
    func setupInitialView(cellType: ProgressLineViewType){
        type = cellType
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupLayers()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
        
    }
    override func draw(_ rect: CGRect) {
        let linePath = UIBezierPath()
        lineLayer.lineWidth = 10
       // lineLayer.strokeColor = UIColor.blue.cgColor
        
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.frame = self.view.frame;
//        gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor ];
//        gradientLayer.startPoint = CGPointMake(0,0.5);
//        gradientLayer.endPoint = CGPointMake(1,0.5);
//
//        [self.view.layer addSublayer:gradientLayer];
        
        
        
        
        
        let xPos = frame.midX
        let yPosSet = type.calculateYPositionsForLine(bounds: bounds)
        
        linePath.move(to: CGPoint(x: xPos, y: yPosSet.first ?? 0 ))
        linePath.addLine(to: CGPoint(x: xPos, y: yPosSet.last ?? 0))
        linePath.stroke()
        lineLayer.path = linePath.cgPath
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.mask = lineLayer
        
        layer.addSublayer(gradientLayer)
        
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x:xPos, y:ceil(bounds.height/2)), radius: 8, startAngle: 0, endAngle: 360, clockwise: true)
//        circlePath.stroke()
//        circleLayer.strokeColor = UIColor.blue.cgColor
//        circleLayer.fillColor = type == .Footer ? UIColor.white.cgColor : UIColor.green.cgColor
//        circleLayer.lineWidth = 1
//        circleLayer.path = circlePath.cgPath
    }
}
