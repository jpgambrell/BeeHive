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
}

class ProgressLineView: UIView {
    var lineLayer : CAShapeLayer!
    var circleLayer : CAShapeLayer!
    var type: ProgressLineViewType = .Other
    var typeImage : UIImageView!
    
    func setupLayers() {
        lineLayer = CAShapeLayer()
       // layer.addSublayer(lineLayer)
        
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer)
        
        typeImage = UIImageView.init(image: UIImage(named: "truck"))
        typeImage.contentMode = .scaleAspectFit
        
        layer.addSublayer(typeImage.layer)
        
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
        
        let xPos = frame.midX
        let yPosSet = type.calculateYPositionsForLine(bounds: bounds)
        
        linePath.move(to: CGPoint(x: xPos, y: yPosSet.first ?? 0 ))
        linePath.addLine(to: CGPoint(x: xPos, y: yPosSet.last ?? 0))
        linePath.stroke()
        lineLayer.path = linePath.cgPath
        
        let arcCenterPoint = CGPoint(x:xPos, y:ceil(bounds.height/2))
        
        
        let circlePath = UIBezierPath(arcCenter: arcCenterPoint, radius: 20-4, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(360).toRadians(), clockwise: true)
        
        circlePath.stroke()
        circleLayer.strokeColor = UIColor.black.cgColor
        //circleLayer.fillColor = type == .Footer ? UIColor.white.cgColor : UIColor.green.cgColor
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 2
        circleLayer.path = circlePath.cgPath
        
        typeImage.frame = CGRect(origin: CGPoint(x: arcCenterPoint.x - 8.0, y:arcCenterPoint.y - 5.0), size: CGSize(width: 16, height: 10))
    }
}
