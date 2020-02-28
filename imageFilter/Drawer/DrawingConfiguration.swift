//
//  DrawingConfiguration.swift
//  imageFilter
//
//  Created by Nour Araar on 2/22/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit

// this is a configuration class
// this will alow us to creat many drawing configuration and just pass them to the drawer


// you can conform to this protocol to have a custom configuration for each drawer
protocol DrawingConfiguration {
    var fillColor: CGColor { get set }
    var borderColor: CGColor { get set }
    var lineWidth: CGFloat { get set }
}

class DefaultDrawingConfiguration: DrawingConfiguration {
    var fillColor: CGColor = UIColor.white.cgColor
    var borderColor: CGColor = UIColor.black.cgColor
    var lineWidth: CGFloat  = 10.0
}
