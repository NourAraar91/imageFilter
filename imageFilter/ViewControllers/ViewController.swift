//
//  ViewController.swift
//  imageFilter
//
//  Created by Nour Araar on 2/22/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import MetalPetal


class ViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView! {
        didSet {
            drawView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.      
    }
    
    @IBAction func numberOfFramesSliderValueChanged(_ sender: UISlider) {
        self.drawView.numberOfItems = CGFloat(sender.value.rounded())
    }
    
    @IBAction func paddingSliderValueChanged(_ sender: UISlider) {
        self.drawView.padding = CGFloat(sender.value)
    }
    
    func goToPhotoEditorViewController() {
        guard  let image = drawView.getImageFromSelectedLayer() else {
            return
        }
        let viewController = UIStoryboard(name: "PhotoEditor", bundle: nil).instantiateInitialViewController() as! PhotoEditorViewController
        viewController.image = image
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func saveImage() {
        if let imageToSave = drawView.layer.toUIImage() {
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    //MARK: - Add image to Library
      @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
          if let error = error {
              // we got back an error!
              showAlertWith(title: "Save error", message: error.localizedDescription)
          } else {
              showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
          }
      }
    
    func showAlertWith(title: String, message: String){
         let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "OK", style: .default))
         present(ac, animated: true)
     }
}


// MARK :- DrawViewDelegate
extension ViewController: DrawViewDelegate {
    
    override func setImage(image: UIImage) {
        self.drawView.setImageToSelectedLayer(image)
    }
    
    func showLoadImage() {
        let alertController = UIAlertController(title: "Please select an action", message: "", preferredStyle: .actionSheet)
        let loadImageAction = UIAlertAction(title: "Load Image", style: .default) {[weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.takePhoto()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(loadImageAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showApplyFilters() {
        
        let alertController = UIAlertController(title: "Please select an action", message: "", preferredStyle: .actionSheet)
        let loadImageAction = UIAlertAction(title: "Reload Image", style: .default) {[weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.takePhoto()
        }
        let applyfiltersAction = UIAlertAction(title: "Apply Filters", style: .default) {[weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.goToPhotoEditorViewController()
        }
        
        let saveAction = UIAlertAction(title: "Save Image", style: .default) {[weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.saveImage()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(loadImageAction)
        alertController.addAction(applyfiltersAction)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK :- PhotoEditorViewControllerDelegate
extension ViewController: PhotoEditorViewControllerDelegate {
    func setImage(_ image: UIImage) {
        self.drawView.setImageToSelectedLayer(image)
    }
}

