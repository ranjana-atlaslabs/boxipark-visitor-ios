//
//  TopView.swift
//  TestScrollView
//
//  Created by Atlas on 4/29/19.
//  Copyright © 2019 Atlas. All rights reserved.
//

import UIKit

class TopView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
   var path             =  UIBezierPath()
   var leftBottomPoint  = CGPoint()
   var rightBottomPoint = CGPoint()
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        // Get Height and Width
        let layerHeight = layer.frame.height
        let layerWidth = layer.frame.width
        
        // Create Path
        let bezierPath = UIBezierPath()
        
        //  Points
        let pointA = CGPoint(x: 0, y: 0)
        let pointB = CGPoint(x: layerWidth, y: 0)
        let pointC = CGPoint(x: layerWidth, y: layerHeight*2/3)
        let pointD = CGPoint(x: 0, y: layerHeight)
        
        // Draw the path
        bezierPath.move(to: pointA)
        bezierPath.addLine(to: pointB)
        bezierPath.addLine(to: pointC)
        bezierPath.addLine(to: pointD)
        bezierPath.close()
        
        UIColor.clear.setFill()
        bezierPath.fill()
        
        self.leftBottomPoint  = pointD
        self.rightBottomPoint = pointC
        self.path = bezierPath
        
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
        layer.bounds = path.cgPath.boundingBoxOfPath // IMPORTANT, without this hitTest wont work
    }
    
   
    
}

class MiddleView: UIView {
    
    var path             =  UIBezierPath()
    
    var leftTopPoint  = CGPoint()
    var rightTopPoint = CGPoint()
    var leftBottomPoint  = CGPoint()
    var rightBottomPoint = CGPoint()
    
    var color = UIColor()
    
    override func draw(_ rect: CGRect) {
        // Drawing code
      
        
        // Create Path
        let bezierPath = UIBezierPath()
        
        //  Points
        let pointA = leftTopPoint
        let pointB = rightTopPoint
        let pointC = rightBottomPoint
        let pointD = leftBottomPoint
        
        // Draw the path
        bezierPath.move(to: pointA)
        bezierPath.addLine(to: pointB)
        bezierPath.addLine(to: pointC)
        bezierPath.addLine(to: pointD)
        bezierPath.close()
        
        color.setFill()
        bezierPath.fill()
        
        self.path = bezierPath
        
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
        //layer.masksToBounds = true
        clipsToBounds = true
    }
}

class BottomView: UIView {
    
    var path             =  UIBezierPath()
    
    var leftTopPoint  = CGPoint()
    var rightTopPoint = CGPoint()
    var leftBottomPoint  = CGPoint()
    var rightBottomPoint = CGPoint()
    
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        // Create Path
        let bezierPath = UIBezierPath()
        
        //  Points
        let pointA = leftTopPoint
        let pointB = rightTopPoint
        let pointC = rightBottomPoint
        let pointD = leftBottomPoint
        
        // Draw the path
        bezierPath.move(to: pointA)
        bezierPath.addLine(to: pointB)
        bezierPath.addLine(to: pointC)
        bezierPath.addLine(to: pointD)
        bezierPath.close()
        
        UIColor.white.setFill()
        bezierPath.fill()
        
        self.path = bezierPath
        
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
        //layer.masksToBounds = true
        clipsToBounds = true
    }
}
