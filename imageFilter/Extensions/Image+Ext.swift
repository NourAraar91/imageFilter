//
//  Image+Ext.swift
//  imageFilter
//
//  Created by Nour Araar on 2/27/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import MetalPetal

// this file is to convert between all images types 

extension UIImage {
    func toMTIIMage() -> MTIImage {
        return MTIImage(cgImage: self.cgImage!, options: nil).unpremultiplyingAlpha()
    }
}



extension CGImage {
    func toUIImage() -> UIImage? {
        return UIImage(cgImage: self)
    }
}


extension MTIImage {
    func toCGImage() -> CGImage? {
        if let device = MTLCreateSystemDefaultDevice() {
            do {
                let context = try MTIContext(device: device)
                let filteredImage = try context.makeCGImage(from: self)
                return filteredImage
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func toUIImage() -> UIImage? {
        return toCGImage()?.toUIImage()
    }
}
