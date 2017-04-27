//
//  CustomCurveView.swift
//  BibleApp
//
//  Created by ігор on 4/27/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class CustomCurveView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
        setup()
    }
    
    func setup() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        
        // The Bezier path that we made needs to be converted to
        // a CGPath before it can be used on a layer.
        shapeLayer.path = createBezierPath().cgPath
        
        // apply other properties related to the path
        //shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.init(red: 195/255, green: 194/255, blue: 201/255, alpha: 1).cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint(x: 0, y: 0)
        
        // add the new layer to our custom view
        self.layer.addSublayer(shapeLayer)
    }
    
    func createBezierPath() -> UIBezierPath {
        
        // create a new path
        let path = UIBezierPath()
        
        // starting point for the path (bottom left)
        
        let xPositionOfView = self.bounds.origin.x
        let yPositionOfView = self.bounds.origin.y
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x:yPositionOfView + self.frame.width, y:yPositionOfView))
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 20))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.76, y: 20))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.71, y: 40))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.28, y: 40))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.23, y: 20))
        
        path.addLine(to: CGPoint(x: 0, y: 20))
        path.close() // draws the final line to close the path
        
        return path
    }
}
