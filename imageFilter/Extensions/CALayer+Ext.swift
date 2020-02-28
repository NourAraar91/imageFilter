//
//  CALayer+Ext.swift
//  imageFilter
//
//  Created by Nour Araar on 2/27/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import MetalPetal

// this file has extension for CALayer to be able to set and get the image from layer content

extension CALayer {
    
    var hasContent: Bool {
        return self.contents != nil
    }
    
    func setImageContent(_ image: UIImage) {
        self.contents = image.cgImage
    }
    
    func setMTIImageContent(_ image: MTIImage) {
        self.contents = image.toCGImage()
    }
    
    func getImageContent() -> UIImage? {
        guard let content = self.contents
            else { return nil }
        
        return UIImage(cgImage: content as! CGImage)
    }
}
