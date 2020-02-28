//
//  Painter.swift
//  imageFilter
//
//  Created by Nour Araar on 2/22/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import MetalPetal

// this file is the drawer view
// all you have to do is to add the custom class for your view as "DrawView"
// and it will draw directly

protocol DrawViewDelegate {
    func showLoadImage()
    func showApplyFilters()
}

@IBDesignable
class DrawView: UIView {
    
    // number of items in row x col
    @IBInspectable var numberOfItems:CGFloat = 2 {
        didSet {
            drawLayout()
        }
    }
    // the padding between the frames
    @IBInspectable var padding: CGFloat = 16 {
        didSet {
            drawLayout()
        }
    }
    
    // this is the current layer user is interacting with
    fileprivate var selectedLayer: CALayer?
    
    var delegate: DrawViewDelegate?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLayout()
    }
    
    
    // MARK :- Algorithm
    // here is the algorithm logic
    // we still can use CAConstraintLayoutManager so we can layout things in a different way
    // but because we are using a sample grid frame it works this way
    func drawLayout() {
        DispatchQueue.main.async {
            self.layer.sublayers?.removeAll() // to make sure nothing in the draw view left behind
            // side length will be computed
            // from the canvas width
            // and the padding
            // and the number of items in each rows
            let sideLength = (self.frame.width - self.padding * (self.numberOfItems + 1)) / self.numberOfItems
            stride(from: 0, to: self.numberOfItems, by: 1).forEach { xShift in
                let x: CGFloat = ( sideLength + self.padding ) * xShift
                stride(from: 0, to: self.numberOfItems, by: 1).forEach { yShift in
                    let y: CGFloat = ( sideLength + self.padding ) * yShift
                    let drawingRect = CGRect(x: x + self.padding, y: y + self.padding, width: sideLength, height: sideLength)
                    // here where we can change the drawing shape to any custom shape
                    let shape = SquerShape(drawingRect: drawingRect)
                    self.layer.addSublayer(shape.layer)
                }
            }
        }
    }
    
    // when user select a frame we should detect if he already load an image or not
    func handleLayerSelection() {
        guard let layer = selectedLayer
            else { return }
        
        if layer.hasContent {
            delegate?.showApplyFilters()
        } else {
            delegate?.showLoadImage()
        }
    }
    
    func setImageToSelectedLayer(_ image: UIImage) {
        DispatchQueue.main.async {
            self.selectedLayer?.setImageContent(image)
        }
    }
    
    func getImageFromSelectedLayer() -> UIImage? {
        return selectedLayer?.getImageContent()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        selectedLayer?.borderColor = UIColor.black.cgColor
        for layer in self.layer.sublayers ?? [] {
            if (layer.hitTest(point) != nil) {
                selectedLayer = layer
                selectedLayer?.borderColor = UIColor.blue.cgColor
                handleLayerSelection()
            }
        }
    }
}









