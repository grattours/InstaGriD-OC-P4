//
//  PhotosViewController.swift
//  InstaGriD-OC-P4
//
//  Created by Luc Derosne on 14/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

extension ViewController {
    
    // interagir avec les photos du calque lancé
    func interactWithAllPhotosOfLayer(_ tabLayersView :[UIImageView] ) {
        let nb = tabLayersView.count
        for i in 0 ..< nb {
            tabLayersView[i].isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(searchPhotoToReplace(tap: )))
            tabLayersView[i].addGestureRecognizer(tap)
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
            imagePicker?.allowsEditing = true
            }
        }
   
    // recherche photo avec le tap... selector  dans le viewDidload
    @objc func searchPhotoToReplace(tap: UITapGestureRecognizer) {
        tagOfTap = tap.view?.tag ?? 0
        guard imagePicker != nil else { return }
        let alert = UIAlertController(title: "Choisir une photo", message: "dans la photothéque ou prendre une photo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Appareil photo", style: .default) { (act) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker?.sourceType = .camera
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        let library = UIAlertAction(title: "photothéque", style: .default) { (act) in self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        let exit = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(exit)
        self.present(alert, animated: true, completion: nil)
        
    }
// le tag de l'image permet de retrouver l'image et le calque
// tag 32 => calque 3 image 2
    func ImageOfTheTag(_ tag:Int){
//            tag: 11 image: tabLayersView1[0]
//            tag: 12 image: tabLayersView1[1]
//            tag: 13 image: tabLayersView1[2]
//            tag: 21 image: tabLayersView2[0]
//            tag: 22 image: tabLayersView2[1]
//            tag: 23 image: tabLayersView2[2]
//            tag: 31 image: tabLayersView3[0]
//            tag: 32 image: tabLayersView3[1]
//            tag: 33 image: tabLayersView3[2]
//            tag: 41 image: tabLayersView4[0]
//            tag: 44 image: tabLayersView4[1]
//            tag: 44 image: tabLayersView4[2]
        
        switch tag {
        case 11:
            tabLayersView1[0].image = alternateImage
            tabLayersView1[0].contentMode = .scaleToFill
            alternateImage = nil
        case 12:
            tabLayersView1[1].image = alternateImage
            alternateImage = nil
        case 13:
            tabLayersView1[2].image = alternateImage
            alternateImage = nil
        case 21:
            tabLayersView2[0].image = alternateImage
            alternateImage = nil
        case 22:
            tabLayersView2[1].image = alternateImage
            alternateImage = nil
        case 23:
            tabLayersView2[2].image = alternateImage
            tabLayersView2[2].contentMode = .scaleToFill
            alternateImage = nil
        case 31:
            tabLayersView3[0].image = alternateImage
            alternateImage = nil
        case 32:
            tabLayersView3[1].image = alternateImage
            alternateImage = nil
        case 33:
            tabLayersView3[2].image = alternateImage
            alternateImage = nil
        case 34:
            tabLayersView3[3].image = alternateImage
            alternateImage = nil
        case 41:
            tabLayersView4[0].image = alternateImage
            tabLayersView4[0].contentMode = .scaleToFill
            alternateImage = nil
        case 42:
            tabLayersView4[1].image = alternateImage
            alternateImage = nil
        case 43:
            tabLayersView4[2].image = alternateImage
            alternateImage = nil
        default:
            print("autre")
        }
   }
    
    // après le choix de l'image - remplacement dans l'UIImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        var photo: UIImage?
        if let edited = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            photo = edited
            
        } else if let original = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            photo = original
        }
        alternateImage = photo
        ImageOfTheTag(tagOfTap)
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

// fin extension de ViewController
