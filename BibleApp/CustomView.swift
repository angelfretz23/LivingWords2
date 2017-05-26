//
//  CustomView.swift
//  CurveViewProject
//
//  Created by Igor Makara on 4/24/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class CustomView: UIView {

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
        shapeLayer.position = CGPoint(x: 10, y: 10)
        
        // add the new layer to our custom view
        self.layer.addSublayer(shapeLayer)
    }
    
    func createBezierPath() -> UIBezierPath {

            // create a new path
        let path = UIBezierPath()
        
        // starting point for the path (bottom left)
        
        let yPositionOfView = self.bounds.origin.y
        
        path.move(to: CGPoint(x: -10, y: -10))
        
        path.addLine(to: CGPoint(x:yPositionOfView + self.frame.width, y:yPositionOfView - 10))
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 10))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.66, y: 10))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.55, y: 30))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.44, y: 30))
        
        path.addLine(to: CGPoint(x: self.frame.size.width * 0.33, y: 10))
        
        path.addLine(to: CGPoint(x: -10, y: 10))
        path.close() // draws the final line to close the path
        
        return path
    }
}
