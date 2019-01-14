//
//  PhotosViewController.swift
//  InstaGriD-OC-P4
//
//  Created by Luc Derosne on 14/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

extension ViewController {
    
    // interagir avec les photos du calque
    func interactWihPhotosLayer(_ ImageView :UIImageView) {
        print("interact")
        ImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(searchPhoto))
        ImageView.addGestureRecognizer(tap)
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
    }
    
   
    // recherche photo avec le tap... selector  dans le viewDidload
    @objc func searchPhoto() {
        guard imagePicker != nil else { return }
        let alert = UIAlertController(title: "Choisir une photo", message: "dans la photothéque", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "photothéque", style: .default) { (act) in self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        let exit = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(exit)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // après le choix de l'image - remplacement dans l'UIImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("après choix")
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        var photo: UIImage?
        if let edited = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            photo = edited
            
        } else if let original = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            photo = original
        }
        // layer2ImageView1.image = photo
        alternateImage = photo
        
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
}

// Helper

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

