//
//  Shape.swift
//  imageFilter
//
//  Created by Nour Araar on 2/26/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit


// this is shapes that we can draw on our draw view
protocol Shape {
    // this is the configuration of the shape
    var drawingConfiguration: DrawingConfiguration { get set }
    // the result layer that we can use in our algorithm
    var layer: CAShapeLayer { get set }
    // the frame of the result layer
    var drawingRect: CGRect { get set }
    // the drawing function you can implement it for custom shapes
    func drawIn(_ rect: CGRect)
}


class SquerShape: Shape {
    
    var drawingConfiguration: DrawingConfiguration
    var drawingRect: CGRect
    var layer: CAShapeLayer
    
    init( drawingConfiguration: DrawingConfiguration = DefaultDrawingConfiguration()
        , drawingRect: CGRect) {
        self.drawingConfiguration = drawingConfiguration
        self.drawingRect = drawingRect
        layer = CAShapeLayer()
        drawIn(drawingRect)
    }
    
    func drawIn(_ rect: CGRect){
        let drawingLayer = CAShapeLayer()
        drawingLayer.frame = rect
        drawingLayer.borderWidth = drawingConfiguration.lineWidth
        drawingLayer.backgroundColor = drawingConfiguration.fillColor
        drawingLayer.borderColor = drawingConfiguration.borderColor
        drawingLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
        drawingLayer.masksToBounds = true
        self.layer = drawingLayer
    }
}
