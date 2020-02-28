//
//  Image+Filter.swift
//  imageFilter
//
//  Created by Nour Araar on 2/27/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import MetalPetal


// this file is to handel applying filters to image

extension UIImage {
    // here the aragument is a filter of type MTIUnaryFilter
    // so you can pass any filter from the MetalPetal
    // ex.. image.applyFilter(MTIVibranceFilter())
    // this is good only if you are applying one filter at a time
    // instead you need to handel in more efficient way
    func applyFilter(_ filter: MTIUnaryFilter) -> UIImage? {
        filter.inputImage = self.toMTIIMage()
        let filteredImage = filter.outputImage
        return filteredImage?.toUIImage()
    }
}
