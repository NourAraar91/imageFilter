//
//  PhotoEditorViewController.swift
//  imageFilter
//
//  Created by Nour Araar on 2/28/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import MetalPetal

protocol PhotoEditorViewControllerDelegate {
    func setImage(_ image: UIImage)
}

class PhotoEditorViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    var originalImage: UIImage?
    var filteredImage: UIImage? {
        didSet {
            imageView.image = filteredImage
        }
    }
    
    var delegate: PhotoEditorViewControllerDelegate?
    
    var vibranceFilter = MTIVibranceFilter()
    var claheFilter    = MTICLAHEFilter()
    // this is the change of the amount on the vibrance filter
    var vibranceFilterAmount: Float = 0.0 {
        didSet {
            vibranceFilter.amount = vibranceFilterAmount
            applyFilters()
        }
    }
    // this is the change of the clip limit on the clahe filter
    var claheFilterClipLimit: Float = 0.0 {
        didSet {
            claheFilter.clipLimit = claheFilterClipLimit
            applyFilters()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        originalImage = image
    }
    
    @IBAction func vibranceFilterAmountChanged(_ sender: UISlider) {
        vibranceFilterAmount = sender.value
    }
    
    @IBAction func claheFilterAmountChanged(_ sender: UISlider) {
        claheFilterClipLimit = sender.value
    }
    
    
    func applyFilters() {
        guard let unwrappedImage = originalImage
        else { return }
        DispatchQueue.main.async {
            var resultImage: UIImage?
            if let vibranceImage = unwrappedImage.applyFilter(self.vibranceFilter) {
                resultImage = vibranceImage
            }
            // clahe filter will not work on the simulartor ,
            // accourding to the MetalPetal git hub decumentation
            // https://github.com/MetalPetal/MetalPetal#ios-simulator-support
            
            if let claheImage = unwrappedImage.applyFilter(self.claheFilter) {
                resultImage = claheImage
            }
            self.filteredImage = resultImage
        }
    
    }
    
    @IBAction func doneEditing(_ sender: UIButton) {
        if let image = imageView.image {
            delegate?.setImage(image)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
