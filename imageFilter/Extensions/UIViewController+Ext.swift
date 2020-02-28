//
//  UIViewController+Ext.swift
//  imageFilter
//
//  Created by Nour Araar on 2/27/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit

// an extension to add the appility for all uiviewcontrollers to use gallery to get images
extension UIViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    // take photo
    
    func takePhoto() {
        let alertController  = UIAlertController(title: "Choose source", message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: openGallery))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alertController.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openGallery(action: UIAlertAction){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
        DispatchQueue.main.async {
            self.setImage(image: image)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // this methode will be overriden in the class you need to us it with
    @objc func setImage(image:UIImage){
    }
}
