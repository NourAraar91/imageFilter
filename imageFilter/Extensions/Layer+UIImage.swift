//
//  Layer+UIImage.swift
//  imageFilter
//
//  Created by Nour Araar on 2/28/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit

extension CALayer {
    // get the layer content as an uiimage
    func toUIImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
